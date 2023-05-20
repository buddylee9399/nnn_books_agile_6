class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    fresh_when etag: @products
    # session[:counter] = nil

    if session[:cart_id].nil? && session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end
end
