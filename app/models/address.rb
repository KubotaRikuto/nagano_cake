class Address < ApplicationRecord
  belongs_to :customer

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
