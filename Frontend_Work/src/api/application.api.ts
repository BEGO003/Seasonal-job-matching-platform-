
import { Application, ApplicationStatus } from "@/types/application";
import { API_BASE_URL, apiFetch } from "./config";
import { handleResponse, ApiError } from "./utils";

export const applicationApi = {
  // Get all applications for a specific job
  getApplicationsByJobId: async (jobId: number): Promise<Application[]> => {
    const response = await apiFetch(`${API_BASE_URL}/applications/job/${jobId}`);

    const payload = await handleResponse<any>(response);
    const list = Array.isArray(payload) ? payload : payload?.data ?? [];
    return list;
  },

  // Update application status
  updateApplicationStatus: async (
    applicationId: number,
    status: ApplicationStatus,
    employerId?: number
  ): Promise<Application> => {
    const resolvedEmployerIdRaw = employerId ?? localStorage.getItem("userId");
    const resolvedEmployerId = Number(resolvedEmployerIdRaw);
    if (!Number.isFinite(resolvedEmployerId)) {
      throw new ApiError(
        401,
        "Not authenticated: missing employer id to update application status"
      );
    }

    // Map UI status to backend expected enum casing
    const toBackendStatus = (s: ApplicationStatus): string => {
      const map: Record<ApplicationStatus, string> = {
        PENDING: "PENDING",
        ACCEPTED: "ACCEPTED",
        REJECTED: "REJECTED",
        INTERVIEW_SCHEDULED: "INTERVIEW_SCHEDULED",
      } as any;
      return map[s] || String(s).toUpperCase();
    };
    const backendStatus = toBackendStatus(status);

    const url = `${API_BASE_URL}/applications/${applicationId}/status/employer/${resolvedEmployerId}`;
    const response = await apiFetch(url, {
      method: "PATCH",
      // Some backends require redundant fields; include them defensively
      body: JSON.stringify({
        status: backendStatus,
        applicationId,
        employerId: resolvedEmployerId,
      }),
    });
    console.log("[applicationApi.updateApplicationStatus]", {
      applicationId,
      employerId: resolvedEmployerId,
      statusSent: backendStatus,
      url,
    });
    const payload = await handleResponse<any>(response);
    console.log("[applicationApi.updateApplicationStatus] response", {
      status: response.status,
      ok: response.ok,
      keys: Object.keys(payload || {}),
    });
    return (payload?.data ?? payload) as Application;
  },

  // Delete application
  deleteApplication: async (applicationId: number): Promise<void> => {
    await apiFetch(`${API_BASE_URL}/applications/${applicationId}`, {
      method: "DELETE",
    });
  },
};
