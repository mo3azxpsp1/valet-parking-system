class BaysController < ApplicationController
  before_action :set_bay, only: [:show, :edit, :update, :destroy, :parked_cars, :collect_car, :move_car]

  # GET /bays
  # GET /bays.json
  def index
    @bays = Bay.all
  end

  # GET /bays/1
  # GET /bays/1.json
  def show
  end

  # GET /bays/new
  def new
    @bay = Bay.new
  end

  # GET /bays/1/edit
  def edit
  end

  # POST /bays
  # POST /bays.json
  def create
    @bay = Bay.new(bay_params)

    respond_to do |format|
      if @bay.save
        format.html { redirect_to @bay, notice: 'Bay was successfully created.' }
        format.json { render :show, status: :created, location: @bay }
      else
        format.html { render :new }
        format.json { render json: @bay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bays/1
  # PATCH/PUT /bays/1.json
  def update
    respond_to do |format|
      if @bay.update(bay_params)
        format.html { redirect_to @bay, notice: 'Bay was successfully updated.' }
        format.json { render :show, status: :ok, location: @bay }
      else
        format.html { render :edit }
        format.json { render json: @bay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bays/1
  # DELETE /bays/1.json
  def destroy
    @bay.destroy
    respond_to do |format|
      format.html { redirect_to bays_url, notice: 'Bay was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def parked_cars
    @bays_cars = @bay.bays_cars.where.not(parked_at: nil).where(left_at: nil).includes(:car).order(:parked_at)
  end

  def collect_car
    bay_car = @bay.bays_cars.find(params['bay_car_id'])
    if @bay.size == 'double' && @bay.no_of_parking_cars == 2
      new_bay_car = @bay.bays_cars.where.not(parked_at: nil, id: params['bay_car_id']).where(left_at: nil).first
      if bay_car.parked_at < new_bay_car.parked_at
        flash[:notice] = "You have to move the second car first!"
        redirect_to action: 'parked_cars', id: @bay.id and return
      end
    end
    bay_car.update(left_at: Time.now)
    @bay.update(is_available: true)
    no_of_hours = ((Time.now - bay_car.parked_at) / 1.hour).ceil
    fees = 10 * no_of_hours
    flash[:notice] = "Car was successfully collected. Your fees for #{no_of_hours} parking hours is $#{fees}"
    redirect_to action: "index"
  end

  def move_car
    bay_car = @bay.bays_cars.find(params['bay_car_id'])
    new_bay = Bay.where(is_available: true).first
    if new_bay.present?
      bay_car.update(left_at: Time.now)
      new_bay.cars << bay_car.car
      new_bay.update(is_available: false) if (new_bay.size == 'single' && new_bay.bays_cars.where(left_at: nil).size == 1) || ((new_bay.size == 'double' && new_bay.bays_cars.where(left_at: nil).size == 2))
      new_bay.bays_cars.find_by(car_id: bay_car.car.id).update(parked_at: bay_car.parked_at)
      @bay.update(is_available: true)
      flash[:notice] = "car successfully moved to bay #{new_bay.number}"
      redirect_to action: 'parked_cars', id: @bay.id
    else
      flash[:notice] = "no vacant bays"
      redirect_to action: 'parked_cars', id: @bay.id
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bay
      @bay = Bay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bay_params
      bp = params.require(:bay).permit(:number, :size, :is_available)
      bp[:size] = params[:bay][:size].to_i
      bp
    end
end
