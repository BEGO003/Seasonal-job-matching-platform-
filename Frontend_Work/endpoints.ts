// endpoints.ts
export const USERS = "/users";
export const JOBS = "/jobs";

// Helper function to get jobs for a specific user (filtered)
export const getUserJobs = (userId: number) => `/users/${userId}/jobs`;
