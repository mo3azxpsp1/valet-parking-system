class CarsController < ApplicationController

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    if @car.save
      bay = Bay.find(car_params['bay_id'])
      bay.cars << @car
      bay.update(is_available: false) if (bay.size == 'single' && bay.bays_cars.where(left_at: nil).size == 1) || ((bay.size == 'double' && bay.bays_cars.where(left_at: nil).size == 2))
      bay.bays_cars.find_by(car_id: @car.id).update(parked_at: Time.now)
      flash[:notice] = 'Car was successfully parked.'
      redirect_to :controller => 'bays'
    else
      render :new
    end
  end

  def track_all_cars
    @cars = BaysCar.includes(:car).where.not(parked_at: nil).where(left_at: nil).order(:parked_at)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:model, :owner, :plate_no, :bay_id)
    end
end
