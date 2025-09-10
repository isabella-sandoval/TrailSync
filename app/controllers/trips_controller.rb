class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: %i[ show edit update destroy ]

  # GET /trips or /trips.json
  def index
    @trips = current_user&.trips&.recent || Trip.none
    @upcoming_trips = current_user&.trips&.upcoming&.limit(3) || Trip.none
    @past_trips = current_user&.trips&.past&.limit(5) || Trip.none
  end

  # GET /trips/1 or /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = current_user.trips.build
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips or /trips.json
  def create
    @trip = current_user.trips.build(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: "Trip was successfully created." }
        format.turbo_stream { 
          @trips = current_user.trips.recent
          render turbo_stream: [
            turbo_stream.replace("trips_list", partial: "trips_list", locals: { trips: @trips }),
            turbo_stream.replace("new_trip_form", partial: "trip_created_success", locals: { trip: @trip })
          ]
        }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace("new_trip_form", partial: "form", locals: { trip: @trip })
        }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1 or /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: "Trip was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1 or /trips/1.json
  def destroy
    @trip.destroy!

    respond_to do |format|
      format.html { redirect_to trips_path, notice: "Trip was successfully destroyed.", status: :see_other }
      format.turbo_stream { 
        @trips = current_user.trips.recent
        render turbo_stream: turbo_stream.replace("trips_list", partial: "trips_list", locals: { trips: @trips })
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = current_user.trips.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_params
      params.expect(trip: [ :title, :date, :notes ])
    end
end
