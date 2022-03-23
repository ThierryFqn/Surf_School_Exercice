class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
    @courses = @courses.where(sport: params.dig(:search, :sport)) if params.dig(:search, :sport).present?
    @schools = School.all
    @schools = School.near(params.dig(:search, :address), params.dig(:search, :distance) || 30) if params.dig(:search, :address).present?
    # @schools = @schools.near(params.dig(:search, :address), params.dig(:search, :distance) || 30) if params.dig(:search, :address).present?
    # near = School.near(params.dig(:search, :address), params.dig(:search, :distance) || 30)
    # @courses = @courses.joins(:school).merge(near) if params.dig(:search, :address).present?

    @markers = @schools.geocoded.map do |school|
      {
        lat: school.latitude,
        lng: school.longitude
      }
    end
  end

  def show
    @course = Course.find(params[:id])
    @booking = Booking.new
    authorize @course
  end
end
