require "pry"
class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(from_account, to_account, amount)
    @sender = from_account
    @receiver = to_account
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    #binding.pry
    if !(self.valid?)||@sender.balance-@amount<0
      @status="rejected"
      return "Transaction rejected. Please check your account balance."
    end
    while self.status=="pending"
      @sender.balance-=@amount
      @receiver.balance+=@amount
      @status = 'complete'
    end
  end

  def reverse_transfer
    while @status=="complete"
      @sender.balance+=@amount
      @receiver.balance-=@amount
      @status="reversed"
    end
  end
end
