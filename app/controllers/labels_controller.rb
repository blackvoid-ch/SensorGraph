class LabelsController < ApplicationController
  def show
    @label = Label.find(params[:id])
    render 'success'
  end

  def new
    @sensor = Sensor.find(params[:sensor])
    @label = @sensor.labels.new
  end

  def create
    @sensor = Sensor.find(params[:sensor])

    if @sensor.labels.create(label_params)
      @label = @sensor.labels.last
      render 'success'
    else
      render 'new'
    end
  end

  def edit
    @label = Label.find(params[:id])
    @sensor = @label.sensor
  end

  def update
    @label = Label.find(params[:id])
    @sensor = @label.sensor

    if @label.update(label_params)
      redirect_to sensors_path
    else
      render 'edit'
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy

    redirect_to sensors_path
  end

  private
    def label_params
      params.require(:label).permit(:title, :group_mode, :time_range)
    end
end
