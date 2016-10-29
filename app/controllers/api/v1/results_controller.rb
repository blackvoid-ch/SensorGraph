class Api::V1::ResultsController < ApplicationController
  protect_from_forgery except: :create

  def create
    @label = Label.find(params[:label])

    if @label.results.create(result_params)
      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private
    def result_params
      params.require(:result).permit(:value)
    end
end
