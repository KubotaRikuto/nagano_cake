class OrderDetail < ApplicationRecord
  enum making_status: { not_available: 0, waiting_making: 1, making_progress: 2, completed: 3 }

  belongs_to :order
  belongs_to :item

  # 小計を求めるメソッド
  def subtotal
    # with_tax_priceはitemモデルで定義
    item.with_tax_price * amount
  end
end
