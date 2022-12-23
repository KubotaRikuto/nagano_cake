class OrderDetail < ApplicationRecord
  enum making_status: { not_available: 0, waiting_making: 1, making_progress: 2, completed: 3 }
end
