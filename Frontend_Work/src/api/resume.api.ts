/**
 * Resume API
 * Handles resume-related operations
 */

import { Resume } from "@/types/resume";
import { API_BASE_URL, apiFetch } from "./config";
import { handleResponse } from "./utils";

export const resumeApi = {
  getResumeByUserId: async (userId: number): Promise<Resume> => {
    const response = await apiFetch(`${API_BASE_URL}/resumes/${userId}`);

    const payload = await handleResponse<any>(response);
    return (payload?.data ?? payload) as Resume;
  },
};
