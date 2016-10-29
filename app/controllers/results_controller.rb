class ResultsController < ApplicationController
  protect_from_forgery except: :create

  def new
     @label = Label.new
  end

  def create
    @label = Label.find(params[:label])

    if @label.results.create(result_params)
      redirect_to sensors_path
    end
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    redirect_to sensors_path
  end

  private
    def result_params
      params.require(:result).permit(:value)
    end
end
