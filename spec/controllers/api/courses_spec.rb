# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::CoursesController, type: :request do
  let(:standard_user) { create(:user, :standard) }
  let(:admin_user) { create(:user, :admin) }

  describe "create courses with its tutors" do
    let(:course_params) do
      {
        course: {
          title: "How to learn personal finance",
          description: "This course helps you to save money",
          category: "finance",
          tutors_attributes: [{
            first_name: "Test",
            last_name: "One",
            email: "test1@example.com"
          },
        {
          "first_name": "Test",
          "last_name": "Two",
          "email": "test2@example.com"
        }]
        }
      }
    end
    context "POST to 'api/courses'" do
      it "returns unauthorized if user is not authenticated" do
        post api_courses_path
        expect(response).to have_http_status(401)
      end

      it "returns forbidden if user is not admin" do
        post api_courses_path, headers: headers(standard_user)
        expect(response).to have_http_status(403)
      end

      it "creates the course with its tutors successfully" do
        post api_courses_path, headers: headers(admin_user), params: course_params
        expect(response).to have_http_status(200)
        response_body = JSON.parse(response.body)

        expect(response_body["notice"]).to eq "Course & its tutors are added successfully"
        expect(Course.count).to eq 1
        expect(Tutor.count).to eq 2
      end

      it "validates the empty params" do
        params = {
          course: {
            title: "",
            description: "",
            category: "",
            tutors_attributes: [{
              first_name: "",
              last_name: "",
              email: ""
            }]
          }
        }
        post(api_courses_path, headers: headers(admin_user), params:)
        expect(response).to have_http_status(422)
        response_body = JSON.parse(response.body)

        expected_errors = ["Tutors first name can't be blank", "Tutors last name can't be blank",
                          "Tutors email can't be blank", "Tutors email is invalid", "Category is not included in the list", "Title is too short (minimum is 3 characters)", "Description is too short (minimum is 10 characters)"]
        expect(response_body["errors"]).to match_array expected_errors
      end

      it "validates the invalid params" do
        params = {
          course: {
            title: "GG",
            description: "Test",
            category: "none",
            tutors_attributes: [{
              first_name: "AA",
              last_name: "SH",
              email: "aash@"
            }]
          }
        }
        post(api_courses_path, headers: headers(admin_user), params:)
        expect(response).to have_http_status(422)
        response_body = JSON.parse(response.body)

        expected_errors = ["Tutors email is invalid", "Category is not included in the list",
                            "Title is too short (minimum is 3 characters)", "Description is too short (minimum is 10 characters)"]
        expect(response_body["errors"]).to match_array expected_errors
      end
    end
  end

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
