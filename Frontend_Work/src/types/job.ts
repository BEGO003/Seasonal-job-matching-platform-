export interface Job {
  id: number;
  title: string;
  description: string;
  location: string;
  jobType: 'full-time' | 'part-time' | 'contract' | 'temporary';
  startDate: string;
  endDate: string;
  salary: number; 
  positions: number;
  status: 'active' | 'draft' | 'closed';
  applications: number;
  views: number;
  createdAt: string;
  updatedAt: string;
}

export interface JobFormData {
  title: string;
  description: string;
  location: string;
  jobType: 'full-time' | 'part-time' | 'contract' | 'temporary';
  startDate: string;
  endDate: string;
  salary: number; 
  positions: number;
  status: 'active' | 'draft';
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
