class CartItem < ApplicationRecord

  validates :amount, presence: true

  belongs_to :customer
  belongs_to :item

  # 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
end
