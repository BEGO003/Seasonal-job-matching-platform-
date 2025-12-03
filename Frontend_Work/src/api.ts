import { Job, JobFormData, JobStats } from "@/types/job";
import { User, LoginCredentials, SignupData, AuthResponse } from "@/types/user";
import { USERS, JOBS, getUserJobs } from "../endpoints";

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

// Read the logged-in user's id from localStorage
const getLoggedInUserId = (): number | null => {
  const idStr = localStorage.getItem("userId");
  if (!idStr) return null;
  const n = Number(idStr);
  return Number.isFinite(n) ? n : null;
};

class ApiError extends Error {
  constructor(public status: number, message: string) {
    super(message);
    this.name = "ApiError";
  }
}

/**
 * handleResponse: safely handle different response types
 * - 204 No Content => returns null
 * - If response has JSON-like body, parse and return it
 * - If text body, return text
 * - Throws ApiError on non-ok responses with helpful message
 */
const handleResponse = async <T>(response: Response): Promise<T> => {
  // 204 No Content -> nothing to parse
  if (response.status === 204) {
    return null as unknown as T;
  }

  // Safely read text first to avoid JSON.parse errors
  let text = "";
  try {
    text = await response.text();
  } catch (e) {
    // If reading fails, and response is not ok, throw with status
    if (!response.ok) {
      throw new ApiError(response.status, `HTTP ${response.status}`);
    }
    return null as unknown as T;
  }

  // If response not ok: try to extract useful message then throw
  if (!response.ok) {
    // try parse JSON if it looks like JSON
    const looksLikeJson = /^[\s\r\n]*[\{\[]/.test(text);
    if (looksLikeJson) {
      try {
        const parsed = JSON.parse(text);
        const msg =
          (parsed && (parsed.message || parsed.error || parsed.msg)) ||
          JSON.stringify(parsed);
        throw new ApiError(response.status, String(msg));
      } catch (e) {
        // parsing failed -> return raw text as message
        throw new ApiError(response.status, text || `HTTP ${response.status}`);
      }
    } else {
      throw new ApiError(response.status, text || `HTTP ${response.status}`);
    }
  }

  // If OK but empty body -> return null
  if (!text) return null as unknown as T;

  // If looks like JSON -> parse
  const looksLikeJson = /^[\s\r\n]*[\{\[]/.test(text);
  if (looksLikeJson) {
    try {
      return JSON.parse(text) as T;
    } catch {
      // fallback to raw text if parse fails
      return text as unknown as T;
    }
  }

  // Text response (not JSON)
  return text as unknown as T;
};

// -------------------- Utility Mappers --------------------
const mapApiStatusToUi = (status?: string): Job["status"] => {
  const s = (status || "").toUpperCase();
  if (s === "DRAFT") return "draft";
  if (s === "CLOSED") return "closed";
  return "active"; // OPEN maps to active in UI
};

const mapUiStatusToBackend = (status: Job["status"]): string => {
  const mapping: Record<Job["status"], string> = {
    active: "OPEN",
    draft: "DRAFT",
    closed: "CLOSED",
  };
  return mapping[status] || "OPEN";
};

const mapUiJobTypeToBackend = (jobType: string): string => {
  const mapping: Record<string, string> = {
    "full-time": "FULL_TIME",
    "part-time": "PART_TIME",
    contract: "CONTRACT",
    temporary: "TEMPORARY",
    freelance: "FREELANCE",
    volunteer: "VOLUNTEER",
    internship: "INTERNSHIP",
  };
  return (
    mapping[jobType?.toLowerCase?.() ?? ""] ||
    (jobType || "").toUpperCase().replace("-", "_")
  );
};

const mapBackendJobTypeToUi = (jobType: string): Job["jobType"] => {
  const normalized = (jobType || "")
    .toLowerCase()
    .replace(/_/g, "-")
    .replace(/\s+/g, "-");

  const validJobTypes: Job["jobType"][] = [
    "full-time",
    "part-time",
    "contract",
    "temporary",
    "freelance",
    "volunteer",
    "internship",
  ];

  if (validJobTypes.includes(normalized as Job["jobType"])) {
    return normalized as Job["jobType"];
  }
  return "full-time";
};

const mapApiJobToJob = (j: any): Job => {
  const normalizeDate = (val: any) => {
    if (!val && val !== 0) return "";
    const s = String(val).trim();
    const m = s.match(/^(\d{1,2})[-\/](\d{1,2})[-\/](\d{2,4})$/);
    if (m) {
      let [, d, mo, y] = m;
      let year = parseInt(y, 10);
      if (year < 100) year = 2000 + year;
      else if (year < 1000) year = 2000 + year;
      const YYYY = year.toString().padStart(4, "0");
      const MM = mo.padStart(2, "0");
      const DD = d.padStart(2, "0");
      return `${YYYY}-${MM}-${DD}`;
    }
    const dt = new Date(s);
    if (!Number.isNaN(dt.getTime())) return dt.toISOString().split("T")[0];
    return s;
  };

  return {
    id: j.id ?? 0,
    title: j.title ?? "",
    description: j.description ?? "",
    location: j.location ?? "",
    jobType: mapBackendJobTypeToUi(j.jobType ?? j.type ?? ""),
    startDate: normalizeDate(j.startDate ?? j.StartDate ?? j.start_date),
    endDate: normalizeDate(j.endDate ?? j.EndDate ?? j.end_date),
    salary: typeof j.salary === "number" ? j.salary : Number(j.salary ?? 0),
    positions: j.positions ?? j.numofpositions ?? 0,
    status: mapApiStatusToUi(j.status),
    applications: j.applications ?? 0,
    views: j.views ?? 0,
    workArrangement: (j.workArrangement ?? j.workarrangement ?? "remote")
      .toString()
      .toLowerCase() as "remote" | "hybrid" | "onsite",
    createdAt: j.createdAt ?? new Date().toISOString(),
    updatedAt: j.updatedAt ?? new Date().toISOString(),
    categories: Array.isArray(j.categories) ? j.categories : undefined,
    requirements: Array.isArray(j.requirements) ? j.requirements : undefined,
    benefits: Array.isArray(j.benefits) ? j.benefits : undefined,
  };
};

// -------------------- Common Headers --------------------
const commonHeaders: HeadersInit = {
  Accept: "application/json",
  "Content-Type": "application/json",
  // Note: CORS response headers must be set by server. Client should not send them.
};

// -------------------- Job API --------------------
export const jobApi = {
  // Get all jobs for current user
  getJobs: async (): Promise<Job[]> => {
    const userId = getLoggedInUserId();
    if (!userId) {
      throw new ApiError(401, "Not authenticated: missing user id");
    }
    const response = await fetch(`${API_BASE_URL}${getUserJobs(userId)}`, {
      headers: commonHeaders,
    });
    const payload = await handleResponse<any>(response);
    const list = Array.isArray(payload) ? payload : payload?.data ?? [];
    return list.map(mapApiJobToJob);
  },

  // Get job by ID
  getJobById: async (id: number): Promise<Job> => {
    const response = await fetch(`${API_BASE_URL}${JOBS}/${id}`, {
      headers: commonHeaders,
    });
    const payload = await handleResponse<any>(response);
    const obj = payload?.data ?? payload;
    return mapApiJobToJob(obj);
  },

  // Create new job
  createJob: async (jobData: JobFormData): Promise<Job> => {
    const currentUserId = getLoggedInUserId();
    if (!currentUserId) {
      throw new ApiError(401, "Not authenticated: cannot create job");
    }
    const token = localStorage.getItem("authToken");

    const headers: HeadersInit = {
      ...commonHeaders,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };

    const formatDateForBackend = (dateStr: string): string => {
      if (!dateStr) return "";
      const [year, month, day] = dateStr.split("-");
      return `${day}-${month}-${year}`;
    };

    const body: any = {
      jobposterId: currentUserId,
      title: jobData.title,
      description: jobData.description,
      type: jobData.jobType
        ? mapUiJobTypeToBackend(jobData.jobType)
        : undefined,
      status: jobData.status ? mapUiStatusToBackend(jobData.status) : undefined,
      salary: jobData.salary,
      location: jobData.location,
      startDate: formatDateForBackend(jobData.startDate || ""),
      endDate: formatDateForBackend(jobData.endDate || ""),
      numofpositions: jobData.positions,
      workarrangement: jobData.workArrangement?.toUpperCase?.(),
      // Always send arrays, even if empty - backend expects arrays
      categories: Array.isArray(jobData.categories) ? jobData.categories : [],
      requirements: Array.isArray(jobData.requirements)
        ? jobData.requirements
        : [],
      benefits: Array.isArray(jobData.benefits) ? jobData.benefits : [],
    };

    // Remove undefined fields to keep payload clean
    Object.keys(body).forEach((k) => body[k] === undefined && delete body[k]);

    const response = await fetch(`${API_BASE_URL}${JOBS}`, {
      method: "POST",
      headers,
      body: JSON.stringify(body),
    });

    const payload = await handleResponse<any>(response);
    const created = payload?.data ?? payload;
    return mapApiJobToJob(created);
  },

  // Update job by ID
  updateJob: async (
    id: number,
    jobData: Partial<JobFormData>
  ): Promise<Job> => {
    const token = localStorage.getItem("authToken");
    const currentUserId = getLoggedInUserId();

    const headers: HeadersInit = {
      ...commonHeaders,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };

    const formatDateForBackend = (dateStr: string): string => {
      if (!dateStr || dateStr.trim() === "") return "";
      const [year, month, day] = dateStr.split("-");
      return `${day}-${month}-${year}`;
    };

    const body: any = {
      ...(currentUserId ? { jobposterId: currentUserId } : {}),
    };

    // Map fields to backend format
    if (jobData.title !== undefined) body.title = jobData.title;
    if (jobData.description !== undefined)
      body.description = jobData.description;
    if (jobData.location !== undefined) body.location = jobData.location;
    if (jobData.salary !== undefined) body.salary = jobData.salary;
    if (jobData.positions !== undefined)
      body.numofpositions = jobData.positions;
    if (jobData.startDate !== undefined)
      body.startDate = formatDateForBackend(jobData.startDate);
    if (jobData.endDate !== undefined)
      body.endDate = formatDateForBackend(jobData.endDate);
    // Always send arrays, even if empty - backend expects arrays
    if (jobData.categories !== undefined) {
      body.categories = Array.isArray(jobData.categories)
        ? jobData.categories
        : [];
    }
    if (jobData.requirements !== undefined) {
      body.requirements = Array.isArray(jobData.requirements)
        ? jobData.requirements
        : [];
    }
    if (jobData.benefits !== undefined) {
      body.benefits = Array.isArray(jobData.benefits) ? jobData.benefits : [];
    }

    if (jobData.jobType) {
      body.type = mapUiJobTypeToBackend(jobData.jobType as string);
    }
    if (jobData.status) {
      body.status = mapUiStatusToBackend(jobData.status as Job["status"]);
    }
    if (jobData.workArrangement) {
      body.workarrangement = (jobData.workArrangement as string).toUpperCase();
    }

    // Remove undefined and null values, but keep empty arrays
    Object.keys(body).forEach((k) => {
      if (body[k] === undefined || body[k] === null) {
        delete body[k];
      }
    });

    console.log("[jobApi.updateJob] → PATCH body", body);
    const response = await fetch(`${API_BASE_URL}${JOBS}/${id}`, {
      method: "PATCH",
      headers,
      body: JSON.stringify(body),
    });
    const payload = await handleResponse<any>(response);
    console.log("[jobApi.updateJob] ← PATCH response", {
      status: response.status,
      payloadKeys: Object.keys(payload || {}),
    });
    const updated = payload?.data ?? payload;
    return mapApiJobToJob(updated);
  },

  // Delete job — hardened and tolerant to id passed as object, and to incorrect content-type
  deleteJob: async (
    idOrObj: number | string | { id?: number | string } | Job
  ): Promise<void> => {
    const userId = getLoggedInUserId();
    if (!userId) throw new ApiError(401, "Not authenticated: missing user id");

    // Extract ID from various input formats
    let rawId: any;
    if (typeof idOrObj === "object" && idOrObj !== null) {
      // Could be a Job object or an object with id property
      rawId = (idOrObj as any).id;
    } else {
      rawId = idOrObj;
    }

    if (rawId === undefined || rawId === null) {
      throw new ApiError(400, "deleteJob: missing id");
    }

    // Normalize ID to string, handling both number and string inputs
    let id: string;
    if (typeof rawId === "number") {
      id = String(rawId);
    } else {
      const numId = Number(rawId);
      if (!Number.isNaN(numId) && Number.isFinite(numId)) {
        id = String(numId);
      } else {
        id = String(rawId);
      }
    }

    // Ensure we have a valid numeric ID
    if (id === "0" || id === "NaN" || !id) {
      throw new ApiError(400, `deleteJob: invalid id "${rawId}"`);
    }

    console.log("[jobApi.deleteJob] Extracted ID", {
      rawInput: idOrObj,
      rawId,
      normalizedId: id,
      userId,
    });

    // Verify job exists and belongs to user before attempting deletion
    let verifiedJob: Job | undefined;
    let rawJobData: any = null;
    try {
      const userJobs = await jobApi.getJobs();
      verifiedJob = userJobs.find((j) => String(j.id) === id);
      if (!verifiedJob) {
        throw new ApiError(
          404,
          `Job with ID ${id} not found in your job list. You may not have permission to delete this job.`
        );
      }

      // Also fetch the raw job data to check jobposterId
      try {
        const jobResponse = await fetch(`${API_BASE_URL}${JOBS}/${id}`, {
          headers: commonHeaders,
        });
        if (jobResponse.ok) {
          const jobPayload = await handleResponse<any>(jobResponse);
          rawJobData = jobPayload?.data ?? jobPayload;
          console.log("[jobApi.deleteJob] Raw job data from backend", {
            jobId: rawJobData?.id,
            jobposterId: rawJobData?.jobposterId ?? rawJobData?.jobPosterId,
            currentUserId: userId,
            match:
              (rawJobData?.jobposterId ?? rawJobData?.jobPosterId) === userId,
          });
        }
      } catch (fetchErr) {
        console.warn(
          "[jobApi.deleteJob] Could not fetch raw job data",
          fetchErr
        );
      }

      console.log("[jobApi.deleteJob] Verified job ownership", {
        jobId: verifiedJob.id,
        jobTitle: verifiedJob.title,
        userId,
        totalUserJobs: userJobs.length,
        jobposterId: rawJobData?.jobposterId ?? rawJobData?.jobPosterId,
        ownershipMatch:
          (rawJobData?.jobposterId ?? rawJobData?.jobPosterId) === userId,
      });

      // Check if jobposterId matches userId
      const jobposterId = rawJobData?.jobposterId ?? rawJobData?.jobPosterId;
      if (
        jobposterId !== undefined &&
        jobposterId !== null &&
        Number(jobposterId) !== userId
      ) {
        throw new ApiError(
          403,
          `You do not have permission to delete this job. Job belongs to user ${jobposterId}, but you are user ${userId}.`
        );
      }
    } catch (err) {
      // If verification fails with 404 or 403, throw it
      if (
        err instanceof ApiError &&
        (err.status === 404 || err.status === 403)
      ) {
        throw err;
      }
      // For other errors (network, etc.), log but continue
      console.warn(
        "[jobApi.deleteJob] Could not verify job ownership, proceeding anyway",
        err
      );
    }

    const token = localStorage.getItem("authToken");
    const headers: HeadersInit = {
      ...commonHeaders,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };

    // Try simple DELETE to /jobs/{id} endpoint
    const url = `${API_BASE_URL}${JOBS}/${id}`;
    console.log("[jobApi.deleteJob] Attempting DELETE", {
      url,
      userId,
      jobId: id,
    });

    try {
      const res = await fetch(url, {
        method: "DELETE",
        headers,
      });

      const text = await (async () => {
        try {
          return await res.text();
        } catch {
          return "";
        }
      })();

      console.log("[jobApi.deleteJob] DELETE response", {
        url,
        status: res.status,
        ok: res.ok,
        bodyPreview: text.slice(0, 400),
      });

      // 204 No Content = success
      if (res.status === 204) {
        console.log("[jobApi.deleteJob] Deleted successfully (204)");
        return;
      }

      // 200 OK, check if it says "not found" in body
      if (res.ok) {
        // Backend may return 200 with message "Job not found!" after successful delete
        // or return empty body. Both are treated as success.
        console.log("[jobApi.deleteJob] Delete successful (200 OK)");
        return;
      }

      // Non-OK response
      const looksLikeJson = /^[\s\r\n]*[\{\[]/.test(text || "");
      let parsed: any = undefined;
      if (looksLikeJson && text) {
        try {
          parsed = JSON.parse(text);
        } catch {}
      }
      const serverMsg =
        (parsed && (parsed.message || parsed.error)) ||
        text ||
        `HTTP ${res.status}`;
      throw new ApiError(res.status, String(serverMsg));
    } catch (err) {
      if (err instanceof ApiError) throw err;
      throw new ApiError(500, "Failed to delete job");
    }
  },

  // Save as draft - with placeholder values for null/empty fields
  saveDraft: async (jobData: JobFormData): Promise<Job> => {
    const currentUserId = getLoggedInUserId();
    if (!currentUserId) {
      throw new ApiError(401, "Not authenticated: cannot save draft");
    }
    const token = localStorage.getItem("authToken");

    const headers: HeadersInit = {
      ...commonHeaders,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };

    const formatDateForBackend = (dateStr: string): string => {
      if (!dateStr || dateStr.trim() === "") return "";
      const [year, month, day] = dateStr.split("-");
      return `${day}-${month}-${year}`;
    };

    // Helper to get value or placeholder, ensuring correct data type
    const getValueOrPlaceholder = <T>(
      value: T | null | undefined | "",
      placeholder: T,
      type: "string" | "number" | "array"
    ): T => {
      if (value === null || value === undefined || value === "") {
        return placeholder;
      }
      // Ensure correct type
      if (type === "number" && typeof value !== "number") {
        const num = Number(value);
        return (
          !Number.isNaN(num) && Number.isFinite(num) ? num : placeholder
        ) as T;
      }
      if (type === "string" && typeof value !== "string") {
        return String(value) as T;
      }
      if (type === "array" && !Array.isArray(value)) {
        return placeholder;
      }
      return value;
    };

    // Get today's date in DD-MM-YYYY format for date placeholders
    const today = new Date();
    const todayStr = `${String(today.getDate()).padStart(2, "0")}-${String(
      today.getMonth() + 1
    ).padStart(2, "0")}-${today.getFullYear()}`;
    const futureDateStr = `${String(today.getDate()).padStart(2, "0")}-${String(
      today.getMonth() + 1
    ).padStart(2, "0")}-${today.getFullYear() + 1}`;

    // Build body with placeholders for null/empty fields, user data when provided
    const body: any = {
      jobposterId: currentUserId, // Always required, never null
      title: getValueOrPlaceholder(jobData.title, "Untitled Job", "string"),
      description: getValueOrPlaceholder(
        jobData.description,
        "Job description will be added here",
        "string"
      ),
      type: jobData.jobType
        ? mapUiJobTypeToBackend(jobData.jobType)
        : "FULL_TIME", // Default placeholder
      status: jobData.status ? mapUiStatusToBackend(jobData.status) : "DRAFT", // Always DRAFT for saveDraft
      salary: getValueOrPlaceholder(jobData.salary, 0, "number"),
      location: getValueOrPlaceholder(
        jobData.location,
        "Location TBD",
        "string"
      ),
      startDate: formatDateForBackend(jobData.startDate || "") || todayStr, // Use today if empty
      endDate: formatDateForBackend(jobData.endDate || "") || futureDateStr, // Use 1 year from today if empty
      numofpositions: getValueOrPlaceholder(jobData.positions, 1, "number"),
      workarrangement: jobData.workArrangement
        ? jobData.workArrangement.toUpperCase()
        : "REMOTE", // Default placeholder
      // Categories, requirements, and benefits are now required - use user data or empty array
      categories: Array.isArray(jobData.categories) ? jobData.categories : [],
      requirements: Array.isArray(jobData.requirements)
        ? jobData.requirements
        : [],
      benefits: Array.isArray(jobData.benefits) ? jobData.benefits : [],
    };

    // Ensure all required fields have correct types (no null/undefined)
    // Arrays should be arrays, not undefined
    if (!Array.isArray(body.categories)) body.categories = [];
    if (!Array.isArray(body.requirements)) body.requirements = [];
    if (!Array.isArray(body.benefits)) body.benefits = [];

    console.log("[jobApi.saveDraft] Sending draft with placeholders", {
      hasUserTitle: !!jobData.title,
      hasUserDescription: !!jobData.description,
      hasUserLocation: !!jobData.location,
      hasUserSalary: jobData.salary !== undefined && jobData.salary !== null,
      body: { ...body, jobposterId: currentUserId }, // Log without exposing full userId
    });

    const response = await fetch(`${API_BASE_URL}${JOBS}`, {
      method: "POST",
      headers,
      body: JSON.stringify(body),
    });

    const payload = await handleResponse<any>(response);
    const created = payload?.data ?? payload;
    return mapApiJobToJob(created);
  },

  // Get stats (auto fallback if endpoint missing)
  getJobStats: async (): Promise<JobStats> => {
    try {
      const response = await fetch(`${API_BASE_URL}/jobStats`, {
        headers: commonHeaders,
      });
      const payload = await handleResponse<any>(response);
      return payload?.data ?? payload;
    } catch {
      try {
        const jobs = await jobApi.getJobs();
        return {
          totalJobs: jobs.length,
          totalApplications: jobs.reduce(
            (sum, j) => sum + (j.applications || 0),
            0
          ),
          totalViews: jobs.reduce((sum, j) => sum + (j.views || 0), 0),
          activeJobs: jobs.filter((j) => j.status === "active").length,
        };
      } catch {
        return {
          totalJobs: 0,
          totalApplications: 0,
          totalViews: 0,
          activeJobs: 0,
        };
      }
    }
  },
};

// -------------------- Auth API --------------------
export const authApi = {
  login: async (credentials: LoginCredentials): Promise<AuthResponse> => {
    try {
      console.log("🔐 Login attempt with credentials:", {
        email: credentials.email,
        passwordLength: credentials.password.length,
      });

      // 1) Try real backend auth endpoint first (if available)
      const authUrl = `${API_BASE_URL}/users/login`;
      console.log("🌐 Trying auth endpoint:", authUrl);
      try {
        const authRes = await fetch(authUrl, {
          method: "POST",
          headers: { ...commonHeaders },
          body: JSON.stringify(credentials),
        });
        console.log("📡 Auth endpoint status:", authRes.status);
        if (authRes.ok) {
          const authPayload = await handleResponse<any>(authRes);
          console.log(
            "✅ Auth endpoint returned payload keys:",
            Object.keys(authPayload || {})
          );
          const userFromAuthRaw = (authPayload.user ||
            authPayload.data ||
            authPayload) as Partial<User> & {
            token?: string;
          };
          const userFromAuth: Partial<User> & { token?: string } = {
            ...(userFromAuthRaw as any),
          };
          if (!userFromAuth || !userFromAuth.email) {
            console.warn(
              "⚠️ Auth endpoint didn't return a user object with email; falling back to users lookup."
            );
          } else {
            // Persist
            const {
              password: _pw,
              token,
              ...userWithoutPassword
            } = userFromAuth as any;
            if (token) localStorage.setItem("authToken", token);
            if ((userWithoutPassword as any).id) {
              localStorage.setItem(
                "userId",
                String((userWithoutPassword as any).id)
              );
            }
            localStorage.setItem("user", JSON.stringify(userWithoutPassword));
            return {
              user: userWithoutPassword as Omit<User, "password">,
              message: "Login successful",
              token,
            };
          }
        } else if (authRes.status !== 404 && authRes.status !== 405) {
          const errText = await authRes.text();
          console.warn("⚠️ Auth endpoint error:", errText);
        }
      } catch (e) {
        console.warn(
          "⚠️ Auth endpoint not available or failed, falling back to users query.",
          e
        );
      }

      // 2) Fallback: query users by email
      const usersUrl = `${API_BASE_URL}${USERS}?email=${encodeURIComponent(
        credentials.email
      )}`;
      console.log("🌐 Fetching users by email from:", usersUrl);
      const response = await fetch(usersUrl, { headers: commonHeaders });
      console.log("📡 Users lookup status:", response.status);
      const usersPayload = await handleResponse<any>(response);

      // Support both direct array or { data: [...] }
      const usersByEmail: any[] = Array.isArray(usersPayload)
        ? usersPayload
        : usersPayload?.data ?? [];

      console.log("👥 Users found for email:", usersByEmail.length);

      const exactUsers = usersByEmail.filter(
        (u) => u.email?.toLowerCase() === credentials.email.toLowerCase()
      );

      if (exactUsers.length === 0) {
        console.log("❌ No user found with that email");
        throw new ApiError(401, "Invalid email or password");
      }

      const userRaw = exactUsers[0] as any;
      const user: User = {
        ...userRaw,
      };
      const hasPasswordField = Object.prototype.hasOwnProperty.call(
        user,
        "password"
      );
      console.log(
        "🔍 Password field present in API response:",
        hasPasswordField
      );

      if (hasPasswordField && typeof user.password !== "undefined") {
        const matches = user.password === credentials.password;
        console.log("🔑 Password comparison result:", matches);
        if (!matches) throw new ApiError(401, "Invalid email or password");
      } else {
        console.warn(
          "⚠️ API does not expose password field. Password cannot be verified — rejecting login."
        );
        throw new ApiError(401, "Invalid email or password");
      }

      const { password, ...userWithoutPassword } = user as any;
      if ((userWithoutPassword as any).id) {
        localStorage.setItem("userId", String((userWithoutPassword as any).id));
      }
      localStorage.setItem("user", JSON.stringify(userWithoutPassword));

      return {
        user: userWithoutPassword as Omit<User, "password">,
        message: "Login successful",
      };
    } catch (error: any) {
      console.error("❌ Login error:", error);
      if (error instanceof ApiError) throw error;
      const message = String(error?.message || "");
      if (
        message.includes("Failed to fetch") ||
        message.includes("NetworkError")
      ) {
        throw new ApiError(
          0,
          "Network or CORS error: unable to reach auth service"
        );
      }
      throw new ApiError(500, "Login failed");
    }
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
        // Normalize possible typo from backend/UI
        fieldsOfInterest: signupData.fieldsOfInterest ?? [],
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
      const res = await fetch(`${API_BASE_URL}${USERS}/${id}`, {
        headers: commonHeaders,
      });
      if (!res.ok) {
        return authApi.getCurrentUser();
      }
      const raw = await handleResponse<any>(res);
      console.log("[authApi.fetchCurrentUser] raw user payload", raw);
      const actual = Array.isArray(raw) ? raw[0] : raw?.data ?? raw;
      console.log("[authApi.fetchCurrentUser] extracted actual user", actual);
      const existing = authApi.getCurrentUser();
      const normalized = {
        ...(actual || {}),
        fieldsOfInterest:
          actual?.fieldsOfInterest ??
          (existing as any)?.fieldsOfInterest ??
          undefined,
      } as Omit<User, "password">;
      console.log("[authApi.fetchCurrentUser] normalized user", normalized);
      localStorage.setItem("user", JSON.stringify(normalized));
      return normalized as Omit<User, "password">;
    } catch (e) {
      console.warn("[authApi.fetchCurrentUser] failed", e);
      return authApi.getCurrentUser();
    }
  },

  isAuthenticated: (): boolean => {
    return !!localStorage.getItem("userId");
  },

  updateUser: async (
    id: number,
    updates: Partial<User>
  ): Promise<Omit<User, "password">> => {
    const token = localStorage.getItem("authToken");
    const headers: HeadersInit = {
      ...commonHeaders,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
    const res = await fetch(`${API_BASE_URL}${USERS}/${id}`, {
      method: "PATCH",
      headers,
      body: JSON.stringify(updates),
    });
    const response = await handleResponse<any>(res);
    console.log("[authApi.updateUser] raw response", response);

    // Extract actual user object (backend may wrap in {user, message})
    const actual = response?.user ?? response?.data ?? response;
    console.log("[authApi.updateUser] extracted user", actual);

    const existing = authApi.getCurrentUser();
    const normalized = {
      ...(actual || {}),
      fieldsOfInterest:
        actual?.fieldsOfInterest ||
        (existing as any)?.fieldsOfInterest ||
        undefined,
    };
    console.log("[authApi.updateUser] normalized user", normalized);

    localStorage.setItem("user", JSON.stringify(normalized));
    return normalized as Omit<User, "password">;
  },
};

export { ApiError };
