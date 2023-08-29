class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def initialize_transaction
    room = Room.find(params[:room_id])
    
    if room.rental_status == 'Available'
      paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
      transactions = PaystackTransactions.new(paystack)
  
      amount_kobo = (room.rent_amount * 100).to_i
      email = current_user.email
  
      payment_reference = generate_reference
      result = transactions.initializeTransaction(
        reference: payment_reference,
        amount: amount_kobo,
        email: email
      )

      if result['status'] == true
        auth_url = result['data']['authorization_url']
        room.update(payment_reference: payment_reference)  # Store payment reference in the room
        redirect_to auth_url, allow_other_host: true
      else
        flash[:alert] = 'Payment initiation failed. Please try again later.'
        redirect_to root_path
      end
    else
      flash[:alert] = 'Payment has already been made for this room!'
      redirect_to root_path
    end
  end

  def callback
    paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    transactions = PaystackTransactions.new(paystack)
  
    transaction_reference = params[:reference]
    result = transactions.verify(transaction_reference)
  
    if result['status'] == true && result['data']['status'] == 'success'
      room = Room.find_by(payment_reference: transaction_reference)
      
      if room

        existing_rental = Rental.find_by(room_id: room.id, renter_id: current_user.id)
      
        if existing_rental
          redirect_to rental_path(existing_rental), notice: 'Payment successful!'
        else
          payment_date = Time.current
          rent_date = payment_date + 365.days

          room.update(
            rental_status: 'Rented',
            payment_reference: transaction_reference,
          )
          
          rental = Rental.create(
            room_id: room.id,
            renter_id: current_user.id,
            rent_date: rent_date, # Set the appropriate rent date
            rent_duration: 365,   # Set the appropriate rent duration
            payment_reference: transaction_reference,
            payment_date: payment_date,
            payment_status: 'paid',
            payment_amount: room.rent_amount
          )
          
        redirect_to rental_path(rental), notice: 'Payment successful!'
        end
      else
        redirect_to root_path, alert: 'Room not found!'
      end
    else
      redirect_to root_path, alert: 'Payment verification failed!'
    end
  end

  def webhook
    paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    webhook = PaystackWebhooks.new(paystack)

    # Verify the signature of the incoming webhook event
    verified = webhook.verify_webhook_signature(request)

    if verified
      event = webhook.process_webhook(request)
      
      # Handle specific webhook events
      case event['event']
      when 'charge.success'
        # Handle successful payment event
        handle_successful_payment(event)
      when 'charge.failure'
        # Handle failed payment event
        handle_failed_payment(event)
      # Add more cases for other events you want to handle
      else
        # Handle unrecognized event
        handle_unrecognized_event(event)
      end
    else
      # Invalid webhook signature
      head :bad_request
    end
  end
  

  private

  def generate_reference
    # Generate a unique reference for the transaction
    "ref-#{SecureRandom.hex(6)}"
  end


  def handle_successful_payment(event)
    transaction_reference = event['data']['reference']
    amount_paid = event['data']['amount']

    room = Room.find_by(payment_reference: transaction_reference)
    
    if room

      existing_rental = Rental.find_by(room_id: room.id, renter_id: current_user.id)

      if existing_rental
        redirect_to rental_path(existing_rental), notice: 'Payment successful!'
      else

        payment_date = Time.now
        rent_date = payment_date + 365.days
        room.update(
          rental_status: 'Rented',
          payment_reference: transaction_reference,
        )
        
        rental = Rental.create(
          room_id: room.id,
          renter_id: current_user.id,
          rent_date: rent_date,
          rent_duration: 365,
          payment_reference: transaction_reference,
          payment_date: payment_date,
          payment_status: 'paid',
          payment_amount: amount_paid / 100  # Convert from kobo to naira
        )
      end
      # Send notifications, update user status, or perform other actions as needed
      
    else
      # Handle case where room is not found
    end
  end

  def handle_failed_payment(event)
    # Retrieve necessary data from the event
    transaction_reference = event['data']['reference']
    failure_reason = event['data']['gateway_response']
    # ... Retrieve other relevant data from the event

    # Update your application's data or take appropriate actions for a failed payment
    room = Room.find_by(payment_reference: transaction_reference)
    
    if room
      room.update(payment_reference: nil, rental_status: 'Available')  # Clear the payment reference
      
      # Send notifications to users, update user status, or perform other actions as needed
      # You might also want to log the failure reason or take further actions
      
    else
      # Handle case where room is not found
    end
  end

end
