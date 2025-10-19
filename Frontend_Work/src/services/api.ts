import { Job, JobFormData, JobStats, ApiResponse } from '@/types/job';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

class ApiError extends Error {
  constructor(public status: number, message: string) {
    super(message);
    this.name = 'ApiError';
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

// Helpers to map backend payloads to our UI model
const mapApiStatusToUi = (status?: string): Job['status'] => {
  const s = (status || '').toUpperCase();
  if (s === 'DRAFT') return 'draft';
  if (s === 'CLOSED') return 'closed';
  return 'active';
};

const mapApiJobToJob = (j: any): Job => {
  return {
    id: j.id ?? j.jobId ?? 0,
    title: j.title ?? '',
    description: j.description ?? '',
    location: j.location ?? '',
    jobType: (j.type ?? j.jobType ?? '').toString().toLowerCase(),
    startDate: j.startDate ?? '',
    endDate: j.endDate ?? '',
    salary: typeof j.salary === 'number' ? j.salary : Number(j.salary ?? 0),
    positions: j.numofpositions ?? j.positions ?? 0,
    status: mapApiStatusToUi(j.status),
    applications: j.applications ?? 0,
    views: j.views ?? 0,
    createdAt: j.createdAt ?? new Date().toISOString(),
    updatedAt: j.updatedAt ?? new Date().toISOString(),
  };
};

// Common headers to ensure JSON response and bypass ngrok browser warning page
const commonHeaders: HeadersInit = {
  Accept: 'application/json',
  'ngrok-skip-browser-warning': 'true',
};

export const jobApi = {
  getJobs: async (): Promise<Job[]> => {
    const response = await fetch(`${API_BASE_URL}/job`, { headers: commonHeaders }); // Too fokin Important
    const payload = await handleResponse<any>(response);
    const list = Array.isArray(payload) ? payload : (payload?.data ?? []);
    return list.map(mapApiJobToJob);
  },

  getJobById: async (id: number): Promise<Job> => {
    const response = await fetch(`${API_BASE_URL}/job/${id}`, { headers: commonHeaders });
    const payload = await handleResponse<any>(response);
    const obj = payload?.data ?? payload;
    return mapApiJobToJob(obj);
  },

  createJob: async (jobData: JobFormData): Promise<Job> => {
    const body = {
      title: jobData.title,
      description: jobData.description,
      location: jobData.location,
      type: jobData.jobType,
      startDate: jobData.startDate,
      endDate: jobData.endDate,
      salary: jobData.salary,
      numofpositions: jobData.positions,
      status: jobData.status,
    };
    const response = await fetch(`${API_BASE_URL}/job`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', ...commonHeaders },
      body: JSON.stringify(body)
    });
    const payload = await handleResponse<any>(response);
    const obj = payload?.data ?? payload;
    return mapApiJobToJob(obj);
  },

  updateJob: async (id: number, jobData: Partial<JobFormData>): Promise<Job> => {
    const body = {
      ...(jobData.title !== undefined ? { title: jobData.title } : {}),
      ...(jobData.description !== undefined ? { description: jobData.description } : {}),
      ...(jobData.location !== undefined ? { location: jobData.location } : {}),
      ...(jobData.jobType !== undefined ? { type: jobData.jobType } : {}),
      ...(jobData.startDate !== undefined ? { startDate: jobData.startDate } : {}),
      ...(jobData.endDate !== undefined ? { endDate: jobData.endDate } : {}),
      ...(jobData.salary !== undefined ? { salary: jobData.salary } : {}),
      ...(jobData.positions !== undefined ? { numofpositions: jobData.positions } : {}),
      ...(jobData.status !== undefined ? { status: jobData.status } : {}),
    };
    const response = await fetch(`${API_BASE_URL}/job/${id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json', ...commonHeaders },
      body: JSON.stringify(body)
    });
    const payload = await handleResponse<any>(response);
    const obj = payload?.data ?? payload;
    return mapApiJobToJob(obj);
  },

  deleteJob: async (id: number): Promise<void> => {
    const response = await fetch(`${API_BASE_URL}/job/${id}`, {
      method: 'DELETE'
    });
    await handleResponse(response);
  },

  saveDraft: async (jobData: JobFormData): Promise<Job> => {
    const body = {
      title: jobData.title,
      description: jobData.description,
      location: jobData.location,
      type: jobData.jobType,
      startDate: jobData.startDate,
      endDate: jobData.endDate,
      salary: jobData.salary,
      numofpositions: jobData.positions,
      status: 'DRAFT',
    };
    const response = await fetch(`${API_BASE_URL}/job/draft`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', ...commonHeaders },
      body: JSON.stringify(body)
    });
    const payload = await handleResponse<any>(response);
    const obj = payload?.data ?? payload;
    return mapApiJobToJob(obj);
  },

  getJobStats: async (): Promise<JobStats> => {
    try {
      const response = await fetch(`${API_BASE_URL}/job/stats`, { headers: commonHeaders });
      const payload = await handleResponse<any>(response);
      const data = payload?.data ?? payload;
      return data as JobStats;
    } catch {
      const jobs = await jobApi.getJobs();
      return {
        totalJobs: jobs.length,
        totalApplications: jobs.reduce((sum, j) => sum + (j.applications || 0), 0),
        totalViews: jobs.reduce((sum, j) => sum + (j.views || 0), 0),
        activeJobs: jobs.filter(j => j.status === 'active').length,
      };
    }
  }
};

export { ApiError };
