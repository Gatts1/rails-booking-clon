class Admin::HotelsController < ApplicationController
  before_action :authorize_hotel , only: [:index, :new, :edit, :show, :create, :update,:destroy, :metrics]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :user_notification_booking_deleted, only: [:destroy]
  
  def index
    @hotels = Hotel.all
    render nothing: true, status: :ok
  end

  def edit
  end

  def show
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      redirect_to admin_hotel_path(@hotel), notice: 'Hotel was successfully created.'
    else
      render :new
    end
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to admin_hotel_path(@hotel), notice: 'Hotel was successfully updated.'
    else
      render :edit
    end
  end

  def metrics
    @hotels = HotelQueries.new.most_popular
  end

  def destroy
    @hotel.destroy
    redirect_to admin_hotels_path, notice: 'Hotel was successfully destroyed.'
  end

  private
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :email, :city, :country, :address, :image, gallery: [])
  end

  def user_notification_booking_deleted
    @hotel = set_hotel
    @bookings = @hotel.bookings
      if @bookings.any?
        @bookings.each do |booking|
          BookingMailer
          .with(user: booking.user_id, booking: booking)
          .booking_deleted
          .deliver_later
        end
      end
  end

  def  authorize_hotel
    authorize [:admin, Hotel]
  end

end
