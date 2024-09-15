class User < ApplicationRecord
  require 'csv'

  belongs_to :school
  # composed_of :post_code,
  #             class_name: 'PostCode',
  #             mapping: %w(post_code value)
  composed_of :full_name,
              class_name: 'FullName',
              mapping: [%w(first_name first_name), %w(last_name last_name)]

  enum sex: { male: 0, female: 1 }

  class << self
    def csv_format(users)
      CSV.generate do |csv|
        csv << ["ID", "性", "名", "年齢", "性別", "給料"]
        previous_age = nil

        users.each do |user|
          csv << format_user_row(user, previous_age)
          previous_age = user.age
        end
      end
    end

    def format_user_row(user, previous_age)
      age = user.age == previous_age ? nil : user.age
      [user.id, user.first_name, user.last_name, age, user.sex, user.salary]
    end
  end

  def post_code_valid?
    post_code.valid?
  end
end
