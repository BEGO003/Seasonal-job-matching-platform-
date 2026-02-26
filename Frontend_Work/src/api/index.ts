
// Export configuration and utilities
export * from "./config";
export * from "./utils";

// Export API modules
export * from "./auth.api";
export * from "./job.api";
export * from "./application.api";
export * from "./resume.api";

// Set up cross-module dependencies
import { setApplicationApi } from "./job.api";
import { applicationApi } from "./application.api";

// Wire up the application API for job stats calculation
setApplicationApi(applicationApi);
