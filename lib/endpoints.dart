// API path segments (base URL is provided by AppConfig)
const String USERS = "users";
const String JOBS = "jobs";

// Example user routes
String userById(String id) => "$USERS/$id";
String editUserById(String id) => "$USERS/$id"; // adjust if different