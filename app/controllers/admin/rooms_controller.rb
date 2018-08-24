class Admin::RoomsController < Admin::BaseController
  before_action :find_room, only: [:show, :edit, :update]

  def index
    @rooms = Room.page(params[:page]).per Settings.admin.per_page
  end

  def new
    @room = Room.new
    @map = %w(aaaaaa aaaaaa aaaaaa aaaaaa aaaaaa)
    attach_map @room, @map
  end

  def create
    @room = Room.new name: room_params[:name]
    @map = map_params
    attach_map @room, @map
    if @room.save
      flash[:success] = t "flash.create_room_success"
      redirect_to admin_room_url @room
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    return if @room
    redirect_to root_url
    flash[:danger] = t "flash.no_room"
  end

  def edit
    @map = @room.full_a_map
  end

  def update
    ActiveRecord::Base.transaction do
      @room.attach_map map_params
      @room.change_name room_params[:name]
      flash[:success] = t "flash.edit_success"
      redirect_to admin_room_url @room
    end
  rescue StandardError
    flash[:danger] = t "flash.edit_faild"
    redirect_to edit_admin_room_url @room
  end

  private

  def room_params
    params.require(:room).permit :name
  end

  def map_params
    params.require(:field_map).split ","
  end

  def attach_map room, map
    map.each_with_index do |row, row_index|
      row.split("").each_with_index do |pos, pos_index|
        next unless pos == "a"
        room.seats.build row: row_index + 1, number: pos_index + 1
      end
    end
    room.seat_no = room.seats.size
  end

  def find_room
    @room = Room.find_by id: params[:id]

    return if @room
    flash[:danger] = t "flash.no_room"
    redirect_to root_url
  end
end
