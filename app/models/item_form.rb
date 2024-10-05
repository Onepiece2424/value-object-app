class ItemForm
  include ActiveModel::Model

  attr_accessor :name, :description, :price, :stock, :production_dates, :production_dates_attributes

  validates :name, :description, :price, :stock, presence: true

  def save_item_with_dates
    return false unless valid?

    # 新しい Item インスタンスを作成
    item = Item.new(
      name: name,
      description: description,
      price: price,
      stock: stock
    )

    # production_dates を処理
    if production_dates.present?
      # _destroy が "true" ではない場合のみ作成
      unless production_dates[:_destroy] == "true"
        item.production_dates.build(manufacture_date: production_dates[:manufacture_date])
      end
    end

    # production_dates_attributes を処理
    production_dates_attributes.each do |_, date_attributes|
      # _destroy が "true" ではない場合のみ作成
      next if date_attributes[:_destroy] == "true"

      item.production_dates.build(manufacture_date: date_attributes[:manufacture_date])
    end

    # Item を保存
    item.save!
  end
end
