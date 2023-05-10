# Course and Tutor Application

It's a rails application that allows users to create & list courses along with their tutors. This project includes two API's:
* Common POST API to create a course & its tutors
* GET API to list all the courses along with their tutors

## Pre-requisites
It uses `Ruby 3.2.1`, `Ruby on Rails 7.0.4.3` and `Postgresql` for the database.

## Getting started
1. Clone the repository.
2. Run `bin/setup` to install the dependencies, prepare the database & create an admin user for authorisation.
3. Run `bundle exec rails server` to start the Rails server.
4. Run `bundle exec rspec` to run the Rspec tests for the API's.
 
## Authentication & Authorisation
1. Each user has an authentication token attribute which gets created upon user creation.
2. Add `X-Auth-Email` & `X-Auth-Token` in the request headers so that user making the API request can be authenticated. eg:
```json
X-Auth-Email: 'admin@example.com'
X-Auth-Token: 'ByDy8KK9kjmkYmUz4khs'
```
3. User has two roles in this application i.e standard & admin. An admin user is authorised to create courses with the tutors while standard user can list all the courses with the tutors.
4. On running `bin/setup` an admin user is also created which can be used for courses creation. 

## API's

### 1. Create course with its tutors `POST api/courses`

#### `Request Payload`
```json
{
    "course": {
        "title": "Learn personal finance",
        "description": "This course helps you to save money",
        "category": "finance",  (Categories can be finance, development or gaming.)
        "tutors_attributes": [{
            "first_name": "Test",
            "last_name": "One",
            "email": "test1@example.com"
        },
        {
            "first_name": "Test",
            "last_name": "Two",
            "email": "test2@example.com"
        }]
    }
}
```

#### `Response`
```json
{
    "notice": "Course & its tutors are added successfully",
    "id": "d4242c94-dfee-4c04-b01c-6fe68dbd7a83",
    "title": "Learn personal finance",
    "description": "This course helps you to save money",
    "category": "finance",
    "tutors": [
        {
            "id": "d99964cd-5b27-4771-a99c-6b10ec8149cf",
            "first_name": "Test",
            "last_name": "One",
            "email": "test1@example.com"
        },
        {
            "id": "0c276668-bf70-49f2-ac86-5b45c310d328",
            "first_name": "Test",
            "last_name": "Two",
            "email": "test2@example.com"
        }
    ]
}
```



### 2. Get list of courses with its tutors `GET api/courses`
#### For pagination add `page_size` & `page_no` params such as `GET api/courses?page_size=5&page_no=2`
#### `Response`
```json
[
    {
        "id": "96741859-a912-46b7-aba7-a884193d73cc",
        "title": "Learn personal finance",
        "description": "This course helps you to save money",
        "category": "finance",
        "tutors": [
            {
                "id": "9eb9d55d-f867-4257-8b54-295678690a60",
                "first_name": "Test",
                "last_name": "One",
                "email": "test1@example.com"
            },
            {
                "id": "55dda6a1-c862-438e-ae28-0ff8c579aa16",
                "first_name": "Test",
                "last_name": "Two",
                "email": "test2@example.com"
            }
        ]
    },
    {
        "id": "06c1cff5-5c27-4aee-9746-4a449cde09cb",
        "title": "Learn Ruby on rails",
        "description": "This course helps you to learn ROR",
        "category": "finance",
        "tutors": [
            {
                "id": "1fc539e2-a9d6-46a8-bcb8-3839b097926f",
                "first_name": "Test",
                "last_name": "Three",
                "email": "test3@example.com"
            },
            {
                "id": "64dc75bc-b2f7-4678-a4f3-4ad36a9c8f67",
                "first_name": "Test",
                "last_name": "Four",
                "email": "test4@example.com"
            }
        ]
    }
]
```

Made with :heart: and ![Ruby](https://img.shields.io/badge/-Ruby-000000?style=flat&logo=ruby)
