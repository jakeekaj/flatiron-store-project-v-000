class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def checkout
    self.status = "submitted"
    self.line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    self.save
  end

  def add_item(item_id)
    added_line_item = self.line_items.find_or_initialize_by(item_id: item_id)
    if added_line_item.quantity == 0
      added_line_item.quantity = 1
    else
      added_line_item.quantity += 1
    end
    added_line_item
  end


  def total
    amount = 0
    self.line_items.each do |li|
      amount += (li.item.price * li.quantity)
    end
    amount
  end


end
