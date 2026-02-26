import { Job, JobFormData, JobStats } from "@/types/job";
import { JOBS, getUserJobs } from "../../endpoints";
import { API_BASE_URL, getLoggedInUserId, apiFetch } from "./config";
import {
  handleResponse,
  ApiError,
  mapApiJobToJob,
  mapUiJobTypeToBackend,
  mapUiStatusToBackend,
  formatDateForBackend,
} from "./utils";

// Import applicationApi for stats calculation (will be defined later)
// We'll handle this with a forward reference
let applicationApi: any;

export const setApplicationApi = (api: any) => {
  applicationApi = api;
};

export const jobApi = {
  // Get all jobs for current user
  getJobs: async (): Promise<Job[]> => {
    const userId = getLoggedInUserId();
    if (!userId) {
      throw new ApiError(401, "Not authenticated: missing user id");
    }
    const response = await apiFetch(`${API_BASE_URL}${getUserJobs(userId)}`);
    const payload = await handleResponse<any>(response);
    const list = Array.isArray(payload) ? payload : payload?.data ?? [];
    return list.map(mapApiJobToJob);
  },

  // Get job by ID
  getJobById: async (id: number): Promise<Job> => {
    const response = await apiFetch(`${API_BASE_URL}${JOBS}/employer/${id}`);
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


    const body: any = {
      jobposterId: currentUserId,
      title: jobData.title,
      description: jobData.description,
      type: jobData.jobType
        ? mapUiJobTypeToBackend(jobData.jobType)
        : undefined,
      status: jobData.status ? mapUiStatusToBackend(jobData.status) : undefined,
      amount: jobData.amount,
      salary: jobData.salary,
      location: jobData.location,
      startDate: formatDateForBackend(jobData.startDate || ""),
      duration: jobData.duration,
      numOfPositions: jobData.positions,
      workArrangement: jobData.workArrangement?.toUpperCase?.(),
      // Always send arrays, even if empty - backend expects arrays
      categories: Array.isArray(jobData.categories) ? jobData.categories : [],
      requirements: Array.isArray(jobData.requirements)
        ? jobData.requirements
        : [],
      benefits: Array.isArray(jobData.benefits) ? jobData.benefits : [],
    };

    // Remove undefined fields to keep payload clean
    Object.keys(body).forEach((k) => body[k] === undefined && delete body[k]);

    const response = await apiFetch(`${API_BASE_URL}${JOBS}`, {
      method: "POST",
      body: JSON.stringify(body),
    });

    const payload = await handleResponse<any>(response);
    const created = payload?.data ?? payload;
    return mapApiJobToJob(created);
  },

  // Update job by ID
  updateJob: async (
    id: number,
    jobData: Partial<JobFormData>,
    originalArrays?: {
      categories?: string[];
      requirements?: string[];
      benefits?: string[];
    }
  ): Promise<Job> => {
    const currentUserId = getLoggedInUserId();

    if (!currentUserId) {
      throw new ApiError(401, "Not authenticated: missing user id");
    }

    const body: any = {
      ...(currentUserId ? { jobposterId: currentUserId } : {}),
    };

    // Map scalar fields to backend format
    if (jobData.title !== undefined) body.title = jobData.title;
    if (jobData.description !== undefined) body.description = jobData.description;
    if (jobData.location !== undefined) body.location = jobData.location;
    if (jobData.amount !== undefined) body.amount = jobData.amount;
    if (jobData.salary !== undefined) body.salary = jobData.salary;
    if (jobData.duration !== undefined) body.duration = jobData.duration;
    if (jobData.positions !== undefined) body.numOfPositions = jobData.positions;
    if (jobData.startDate !== undefined)
      body.startDate = formatDateForBackend(jobData.startDate);
    if (jobData.jobType) body.type = mapUiJobTypeToBackend(jobData.jobType as string);
    if (jobData.status) body.status = mapUiStatusToBackend(jobData.status as Job["status"]);
    if (jobData.workArrangement)
      body.workArrangement = (jobData.workArrangement as string).toUpperCase();

    // Backend expects add/remove diffs for arrays, not full replacements.
    // Helper: compute items added and removed between two arrays.
    const diffArrays = (
      oldArr: string[],
      newArr: string[]
    ): { toAdd: string[]; toRemove: string[] } => ({
      toAdd: newArr.filter((x) => !oldArr.includes(x)),
      toRemove: oldArr.filter((x) => !newArr.includes(x)),
    });

    if (jobData.categories !== undefined) {
      const newCats = Array.isArray(jobData.categories) ? jobData.categories : [];
      const oldCats = originalArrays?.categories ?? [];
      const { toAdd, toRemove } = diffArrays(oldCats, newCats);
      if (toAdd.length > 0) body.categoriesToAdd = toAdd;
      if (toRemove.length > 0) body.categoriesToRemove = toRemove;
    }

    if (jobData.requirements !== undefined) {
      const newReqs = Array.isArray(jobData.requirements) ? jobData.requirements : [];
      const oldReqs = originalArrays?.requirements ?? [];
      const { toAdd, toRemove } = diffArrays(oldReqs, newReqs);
      if (toAdd.length > 0) body.requirementsToAdd = toAdd;
      if (toRemove.length > 0) body.requirementsToRemove = toRemove;
    }

    if (jobData.benefits !== undefined) {
      const newBens = Array.isArray(jobData.benefits) ? jobData.benefits : [];
      const oldBens = originalArrays?.benefits ?? [];
      const { toAdd, toRemove } = diffArrays(oldBens, newBens);
      if (toAdd.length > 0) body.benefitsToAdd = toAdd;
      if (toRemove.length > 0) body.benefitsToRemove = toRemove;
    }

    // Remove undefined and null values (keep zeros and non-null arrays)
    Object.keys(body).forEach((k) => {
      if (body[k] === undefined || body[k] === null) delete body[k];
    });

    console.log("[jobApi.updateJob] → PATCH body", { body, id, currentUserId });
    const response = await apiFetch(`${API_BASE_URL}${JOBS}/${id}`, {
      method: "PATCH",
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
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  // Delete job 
 deleteJob: async (id: number | string): Promise<void> => {
  const userId = getLoggedInUserId();
  if (!userId) {
    throw new ApiError(401, "Not authenticated");
  }

  if (id === undefined || id === null) {
    throw new ApiError(400, "Missing job id");
  }

  const res = await apiFetch(`${API_BASE_URL}${JOBS}/${id}`, {
    method: "DELETE",
  });

  // Success cases
  if (res.status === 204 || res.ok) {
    return;
  }

  // Error handling
  let message = `Failed to delete job (HTTP ${res.status})`;
  try {
    const text = await res.text();
    if (text) message = text;
  } catch {}

  throw new ApiError(res.status, message);
},

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  // Save as draft - allows unfilled fields by substituting placeholder defaults
  saveDraft: async (jobData: Partial<JobFormData>): Promise<Job> => {
    const currentUserId = getLoggedInUserId();
    if (!currentUserId) {
      throw new ApiError(401, "Not authenticated: cannot save draft");
    }

    const body: any = {
      jobposterId: currentUserId,
      status: "DRAFT",
      // Use provided values or fall back to safe placeholder defaults
      title: jobData.title?.trim() || "Untitled Draft",
      description: jobData.description?.trim() || "",
      location: jobData.location?.trim() || "",
      amount: jobData.amount ?? 0,
      salary: jobData.salary || "YEARLY",
      jobType: jobData.jobType || "FULL_TIME",
      duration: jobData.duration ?? 0,
      numOfPositions: jobData.positions ?? 1,
      // Arrays – use user's data when available, else empty placeholder
      categories:
        Array.isArray(jobData.categories) && jobData.categories.length > 0
          ? jobData.categories
          : ["To be added"],
      requirements:
        Array.isArray(jobData.requirements) && jobData.requirements.length > 0
          ? jobData.requirements
          : ["To be added"],
      benefits:
        Array.isArray(jobData.benefits) && jobData.benefits.length > 0
          ? jobData.benefits
          : ["To be added"],
    };

    // Optional fields – only include when the user supplied a value
    if (jobData.jobType) {
      body.type = mapUiJobTypeToBackend(jobData.jobType);
    }
    if (jobData.workArrangement) {
      body.workArrangement = jobData.workArrangement.toUpperCase();
    }
    if (jobData.startDate) {
      body.startDate = formatDateForBackend(jobData.startDate);
    }

    const response = await apiFetch(`${API_BASE_URL}${JOBS}`, {
      method: "POST",
      body: JSON.stringify(body),
    });

    const payload = await handleResponse<any>(response);
    const created = payload?.data ?? payload;
    return mapApiJobToJob(created);
  },

  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  // Get stats (auto fallback if endpoint missing)
  getJobStats: async (): Promise<JobStats> => {
    try {
      const response = await apiFetch(`${API_BASE_URL}/jobStats`);
      const payload = await handleResponse<any>(response);
      const raw = payload?.data ?? payload;
      // If backend sends static totals, accept them; otherwise fallback below
      if (
        raw &&
        typeof raw.totalJobs === "number" &&
        typeof raw.totalApplications === "number" &&
        typeof raw.totalViews === "number" &&
        typeof raw.activeJobs === "number"
      ) {
        return raw as JobStats;
      }
      throw new Error("Incomplete jobStats payload");
    } catch {
      try {
        const jobs = await jobApi.getJobs();
        // Dynamically compute applications by querying applications per job
        let totalApplications = 0;
        if (applicationApi) {
          for (const j of jobs) {
            try {
              const list = await applicationApi.getApplicationsByJobId(j.id);
              totalApplications += Array.isArray(list) ? list.length : 0;
            } catch {
              // ignore per-job errors
            }
          }
        }
        return {
          totalJobs: jobs.length,
          totalApplications,
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
