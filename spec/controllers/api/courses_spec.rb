# encoding: UTF-8
# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::CoursesController, type: :request do
  let(:standard_user) { create(:user, :standard) }
  let(:admin_user) { create(:user, :admin_user) }

  describe "get courses with its tutors" do
    let!(:course) { create(:course) }
    let!(:tutor_one) { create(:tutor, course:) }
    let!(:tutor_two) { create(:tutor, course:) }

    context "with GET to 'api/courses'" do

      it "returns unauthorized if user is not authenticated" do
        get api_courses_path
        expect(response).to have_http_status(401)
      end

      it "returns all courses with their tutors" do
        get api_courses_path, headers: headers(standard_user)
        expect(response).to have_http_status(200)
        response_body = JSON.parse(response.body)

        expect(response_body.count).to eq 1
        expect(response_body.first["tutors"].count).to eq 2
      end

      it "returns correct response for course & its tutors" do
        get api_courses_path, headers: headers(standard_user)
        expect(response).to have_http_status(200)
        response_body = JSON.parse(response.body)

        expect(response_body.first["id"]).to eq course.id
        expect(response_body.first["tutors"].first["id"]).to eq tutor_one.id
        expect(response_body.last["tutors"].last["id"]).to eq tutor_two.id

      end
    end
  end

end
