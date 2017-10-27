class Charge < ApplicationRecord
  belongs_to :user

  def create_from_transaction(transaction)
    seconds = Rails.configuration.rate * transaction.amount.to_i

    save!(
      seconds: seconds,
      gateway_charge_id: transaction.id,
      amount: transaction.amount.to_i,
    )

    user.account.add_balance(seconds)
  end
end
