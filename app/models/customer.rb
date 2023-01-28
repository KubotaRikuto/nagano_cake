class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: 'カタカナで入力して下さい。'}
  validates :email, uniqueness: true


  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

end
