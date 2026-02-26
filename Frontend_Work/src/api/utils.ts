/**
 * API Utilities
 * Shared utilities for error handling, response processing, and data mapping
 */

import { Job } from "@/types/job";

/**
 * Custom API Error class
 */
export class ApiError extends Error {
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
export const handleResponse = async <T>(response: Response): Promise<T> => {
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

// -------------------- Status and Type Mappers --------------------

export const mapApiStatusToUi = (status?: string): Job["status"] => {
  const s = (status || "").toUpperCase();
  if (s === "DRAFT") return "draft";
  if (s === "CLOSED") return "closed";
  return "active"; // OPEN maps to active in UI
};

export const mapUiStatusToBackend = (status: Job["status"]): string => {
  const mapping: Record<Job["status"], string> = {
    active: "OPEN",
    draft: "DRAFT",
    closed: "CLOSED",
  };
  return mapping[status] || "OPEN";
};

export const mapUiJobTypeToBackend = (jobType: string): string => {
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

export const mapBackendJobTypeToUi = (jobType: string): Job["jobType"] => {
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

/**
 * Map API job object to UI Job type
 */
export const mapApiJobToJob = (j: any): Job => {
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

  const mapSalaryType = (val: any): string => {
    const s = (val || "").toString().toUpperCase();
    if (s === "YEARLY" || s === "ANNUAL") return "YEARLY";
    if (s === "MONTHLY") return "MONTHLY";
    if (s === "HOURLY") return "HOURLY";
    return "YEARLY"; // Default
  };

  return {
    id: j.id ?? 0,
    title: j.title ?? "",
    description: j.description ?? "",
    location: j.location ?? "",
    jobType: mapBackendJobTypeToUi(j.jobType ?? j.type ?? ""),
    startDate: normalizeDate(j.startDate ?? j.StartDate ?? j.start_date),
    duration:
      typeof j.duration === "number" ? j.duration : Number(j.duration ?? 0),
    amount: typeof j.amount === "number" ? j.amount : Number(j.amount ?? 0),
    salary: mapSalaryType(j.salary ?? "YEARLY") as any,
    positions: j.positions ?? j.numofpositions ?? j.numOfPositions ?? 0,
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

/**
 * Format date from YYYY-MM-DD to DD-MM-YYYY for backend
 */
export const formatDateForBackend = (dateStr: string): string => {
  if (!dateStr || dateStr.trim() === "") return "";
  const [year, month, day] = dateStr.split("-");
  return `${day}-${month}-${year}`;
};
