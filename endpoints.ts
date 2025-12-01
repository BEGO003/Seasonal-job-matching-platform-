// endpoints.ts
const BASE_URL = import.meta.env.VITE_API_BASE_URL || "http://localhost:3000";

export const USERS = `${BASE_URL}/users`;
export const JOBS = `${BASE_URL}/jobs`;

// Helper function to get jobs for a specific user (filtered)
export const USER_JOBS = (userId: number) => `${USERS}/${userId}/jobs`;
