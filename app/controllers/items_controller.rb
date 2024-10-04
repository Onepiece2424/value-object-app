class ItemsController < ApplicationController
  def index
    @items = Item.preload(:production_dates).all
  end

  def new
    @item = Item.new
    @item.production_dates.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :stock, production_dates_attributes: [:id, :manufacture_date, :_destroy])
  end
end
