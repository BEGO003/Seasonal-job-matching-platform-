import { User, LoginCredentials, SignupData, AuthResponse } from "@/types/user";
import { USERS } from "../../endpoints";
import { API_BASE_URL, commonHeaders, apiFetch } from "./config";
import { handleResponse, ApiError } from "./utils";

export const authApi = {
  /**
   * Login with email + password.
   * Calls POST /api/users/login (real JWT auth endpoint).
   * On success stores authToken, userId, and user in localStorage.
   */
  login: async (credentials: LoginCredentials): Promise<AuthResponse> => {
    const authUrl = `${API_BASE_URL}/users/login`;
    console.log("🔐 Login attempt →", authUrl);

    let res: Response;
    try {
      res = await fetch(authUrl, {
        method: "POST",
        headers: { ...commonHeaders },
        body: JSON.stringify(credentials),
      });
    } catch (e: any) {
      const msg = String(e?.message || "");
      if (msg.includes("Failed to fetch") || msg.includes("NetworkError")) {
        throw new ApiError(0, "Network error: unable to reach auth service");
      }
      throw new ApiError(500, "Login failed");
    }

    console.log("📡 Login response status:", res.status);

    // Handle non-ok responses (e.g. 401 wrong password, 404 user not found)
    if (!res.ok) {
      let errorMessage = "Invalid email or password";
      try {
        const errBody = await res.json();
        errorMessage = errBody?.message || errBody?.error || errorMessage;
      } catch {
        // ignore parse error – use default message
      }
      throw new ApiError(res.status, errorMessage);
    }

    const payload = await handleResponse<any>(res);
    console.log("✅ Login payload keys:", Object.keys(payload || {}));

    // Backend may return { token, user } or { data: { token, user } } or flat
    const data = payload?.data ?? payload;
    const token: string | undefined = data?.token ?? payload?.token;
    const userRaw: Partial<User> & { token?: string; password?: string } =
      data?.user ?? data ?? {};

    if (!userRaw.email) {
      console.error("⚠️ Login response did not include a user object:", payload);
      throw new ApiError(500, "Unexpected server response: missing user data");
    }

    // Persist token
    if (token) {
      localStorage.setItem("authToken", token);
    }

    // Persist user (without password)
    const { password: _pw, token: _tk, ...userWithoutPassword } = userRaw as any;
    if (userWithoutPassword.id != null) {
      localStorage.setItem("userId", String(userWithoutPassword.id));
    }
    localStorage.setItem("user", JSON.stringify(userWithoutPassword));

    return {
      user: userWithoutPassword as Omit<User, "password">,
      token,
      message: "Login successful",
    };
  },

  signup: async (signupData: SignupData): Promise<AuthResponse> => {
    try {
      // Check if user already exists - handle both wrapped and direct arrays
      const checkRes = await fetch(
        `${API_BASE_URL}${USERS}?email=${signupData.email}`,
        {
          headers: commonHeaders,
        }
      );
      const checkPayload = await handleResponse<any>(checkRes);
      // Normalize payload to an array of users, even if backend ignores the filter
      const candidateList: any[] = Array.isArray(checkPayload)
        ? checkPayload
        : Array.isArray(checkPayload?.data)
        ? checkPayload.data
        : checkPayload?.data
        ? [checkPayload.data]
        : checkPayload?.user
        ? [checkPayload.user]
        : [];

      const emailLower = signupData.email.toLowerCase();
      const exactMatches = candidateList.filter(
        (u: any) => u?.email?.toLowerCase?.() === emailLower
      );

      if (exactMatches.length > 0) {
        throw new ApiError(409, "Email already exists");
      }

      // Create new user object
      const newUser: Omit<User, "id"> = {
        ...signupData,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      };

      const createResponse = await fetch(`${API_BASE_URL}${USERS}`, {
        method: "POST",
        headers: commonHeaders,
        body: JSON.stringify(newUser),
      });

      const createdPayload = await handleResponse<any>(createResponse);
      const createdUser: User = Array.isArray(createdPayload)
        ? createdPayload[0]
        : createdPayload?.data ?? createdPayload;

      const { password, ...userWithoutPassword } = createdUser as any;
      localStorage.setItem("user", JSON.stringify(userWithoutPassword));
      if ((createdUser as any).id) {
        localStorage.setItem("userId", String((createdUser as any).id));
      }

      return {
        user: userWithoutPassword,
        message: "Signup successful",
      };
    } catch (error) {
      if (error instanceof ApiError) throw error;
      throw new ApiError(500, "Signup failed");
    }
  },

  logout: () => {
    localStorage.removeItem("user");
    localStorage.removeItem("userId");
    localStorage.removeItem("authToken");
  },

  getCurrentUser: (): Omit<User, "password"> | null => {
    const userStr = localStorage.getItem("user");
    if (!userStr) return null;
    try {
      return JSON.parse(userStr);
    } catch {
      return null;
    }
  },

  fetchCurrentUser: async (): Promise<Omit<User, "password"> | null> => {
    const id = localStorage.getItem("userId");
    if (!id) return null;
    try {
      const res = await apiFetch(`${API_BASE_URL}${USERS}/${id}`);
      if (!res.ok) {
        return authApi.getCurrentUser();
      }
      const raw = await handleResponse<any>(res);
      console.log("[authApi.fetchCurrentUser] raw user payload", raw);
      const actual = Array.isArray(raw) ? raw[0] : raw?.data ?? raw;
      console.log("[authApi.fetchCurrentUser] extracted actual user", actual);
      const normalized = {
        ...(actual || {}),
      } as Omit<User, "password">;
      console.log("[authApi.fetchCurrentUser] normalized user", normalized);
      localStorage.setItem("user", JSON.stringify(normalized));
      return normalized as Omit<User, "password">;
    } catch (e) {
      console.warn("[authApi.fetchCurrentUser] failed", e);
      return authApi.getCurrentUser();
    }
  },

  /**
   * Returns true only when BOTH a JWT token AND a userId are present.
   * This prevents stale userId values (leftover from a previous session
   * that has since expired) from being treated as authenticated.
   */
  isAuthenticated: (): boolean => {
    return (
      !!localStorage.getItem("authToken") &&
      !!localStorage.getItem("userId")
    );
  },

  updateUser: async (
    id: number,
    updates: Partial<User>
  ): Promise<Omit<User, "password">> => {
    const res = await apiFetch(`${API_BASE_URL}${USERS}/${id}`, {
      method: "PATCH",
      body: JSON.stringify(updates),
    });
    const response = await handleResponse<any>(res);
    console.log("[authApi.updateUser] raw response", response);

    // Extract actual user object (backend may wrap in {user, message})
    const actual = response?.user ?? response?.data ?? response;
    console.log("[authApi.updateUser] extracted user", actual);

    const normalized = {
      ...(actual || {}),
    };
    console.log("[authApi.updateUser] normalized user", normalized);

    localStorage.setItem("user", JSON.stringify(normalized));
    return normalized as Omit<User, "password">;
  },
};
