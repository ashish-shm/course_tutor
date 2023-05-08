# frozen_string_literal: true

json.array! @courses.each do |course|
  json.extract! course, :id, :title, :description, :category
  json.tutors course.tutors do |tutor|
    json.extract! tutor, :id, :first_name, :last_name, :email
  end
end
