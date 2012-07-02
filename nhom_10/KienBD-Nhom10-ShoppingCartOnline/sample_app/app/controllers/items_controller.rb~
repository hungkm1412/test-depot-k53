class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      flash[:success] = "Added successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
  end
  
end

