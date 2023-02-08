class CartItem < ApplicationRecord

  validates :amount, presence: true

  belongs_to :customer
  belongs_to :item

  # 小計を求めるメソッド
  def subtotal
    # with_tax_priceはitemモデルで定義
    item.with_tax_price * amount
  end
end
