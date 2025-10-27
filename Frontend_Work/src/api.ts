import { Job, JobFormData, JobStats } from "@/types/job";
import { USERS, JOBS, USER_JOBS } from "../endpoints";

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;
const DEFAULT_USER_ID = 3; // Replace with logged-in user ID if available

class ApiError extends Error {
  constructor(public status: number, message: string) {
    super(message);
    this.name = "ApiError";
  }
}

const handleResponse = async <T>(response: Response): Promise<T> => {
  if (!response.ok) {
    let message = `HTTP ${response.status}`;
    try {
      const err = await response.json();
      message = (err && (err.message || err.error)) || message;
    } catch {
      try {
        const text = await response.text();
        if (text) message = text;
      } catch {}
    }
    throw new ApiError(response.status, message);
  }
  return response.json();
};

// -------------------- Utility Mappers --------------------
const mapApiStatusToUi = (status?: string): Job["status"] => {
  const s = (status || "").toUpperCase();
  if (s === "DRAFT") return "draft";
  if (s === "CLOSED") return "closed";
  return "active"; // OPEN maps to active in UI
};

const mapUiStatusToBackend = (status: Job["status"]): string => {
  // Frontend: "active" | "draft" | "closed" -> Backend: "OPEN" | "DRAFT" | "CLOSED"
  const mapping: Record<Job["status"], string> = {
    active: "OPEN",
    draft: "DRAFT",
    closed: "CLOSED",
  };
  return mapping[status] || "OPEN";
};

const mapUiJobTypeToBackend = (jobType: string): string => {
  // Frontend: "full-time" | "part-time" | "contract" | "temporary" | "freelance" | "volunteer" | "internship"
  // Backend: "FULL_TIME" | "PART_TIME" | "CONTRACT" | "TEMPORARY" | "FREELANCE" | "VOLUNTEER" | "INTERNSHIP"
  const mapping: Record<string, string> = {
    "full-time": "FULL_TIME",
    "part-time": "PART_TIME",
    contract: "CONTRACT",
    temporary: "TEMPORARY",
    freelance: "FREELANCE",
    volunteer: "VOLUNTEER",
    internship: "INTERNSHIP",
  };
  return mapping[jobType.toLowerCase()] || jobType.toUpperCase().replace("-", "_");
};

const mapBackendJobTypeToUi = (jobType: string): Job["jobType"] => {
  // Backend can send: "Full Time", "Part Time", "Contract", etc. or "FULL_TIME", "PART_TIME"
  // Frontend: "full-time" | "part-time" | "contract" | "temporary" | "freelance" | "volunteer" | "internship"
  const normalized = (jobType || "")
    .toLowerCase()
    .replace(/_/g, "-")
    .replace(/\s+/g, "-");
  
  const validJobTypes: Job["jobType"][] = [
    "full-time", "part-time", "contract", "temporary", 
    "freelance", "volunteer", "internship"
  ];
  
  if (validJobTypes.includes(normalized as Job["jobType"])) {
    return normalized as Job["jobType"];
  }
  // Default fallback
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
    workArrangement: (j.workArrangement ?? "remote")
      .toString()
      .toLowerCase() as "remote" | "hybrid" | "onsite",
    createdAt: j.createdAt ?? new Date().toISOString(),
    updatedAt: j.updatedAt ?? new Date().toISOString(),
  };
};

// -------------------- Common Headers --------------------
const commonHeaders: HeadersInit = {
  Accept: "application/json",
  "Content-Type": "application/json",
  "ngrok-skip-browser-warning": "true",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization",
};

