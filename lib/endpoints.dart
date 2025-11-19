// API path segments (base URL is provided by AppConfig)
const String USERS = "users";
const String JOBS = "jobs";
const String APPLICATIONS = "applications";
const String AUTH = "auth";
// const String APPLY_FOR_JOB = "$APPLICATIONS/USE";
// Example user routes
String userById(String id) => "$USERS/$id";
String editUserById(String id) => "$USERS/$id";
String applyForJob(String userId, String jobId) => "$APPLICATIONS/user/$userId/job/$jobId";
String getUserApplications(String userId) => "$APPLICATIONS/user/$userId";
// Auth routes
const String SIGNUP = USERS;
const String LOGIN = "$USERS/login";