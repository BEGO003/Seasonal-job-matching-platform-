# Seasonal Job Matching API

This document describes the HTTP API for the backend application. It covers the `UserController` and `JobController` endpoints, request/response bodies, status codes, and examples.

## Base URL

- Local development: `http://localhost:8080`

---

## Users

Base path: `/api/users`

### GET /api/users
- Description: Retrieve all users.
- Response: 200 OK
- Response body: JSON array of `UserResponseDTO` objects

UserResponseDTO shape:
```json
{
  "name": "string",
  "country": "string",
  "number": "string (11 digits)",
  "email": "string"
}
```

Example:
```bash
curl -s http://localhost:8080/api/users | jq
```

---

### GET /api/users/{id}
- Description: Retrieve a user by ID.
- Path parameters:
  - `id` (long) - user database id
- Responses:
  - 200 OK: returns `UserResponseDTO`
  - 404 Not Found: user with given id doesn't exist

Example:
```bash
curl -s http://localhost:8080/api/users/1 | jq
```

---

### POST /api/users
- Description: Create a new user.
- Request body: `UserCreateDTO` (JSON)
- Responses:
  - 200 OK: body contains `{ "message": "User created successfully", "user": <UserResponseDTO> }`
  - 400 Bad Request: body contains `{ "error": "..." }`

Example request body:
```json
{
  "name": "Alice",
  "country": "Egypt",
  "number": "01234567890",
  "email": "alice@example.com",
  "password": "secret"
}
```

Example:
```bash
curl -X POST -H "Content-Type: application/json" -d @user.json \
  http://localhost:8080/api/users
```

---

### PATCH /api/users/{id}
- Description: Partially update a user. Only provided fields are updated.
- Request body: `UserEditDTO` (JSON)
- Responses:
  - 200 OK: `{ "message": "User edited successfully", "user": <UserResponseDTO> }`
  - 400 Bad Request: `{ "error": "..." }`
  - 404 Not Found: if user not found

Example request body (update email only):
```json
{
  "email": "new@example.com"
}
```

---

### DELETE /api/users/{id}
- Description: Delete user by ID.
- Responses:
  - 200 OK: `User deleted successfully!`
  - 404 Not Found: if user not found

Example:
```bash
curl -X DELETE http://localhost:8080/api/users/1
```

---

## Jobs

Base path: `/api/jobs`

### GET /api/jobs
- Description: Retrieve all jobs.
- Response: 200 OK, array of `JobResponseDTO`

JobResponseDTO (common fields):
```json
{
  "id": 0,
  "title": "string",
  "description": "string",
  "type": "FULL_TIME | PART_TIME | TEMP",
  "location": "string",
  "startDate": "dd-MM-yyyy",
  "endDate": "dd-MM-yyyy",
  "salary": 0.0,
  "status": "OPEN | CLOSED",
  "numofpositions": 1,
  "workarrangement": "ON_SITE | REMOTE | HYBRID",
  "jobposterId": 0,
  "jobposterName": "string"
}
```

Example:
```bash
curl -s http://localhost:8080/api/jobs | jq
```

---

### GET /api/jobs/{id}
- Description: Get a job by id.
- Responses:
  - 200 OK: JobResponseDTO
  - 404 Not Found: if job doesn't exist

Example:
```bash
curl http://localhost:8080/api/jobs/1
```

---

### POST /api/jobs
- Description: Create a new job.
- Request body: `JobCreateDTO` (JSON)
- Responses:
  - 200 OK: `{ "message": "Job created successfully", "job": <JobResponseDTO> }`
  - 400 Bad Request: `{ "error": "..." }`

Example request body (job create):
```json
{
  "title": "Seasonal Helper",
  "description": "Help with harvest",
  "type": "TEMP",
  "location": "Farmville",
  "startDate": "01-06-2025",
  "endDate": "30-09-2025",
  "salary": 1500.0,
  "status": "OPEN",
  "numofpositions": 5,
  "workarrangment": "ON_SITE",
  "jobposterId": 1
}
```

---

### PATCH /api/jobs/{id}
- Description: Partially update a job. Only provided fields are updated.
- Responses:
  - 200 OK: `{ "message": "Job edited successfully", "job": <JobResponseDTO> }`
  - 400 Bad Request: `{ "error": "..." }`
  - 404 Not Found: if job not found
 
 Example request body (update salary and type):
 ```json
 {
   "salary": 2000.0,
 }
 ```


### DELETE /api/jobs/{id}
- Description: Delete a job by ID.
- Responses:
  - 200 OK: `Job deleted successfully!`
  - 404 Not Found: if job not found

Example:
```bash
curl -X DELETE http://localhost:8080/api/jobs/1
```

---

## Notes & Troubleshooting

- Partial updates: Use `PATCH` and include only fields you want to change. The service layer should preserve existing values for fields not present in the DTO.
- DTO/Entity mismatches: If MapStruct or Jackson complains about missing properties, verify DTO and entity property names match and that Lombok-generated getters/setters are available at compile time (check annotation processor configuration in `pom.xml`).
- Authentication/Authorization: No auth is included in these controllers. Add security if needed before production.

---

