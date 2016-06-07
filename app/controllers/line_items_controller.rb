class LineItemsController < ApplicationController

  def create
    if !!current_cart
      line_item = current_user.current_cart.add_item(params[:item_id])
      line_item.save
    else
      current_user.current_cart = current_user.carts.create
      line_item = current_user.current_cart.add_item(params[:item_id])
      line_item.save
    end
    redirect_to current_cart
  end

end
