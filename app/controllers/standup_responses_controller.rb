class StandupResponsesController < ApplicationController
  def index
    @responses = StandupResponse.all
  end
end
