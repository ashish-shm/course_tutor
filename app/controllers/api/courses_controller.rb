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
        render status: :unprocessable_entity, json: { message: @course.errors.full_messages }
      end
    end

    private

      def course_params
        params.require(:course).permit(
          :title, :description, :category,
          tutors_attributes: %i[first_name last_name email])
      end

      def load_courses_with_tutors
        @courses = Course.all
      end
  end
end
