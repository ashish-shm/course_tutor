# frozen_string_literal: true

module Api
  class CoursesController < ApplicationController
    before_action :load_courses_with_tutors, only: :index

    def index
      render
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        render
      else
        render status: :unprocessable_entity, json: { errors: @course.errors.full_messages }
      end
    end

    private

      def course_params
        params.require(:course).permit(
          :title, :description, :category,
          tutors_attributes: %i[first_name last_name email])
      end

      def load_courses_with_tutors
        page_no = params[:page_no] || 1
        page_size = params[:page_size] || 10
        @courses = Course.includes(:tutors).offset(page_size * (page_no - 1)).limit(page_size)
      end
  end
end
