class ItemsController < ApplicationController
  def index
    @items = Item.preload(:production_dates).all
  end

  def new
    @item = Item.new
    @item.production_dates.build
  end

  def create
    form = ItemForm.new(item_params)
    if form.save_item_with_dates
      redirect_to items_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :price, :stock,
      production_dates: [:manufacture_date, :_destroy],
      production_dates_attributes: [:manufacture_date, :_destroy]
    )
  end
end
