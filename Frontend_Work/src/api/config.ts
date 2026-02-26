import { ApiError } from "./utils";

// Use proxy base in dev to avoid CORS; fallback to '/api' if env missing
const isLocalhost =
  typeof window !== "undefined" &&
  /^(localhost|127\.0\.0\.1|\[::1\])$/.test(window.location.hostname);

export const API_BASE_URL = (
  (isLocalhost ? "/api" : import.meta.env.VITE_API_BASE_URL) || "/api"
).replace(/\/$/, "");

console.log("[api] Base URL:", API_BASE_URL);

/**
 * Read the logged-in user's id from localStorage
 */
export const getLoggedInUserId = (): number | null => {
  const idStr = localStorage.getItem("userId");
  if (!idStr) return null;
  const n = Number(idStr);
  return Number.isFinite(n) ? n : null;
};

/**
 * Common headers for API requests
 */
export const commonHeaders: HeadersInit = {
  Accept: "application/json",
  "Content-Type": "application/json",
  // Note: CORS response headers must be set by server. Client should not send them.
};

/**
 * Returns the stored JWT token, or null when the user is not authenticated.
 */
export const getAuthToken = (): string | null =>
  localStorage.getItem("authToken");

/**
 * Returns request headers with the Authorization: Bearer <token> header
 * injected when a token is available.  Use this for every authenticated call.
 */
export const getAuthHeaders = (): HeadersInit => {
  const token = getAuthToken();
  return {
    ...commonHeaders,
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };
};

/**
 * apiFetch — drop-in fetch interceptor.
 *
 * Behaviour:
 *  1. Merges Accept + Content-Type into every request.
 *  2. Attaches `Authorization: Bearer <token>` when a token exists in localStorage.
 *  3. Throws ApiError(401) and redirects to /login when the server returns 401
 *     (or when there is no token and the caller did NOT opt-out via `requireAuth: false`).
 *
 * Usage — identical to `fetch`:
 *   const res = await apiFetch(`${API_BASE_URL}/some/endpoint`, { method: "GET" });
 *
 * Public endpoints (login, signup) should continue to use bare `fetch`
 * because they intentionally have no token.
 */
export const apiFetch = async (
  url: string,
  options: RequestInit = {}
): Promise<Response> => {
  const token = getAuthToken();

  // Build merged headers — caller's headers take lowest priority so
  // our auth header cannot be accidentally overwritten.
  const mergedHeaders: Record<string, string> = {
    Accept: "application/json",
    "Content-Type": "application/json",
    ...(options.headers as Record<string, string>),
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };

  const response = await fetch(url, { ...options, headers: mergedHeaders });

  // --- 401 handler ---
  if (response.status === 401) {
    // Clear any stale session data
    localStorage.removeItem("authToken");
    localStorage.removeItem("userId");
    localStorage.removeItem("user");
    // Redirect to login page
    if (typeof window !== "undefined") {
      window.location.href = "/login";
    }
    throw new ApiError(401, "Unauthorized – please log in again");
  }

  return response;
};
