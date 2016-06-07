class CartsController < ApplicationController
  before_filter :authenticate_user!


  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    @cart = current_cart
    @cart.checkout
    current_user.current_cart.destroy
    current_user.save
    redirect_to cart_path(@cart)
  end


end
