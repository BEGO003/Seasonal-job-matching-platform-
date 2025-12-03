export type WorkArrangement = "remote" | "hybrid" | "onsite";
export type JobType =
  | "full-time"
  | "part-time"
  | "contract"
  | "temporary"
  | "freelance"
  | "volunteer"
  | "internship";
export type JobStatus = "active" | "draft" | "closed";

export interface Job {
  id: number;
  title: string;
  description: string;
  location: string;
  jobType: JobType;
  startDate: string;
  endDate: string;
  salary: number;
  positions: number;
  status: JobStatus;
  applications: number;
  views: number;
  workArrangement: WorkArrangement;
  createdAt: string;
  updatedAt: string;
  categories?: string[];
  requirements?: string[];
  benefits?: string[];
}

export interface JobFormData {
  title: string;
  description: string;
  location: string;
  jobType: JobType;
  startDate: string;
  endDate: string;
  salary: number;
  positions: number;
  workArrangement: WorkArrangement;
  status: "active" | "draft" | "closed";
  categories?: string[];
  requirements?: string[];
  benefits?: string[];
}

export interface JobStats {
  totalJobs: number;
  totalApplications: number;
  totalViews: number;
  activeJobs: number;
}

export interface ApiResponse<T> {
  data: T;
  message: string;
  success: boolean;
}
