class StaticPagesController < ApplicationController
  def home
      @feed_items = Product.paginate(page: params[:page])
      @categories = Category
  end

  def help
  end

  def about
  end
  
  def contact
  end

end
