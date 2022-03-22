class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
    @courses = @courses.where(sport: params.dig(:search, :sport)) if params.dig(:search, :sport).present?
    @schools = School.all
    @schools = @schools.near(params.dig(:search, :address), params.dig(:search, :distance) || 30) if params.dig(:search, :address).present?

    @markers = @schools.geocoded.map do |school|
      {
        lat: school.latitude,
        lng: school.longitude
      }
    end
  end

  def show
    raise
  end
end
