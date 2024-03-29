class Admin::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def new
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.new
    authorize [:admin, @room]
  end

  def show
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.find(params[:id])
    authorize [:admin, @room]
  end

  def edit
    authorize [:admin, @room]
  end

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @room = @hotel.rooms.new(room_params)
    authorize [:admin, @room]
    if @room.save
      redirect_to admin_hotel_room_path(@hotel, @room), notice: 'Room was successfully created.'
    else
      render :new
    end
  end
  
  def update
    authorize [:admin, @room]
    if @room.update(room_params)
      redirect_to admin_hotel_room_path(@hotel, @room), notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize [:admin, @room]
    @room.destroy
    redirect_to admin_hotel_path(@hotel), notice: 'Room was successfully destroyed.'
  end

  private
  def set_room
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :amount_of_beds, :price, :image, gallery: [])
  end

end