// -------------------- Job API --------------------
export const jobApi = {
  // Get all jobs for current user
  getJobs: async (): Promise<Job[]> => {
    const response = await fetch(USER_JOBS(DEFAULT_USER_ID), {
      headers: commonHeaders,
    });
    const payload = await handleResponse<any>(response);
    const list = Array.isArray(payload) ? payload : payload?.data ?? [];
    return list.map(mapApiJobToJob);
  },

  // Get job by ID
  getJobById: async (id: number): Promise<Job> => {
    const response = await fetch(`${JOBS}/${id}`, { headers: commonHeaders });
    const payload = await handleResponse<any>(response);
    const obj = payload?.data ?? payload;
    return mapApiJobToJob(obj);
  },

  // Create new job
  createJob: async (jobData: JobFormData): Promise<Job> => {
    // Get authorization header if available
    const token = localStorage.getItem("authToken");
    
    const headers = {
      ...commonHeaders,
      ...(token && { Authorization: `Bearer ${token}` }),
    };

    // Convert dates from YYYY-MM-DD to DD-MM-YYYY format for backend
    const formatDateForBackend = (dateStr: string): string => {
      if (!dateStr) return "";
      const [year, month, day] = dateStr.split("-");
      return `${day}-${month}-${year}`;
    };

    const body = {
      jobposterId: DEFAULT_USER_ID,
      title: jobData.title,
      description: jobData.description,
      type: mapUiJobTypeToBackend(jobData.jobType),
      status: mapUiStatusToBackend(jobData.status),
      salary: jobData.salary,
      location: jobData.location,
      startDate: formatDateForBackend(jobData.startDate || ""),
      endDate: formatDateForBackend(jobData.endDate || ""),
      numofpositions: jobData.positions,
      workarrangement: jobData.workArrangement.toUpperCase(),
    };
    
    console.log("Request body:", body);
    console.log("API URL:", JOBS);
    console.log("Headers:", headers);
    console.log("Token present:", !!token);
    
    const response = await fetch(JOBS, {
      method: "POST",
      headers: headers,
      body: JSON.stringify(body),
    });
    
    // Log the response status and body for debugging
    if (!response.ok) {
      const errorText = await response.text();
      console.error("Response status:", response.status);
      console.error("Response body:", errorText);
      throw new ApiError(response.status, errorText || `HTTP ${response.status}`);
    }
    
    const payload = await handleResponse<any>(response);
    return mapApiJobToJob(payload);
  },

  // Update job by ID
  updateJob: async (
    id: number,
    jobData: Partial<JobFormData>
  ): Promise<Job> => {
    const token = localStorage.getItem("authToken");
    
    const headers = {
      ...commonHeaders,
      ...(token && { Authorization: `Bearer ${token}` }),
    };

    // Map the data to backend format
    const body: any = {
      ...jobData,
    };

    // Transform enum values to backend format
    if (jobData.jobType) {
      body.type = mapUiJobTypeToBackend(jobData.jobType);
      delete body.jobType; // Remove the frontend key
    }
    if (jobData.status) {
      body.status = mapUiStatusToBackend(jobData.status as Job["status"]);
    }
    if (jobData.workArrangement) {
      body.workarrangement = jobData.workArrangement.toUpperCase();
      delete body.workArrangement; // Remove the frontend key
    }

    const response = await fetch(`${JOBS}/${id}`, {
      method: "PUT",
      headers: headers,
      body: JSON.stringify(body),
    });
    const payload = await handleResponse<any>(response);
    return mapApiJobToJob(payload);
  },

  // Delete job
  deleteJob: async (id: number): Promise<void> => {
    const response = await fetch(`${JOBS}/${id}`, { method: "DELETE" });
    await handleResponse(response);
  },

  // Save as draft
  saveDraft: async (jobData: JobFormData): Promise<Job> => {
    const token = localStorage.getItem("authToken");
    
    const headers = {
      ...commonHeaders,
      ...(token && { Authorization: `Bearer ${token}` }),
    };

    // Convert dates from YYYY-MM-DD to DD-MM-YYYY format for backend
    const formatDateForBackend = (dateStr: string): string => {
      if (!dateStr) return "";
      const [year, month, day] = dateStr.split("-");
      return `${day}-${month}-${year}`;
    };

    const body = {
      jobposterId: DEFAULT_USER_ID,
      title: jobData.title,
      description: jobData.description,
      type: mapUiJobTypeToBackend(jobData.jobType),
      status: mapUiStatusToBackend(jobData.status),
      salary: jobData.salary,
      location: jobData.location,
      startDate: formatDateForBackend(jobData.startDate || ""),
      endDate: formatDateForBackend(jobData.endDate || ""),
      numofpositions: jobData.positions,
      workarrangement: jobData.workArrangement.toUpperCase(),
    };

    const response = await fetch(JOBS, {
      method: "POST",
      headers: headers,
      body: JSON.stringify(body),
    });
    const payload = await handleResponse<any>(response);
    return mapApiJobToJob(payload);
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
    }
  },
};

export { ApiError };
