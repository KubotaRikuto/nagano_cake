class ChangeColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:orders, :postage, from: nil, to: 800)
  end
end
