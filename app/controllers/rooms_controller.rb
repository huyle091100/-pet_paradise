class RoomsController < ApplicationController
  load_and_authorize_resource
  def index
    @rooms = Room.all
  end
  def new
    @room = Room.new
  end

  def create
    room = Room.new room_params
    if room.save
      flash[:notice] = "Create room successfully!"
    else
      flash[:notice] = "Create room failed!"
    end
    redirect_to rooms_path
  end

  def import
    creek = Creek::Book.new(params[:file].tempfile.path, with_headers: true)
    sheet = creek.sheets[0]
    sheet.rows.each_with_index do |row, index|
      next if index == 0 # Skip the header row
      row_values = row.values
      
      room = Room.new(r_type: row_values.first.to_i, weight: row_values[1].to_i, price: row_values[2], quantity: row_values[3])
      if room.save
      else
        next
      end
    end

    redirect_to rooms_path, notice: 'Excel file imported successfully.'
  rescue StandardError => e
    redirect_to rooms_path, alert: "Error importing Excel file: #{e.message}"
  end

  def edit
    @room = Room.find_by id: params[:id]
  end

  def update
    @room = Room.find_by id: params[:id]
    if @room.update room_params
      flash[:notice] = "Update room successfully!"
    else
      flash[:notice] = "Update room failed!"
    end
    redirect_to rooms_path
  end

  def destroy
    Room.find_by(id: params[:id]).destroy
    flash[:notice] = "Delete room successfully."
    # redirect_to "#{request.referer}##{params[:id]}"
    respond_to do |format|
      format.js { render js: "window.location.href = '/rooms';" }
    end
  end

  private

  def room_params
    params.require(:room).permit :r_type, :weight, :price, :quantity
  end
end
