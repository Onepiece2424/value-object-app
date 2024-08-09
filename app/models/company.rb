class Company < ApplicationRecord
  composed_of :post_code,
              class_name: 'PostCode',
              mapping: %w(post_code value)

  def post_code_valid?
    post_code.valid?
  end
end
