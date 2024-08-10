class User < ApplicationRecord
  composed_of :post_code,
              class_name: 'PostCode',
              mapping: %w(post_code value)
  composed_of :full_name,
              class_name: 'FullName',
              mapping: [%w(first_name first_name), %w(last_name last_name)]

  def post_code_valid?
    post_code.valid?
  end
end
