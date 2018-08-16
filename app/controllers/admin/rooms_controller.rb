class Admin::RoomsController < Admin::BaseController
  def new
    if params[:field_map]
      @support = new_room params[:field_map], params[:field_deleted_seats]
      respond_to do |format|
        format.js
      end
    else
      @support = new_room %w(aaaaaa aaaaaa aaaaaa aaaaaa aaaaaa), []
    end
  end

  def create
    @room = Room.new
    set_map @room, params_map
    if @room.save
      flash[:success] = t "flash.create_room_success"
      redirect_to admin_room_url(@room)
    else
      @support = new_room params_map, params_deleted_seats
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @room = Room.find_by id: params[:id]
    return if @room
    redirect_to root_url
    flash[:danger] = t "flash.no_room"
  end

  private

  def params_map
    params.require(:field_map).split ","
  end

  def params_deleted_seats
    params.require(:field_deleted_seats).split ","
  end

  def new_room map, deleted_seats
    room = Room.new
    set_map room, map
    row_num = room.row_num
    max_seat_per_row = room.max_seat_per_row
    deleted_seats ||= []
    AdminRoomSupport.new room, row_num, max_seat_per_row, deleted_seats, map
  end

  def set_map room, map
    map.each_with_index do |row, row_index|
      row.split("").each_with_index do |pos, pos_index|
        room.seats.build row: row_index + 1, number: pos_index + 1 if pos == "a"
      end
    end
    room.seat_no = room.seats.size
  end
end
