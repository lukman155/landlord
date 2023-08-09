class PaymentsController < ApplicationController
  def initialize_transaction
    paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    transactions = PaystackTransactions.new(paystack)

    result = transactions.initializeTransaction(
      reference: generate_reference,
      amount: 300000, # Amount in kobo (e.g., 300000 kobo = 3000 NGN),
      email: "customer@example.com"
    )

    auth_url = result['data']['authorization_url']
    redirect_to auth_url, allow_other_host: true
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
