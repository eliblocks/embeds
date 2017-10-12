class User < ApplicationRecord

  after_create :create_account
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :videos
  has_many :plays
  has_one :account
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable




  def create_account
    account = Account.new(user_id: id)
    if account.save
      print "Account created!!"
    else
      print account.errors.full_messages
    end
  end
end
