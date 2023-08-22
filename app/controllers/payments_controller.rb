class PaymentsController < ApplicationController
  def initialize_transaction
    room = Room.find(params[:room_id])
    
    if room.payment_status != 'paid'
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
        room.update(
          payment_status: 'paid',
          payment_amount: room.rent_amount,
          payment_date: Time.current
        )
        
        redirect_to root_path, notice: 'Payment successful!'
      else
        redirect_to root_path, alert: 'Room not found!'
      end
    else
      redirect_to root_path, alert: 'Payment verification failed!'
    end
  end
  

  private

  def generate_reference
    # Generate a unique reference for the transaction
    "ref-#{SecureRandom.hex(6)}"
  end
end
