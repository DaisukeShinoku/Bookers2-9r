class RoomsController < ApplicationController
    before_action :authenticate_user!
  def show
    @room = Room.find(params[:id])
    #present?の戻り値は真偽値。よって、trueの場合、
    if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
      @chats = @room.chats
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "DM")
    @user_room1 = UserRoom.create(:room_id => @room.id, :user_id => current_user.id)
    @user_room2 = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end
end
