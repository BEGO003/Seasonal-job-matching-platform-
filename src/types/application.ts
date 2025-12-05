export type ApplicationStatus =
  | "PENDING"
  | "ACCEPTED"
  | "REJECTED"
  | "INTERVIEW_SCHEDULED";

export interface User {
  id: number;
  name: string;
  country: string;
  number: string;
  email: string;
}

export interface Application {
  id: number;
  user: User;
  applicationStatus: ApplicationStatus;
  jobId: number;
  createdAt: string;
  describeYourself: string;
}

export interface ApplicationStats {
  total: number;
  pending: number;
  accepted: number;
  rejected: number;
  interview_scheduled: number;
}
