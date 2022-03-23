class BookingsController < ApplicationController
  def create
    @booking = Booking.new(params_booking)
    @course = Course.find(params[:course_id])
    @booking.course = @course
    @booking.user = current_user
    # @booking.total_price = total_price(@booking) if @booking.end_date && @booking.begin_date
    authorize @booking
    if @booking.save
      flash[:notice] = 'Your request has been sent'
      redirect_to course_path(@course)
    else
      redirect_to course_path(@course)
      flash[:notice] = 'ERROR'
    end
  end

  def destroy
  end

  private

  def params_booking
    params.require(:booking).permit(:begin_date, :end_date)
  end

  # def total_price(booking)
  #   ((booking.end_date.to_date - booking.begin_date.to_date).to_i + 1) * booking.course.daily_price
  # end

end
