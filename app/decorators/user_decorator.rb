module UserDecorator
  def formatting_post_codes
    post_code.present? ? post_code.to_s.insert(3, '-') : ""
  end
end
