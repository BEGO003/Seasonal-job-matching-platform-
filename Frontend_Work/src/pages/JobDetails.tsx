import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import {
  ArrowLeft,
  MapPin,
  DollarSign,
  Users,
  Eye,
  Calendar,
  Clock,
  Edit,
  Trash2,
  CheckCircle,
  Sparkles,
  FolderTree,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { jobApi } from "@/api";
import { applicationApi } from "@/api";
import { Job } from "@/types/job";
import { formatDateRange, formatDateDDMMYYYY } from "@/lib/date";

export default function JobDetails() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [job, setJob] = useState<Job | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [applicantCount, setApplicantCount] = useState<number>(0);

  useEffect(() => {
    const fetchJob = async () => {
      if (!id) return;
      try {
        setLoading(true);
        const jobData = await jobApi.getJobById(Number(id));
        setJob(jobData);
        // Fetch applications count dynamically
        try {
          const apps = await applicationApi.getApplicationsByJobId(Number(id));
          setApplicantCount(apps.length);
        } catch {
          setApplicantCount(0);
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : "Failed to fetch job");
      } finally {
        setLoading(false);
      }
    };
    fetchJob();
  }, [id]);

  const handleBack = () => navigate(-1);
  const handleEdit = () => navigate(`/edit-job/${id}`);

  const handleCloseJob = async () => {
    if (
      !id ||
      !confirm(
        "Are you sure you want to close this job? This will prevent new applications."
      )
    )
      return;
    try {
      await jobApi.updateJob(Number(id), { status: "closed" });
      // Refresh job data to show updated status
      const updatedJob = await jobApi.getJobById(Number(id));
      setJob(updatedJob);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to close job");
    }
  };

  const handleDeleteJob = async () => {
    if (!job) {
      setError("Cannot delete: Job data not loaded");
      return;
    }

    // Use the job object's ID - this is the verified ID from the backend
    const jobId = job.id;

    console.log("[JobDetails] Delete clicked", {
      urlId: id,
      jobId: job.id,
      jobTitle: job.title,
      currentStatus: job.status,
    });

    if (
      !confirm(
        "Are you sure you want to permanently delete this job? This action cannot be undone."
      )
    ) {
      return;
    }

    try {
      console.log("[JobDetails] Calling jobApi.deleteJob with job object", {
        jobId,
        job,
      });
      // Pass the full job object to ensure we have all the correct data
      await jobApi.deleteJob(job);
      console.log("[JobDetails] Delete success, navigating to /dashboard");
      navigate("/dashboard");
    } catch (err) {
      const message =
        err instanceof Error ? err.message : "Failed to delete job";
      console.error("[JobDetails] Delete failed", err);
      setError(message);
      // Show error to user
      alert(`Failed to delete job: ${message}`);
    }
  };

  const statusConfig: Record<string, { label: string; className: string }> = {
    active: { label: "Active", className: "bg-green-600 text-white" },
    draft: { label: "Draft", className: "bg-gray-500 text-white" },
    closed: { label: "Closed", className: "bg-red-500 text-white" },
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-secondary/10 to-background">
        <div className="space-y-4 text-center">
          <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-primary mx-auto"></div>
          <p className="text-muted-foreground">Loading job details...</p>
        </div>
      </div>
    );
  }

  if (error || !job) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-secondary/10 to-background">
        <Card className="max-w-lg w-full p-6 text-center">
          <p className="text-red-500 font-medium mb-4">
            {error || "Job not found"}
          </p>
          <div className="flex justify-center gap-3">
            <Button variant="ghost" onClick={handleBack}>
              Back
            </Button>
          </div>
        </Card>
      </div>
    );
  }

  const statusInfo = statusConfig[job.status] || statusConfig.draft;

  const formatSalaryType = (salaryType: string) => {
    const typeMap: Record<string, string> = {
      YEARLY: "Yearly",
      MONTHLY: "Monthly",
      HOURLY: "Hourly",
    };
    return typeMap[salaryType] || salaryType;
  };

  const formatSalary = () => {
    if (typeof job.amount === "number" && !Number.isNaN(job.amount)) {
      return `$${job.amount.toFixed(2)}/${formatSalaryType(job.salary)}`;
    }
    return "Not specified";
  };

  // Small presentational helpers used in layout
  const MetaRow = ({
    label,
    value,
  }: {
    label: string;
    value: React.ReactNode;
  }) => (
    <div className="flex justify-between items-start text-sm py-2 border-b last:border-b-0 border-border/30">
      <span className="text-muted-foreground">{label}</span>
      <span className="font-medium text-foreground ml-4">{value}</span>
    </div>
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary/10 to-background pb-12">
      {/* Top bar */}
      <div className="sticky top-0 z-40 bg-white/70 backdrop-blur-md border-b border-border/50">
        <div className="max-w-7xl mx-auto px-6 py-3 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <Button
              variant="ghost"
              size="sm"
              onClick={handleBack}
              className="flex items-center gap-2"
            >
              <ArrowLeft className="w-4 h-4" /> Back
            </Button>
            <h1 className="text-lg md:text-2xl font-semibold">Job Details</h1>
          </div>

          <div className="flex items-center gap-2">
            <Badge
              className={`${statusInfo.className} px-4 py-2 rounded-full shadow-sm text-lg`}
            >
              {" "}
              {statusInfo.label}{" "}
            </Badge>
          </div>
        </div>
      </div>

      <main className="max-w-5xl mx-auto px-6 pt-8">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Left column - main content */}
          <Card className="lg:col-span-2 p-6 space-y-6">
            <div className="flex items-start justify-between gap-4">
              <div>
                <h2 className="text-2xl font-bold leading-tight">
                  {job.title}
                </h2>
              </div>
            </div>

            {/* Removed summary tiles (Location, Salary, Applications, Views) per request */}

            <div className="border-t pt-4">
              <h3 className="text-lg font-semibold mb-2">Job Description</h3>
              <p className="text-sm text-muted-foreground leading-relaxed whitespace-pre-wrap">
                {job.description}
              </p>
            </div>

            {job.requirements && job.requirements.length > 0 && (
              <div className="border-t pt-4">
                <h4 className="text-md font-semibold mb-3 flex items-center gap-2">
                  <CheckCircle className="w-4 h-4 text-green-600" />{" "}
                  Requirements
                </h4>
                <ul className="grid gap-2 list-none">
                  {job.requirements.map((r, i) => (
                    <li key={i} className="flex items-start gap-3">
                      <span className="mt-1 text-green-600">
                        <CheckCircle className="w-4 h-4" />
                      </span>
                      <span className="text-sm text-muted-foreground leading-relaxed">
                        {r}
                      </span>
                    </li>
                  ))}
                </ul>
              </div>
            )}

            {job.benefits && job.benefits.length > 0 && (
              <div className="border-t pt-4">
                <h4 className="text-md font-semibold mb-3 flex items-center gap-2">
                  <Sparkles className="w-4 h-4 text-yellow-500" /> Benefits
                </h4>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                  {job.benefits.map((b, i) => (
                    <div
                      key={i}
                      className="p-3 rounded-lg bg-yellow-50 border border-yellow-100 text-sm"
                    >
                      {b}
                    </div>
                  ))}
                </div>
              </div>
            )}

            {job.categories && job.categories.length > 0 && (
              <div className="border-t pt-4">
                <h4 className="text-md font-semibold mb-3 flex items-center gap-2">
                  <FolderTree className="w-4 h-4 text-primary" /> Categories
                </h4>
                <div className="flex flex-wrap gap-2">
                  {job.categories.map((c, i) => (
                    <Badge
                      key={i}
                      className="px-2 py-1 text-xs bg-primary/10 border-primary/20 text-primary"
                    >
                      {c}
                    </Badge>
                  ))}
                </div>
              </div>
            )}
          </Card>

          {/* Right column - compact meta / actions card */}
          <aside className="space-y-4">
            <Card className="p-4">
              <h4 className="text-sm font-semibold text-foreground mb-3">
                Quick Info
              </h4>
              <div className="text-sm">
                <MetaRow
                  label="Job Type"
                  value={<span className="capitalize">{job.jobType}</span>}
                />
                <MetaRow label="Location" value={<span>{job.location}</span>} />
                <MetaRow
                  label="Work Arrangement"
                  value={
                    <span className="capitalize">{job.workArrangement}</span>
                  }
                />
                <MetaRow
                  label="Positions"
                  value={<span>{job.positions}</span>}
                />
                <MetaRow
                  label="Start Date"
                  value={<span>{job.startDate}</span>}
                />
                <MetaRow
                  label="Duration"
                  value={<span>{job.duration} Weeks</span>}
                />
                <MetaRow
                  label="Applications"
                  value={<span>{applicantCount}</span>}
                />
              </div>

              <div className="mt-4 flex flex-col gap-2">
                {job.status === "draft" && (
                  <Button
                    variant="default"
                    onClick={handleEdit}
                    className="w-full"
                  >
                    Edit Job
                  </Button>
                )}
                <Button
                  variant="destructive"
                  onClick={handleCloseJob}
                  className="w-full"
                  disabled={job.status !== "active"}
                >
                  {job.status === "active" ? "Close Job" : "Close Job"}
                </Button>
                <Button
                  variant="destructive"
                  onClick={async () => {
                    console.log("[JobDetails] Delete clicked", {
                      jobId: id,
                      jobposterId: job.id,
                      userId: localStorage.getItem("userId"),
                    });
                    if (
                      confirm(
                        "Are you sure you want to permanently delete this job? This action cannot be undone."
                      )
                    ) {
                      try {
                        await jobApi.deleteJob(Number(id));
                        navigate("/dashboard");
                      } catch (err) {
                        const message =
                          err instanceof Error
                            ? err.message
                            : "Failed to delete job";
                        console.error("[JobDetails] Delete error", {
                          message,
                          err,
                        });
                        alert(`Error: ${message}`);
                      }
                    }
                  }}
                  className="w-full bg-red-600 hover:bg-red-700"
                  disabled={job.status === "active"}
                >
                  Delete Job
                </Button>
              </div>
            </Card>

            <Card className="p-4">
              <h4 className="text-sm font-semibold text-foreground mb-3">
                Salary
              </h4>
              <div className="grid grid-cols-2 gap-3">
                <div className="p-3 bg-secondary/40 rounded-lg text-center col-span-2">
                  <div className="font-bold text-foreground">
                    {formatSalary()}
                  </div>
                </div>
              </div>
            </Card>
          </aside>
        </div>
      </main>
    </div>
  );
}
