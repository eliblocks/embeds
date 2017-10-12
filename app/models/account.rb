class Account < ApplicationRecord
  belongs_to :user


  def subtract_balance(play)
    new_balance = balance - play.duration
    update(balance: new_balance)
  end
end
