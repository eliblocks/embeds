class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :videos
  has_many :plays
  has_one :account
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def subtract_balance(play)
    new_balance = balance - play.duration
    update(balance: new_balance)
  end
end
