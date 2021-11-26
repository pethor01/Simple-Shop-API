class PaymentJob < ApplicationJob
  queue_as :payment

  def perform(order)
    payment_status = [0, 1].sample
    payment = Payment.create(order_id: order.id, status: payment_status)
    if payment_status == 1
      order.update(paid_at: Time.now.to_date, paid: true) 
    end
  end
end