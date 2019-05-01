class Api::HotelsController < ApiController
  before_action :set_hotel, only: [:show, :update, :destroy]

  def index
    render json: Hotel.all
  end

  def show
    render json: Hotel.find(params[:id])
  end

  def create
    hotel = Hotel.new(hotel_params)
    if hotel.save
      render json: hotel, status: :created
    else
      render json: { errors: hotel.errors}
    end
  end

  def update
    if @hotel.update(hotel_params)
      render json: @hotel, status: :ok
    else
      render json: { errors: @hotel.errors}
    end
  end

  def destroy
    @hotel.destroy
    render json: {},status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private    
  def set_hotel 
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.permit(:name, :email, :city, :country,  :address, :image, gallery: [])
  end
end