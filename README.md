# Course and Tutor Application

This project includes the following API's

* Common POST API to create a course & its tutors

`POST api/courses`

`Request Payload`
```json
{
    "course": {
        "title": "Learn personal finance",
        "description": "This course helps you to save money",
        "category": "finance",
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

`Response`
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


* GET API to list all the courses along with their tutors

`GET api/courses`

`Response`
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
