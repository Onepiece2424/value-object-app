class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  private
  def companies_params
    params.require(:company).permit(:post_code)
  end
end
