class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  enum status: %w(packaged pending shipped cancelled)

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  def self.by_status
    order(status: :asc)
  end

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_count
    items.sum(:quantity)
  end

  def cancel
    update(status: "cancelled")
    item_orders.where(status: "fulfilled").each do |item_order|
      item_order.item.increment!(:inventory, item_order.quantity)
    end
    item_orders.update(status: "unfulfilled")
  end
end
