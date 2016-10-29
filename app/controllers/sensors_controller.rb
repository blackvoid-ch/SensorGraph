class SensorsController < ApplicationController
  def index
    @sensors = Sensor.all
  end

  def new
    @sensor = Sensor.new
  end

  def create
    @sensor = Sensor.new(sensor_params)

    if @sensor.save
      redirect_to sensors_path
    else
      render 'new'
    end
  end

  def edit
    @sensor = Sensor.find(params[:id])
  end

  def update
    @sensor = Sensor.find(params[:id])

    if @sensor.update(sensor_params)
      redirect_to sensors_path
    else
      render 'edit'
    end
  end

  def destroy
    @sensor = Sensor.find(params[:id])
    @sensor.destroy

    redirect_to sensors_path
  end

  private
    def sensor_params
      params.require(:sensor).permit(:title, :description)
    end
end
