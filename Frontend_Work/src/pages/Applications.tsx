import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { ArrowLeft, Briefcase } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { applicationApi, jobApi } from "@/api";
import { Application, ApplicationStatus } from "@/types/application";
import { Job } from "@/types/job";
import { ApplicationCard } from "@/components/ApplicationCard";

export default function Applications() {
  const { jobId } = useParams<{ jobId: string }>();
  const navigate = useNavigate();
  const [job, setJob] = useState<Job | null>(null);
  const [applications, setApplications] = useState<Application[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      if (!jobId) return;
      try {
        setLoading(true);
        const jobData = await jobApi.getJobById(Number(jobId));
        setJob(jobData);

        const applicationsData = await applicationApi.getApplicationsByJobId(
          Number(jobId)
        );
        setApplications(applicationsData);
      } catch (err) {
        setError(err instanceof Error ? err.message : "Failed to fetch data");
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [jobId]);

  const handleStatusChange = (appId: number, newStatus: ApplicationStatus) => {
    setApplications((apps) =>
      apps.map((app) =>
        app.id === appId ? { ...app, applicationStatus: newStatus } : app
      )
    );
  };

  const handleDelete = (appId: number) => {
    setApplications((apps) => apps.filter((app) => app.id !== appId));
  };

  const getStatusStats = () => {
    return {
      total: applications.length,
      pending: applications.filter((a) => a.applicationStatus === "PENDING")
        .length,
      accepted: applications.filter((a) => a.applicationStatus === "ACCEPTED")
        .length,
      rejected: applications.filter((a) => a.applicationStatus === "REJECTED")
        .length,
      interview_scheduled: applications.filter(
        (a) => a.applicationStatus === "INTERVIEW_SCHEDULED"
      ).length,
    };
  };

  const stats = getStatusStats();

  const handleBack = () => navigate(-1);

  // centralised colour mapping for statuses (reuse in stats, badges, cards)
  const statusColors: Record<string, string> = {
    PENDING: "#070200ff", // rich amber
    INTERVIEW_SCHEDULED: "#00040aff", // vivid blue
    ACCEPTED: "#000201ff", // green-600 equivalent
    REJECTED: "#0a0000ff", // red-600 equivalent
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-secondary/10 to-background">
        <div className="space-y-4 text-center">
          <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-primary mx-auto"></div>
          <p className="text-muted-foreground">Loading applications...</p>
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
            <h1 className="text-lg md:text-2xl font-semibold">Applications</h1>
          </div>
        </div>
      </div>

      <main className="max-w-6xl mx-auto px-6 pt-8">
        {/* Job Info Card */}
        <Card className="p-6 mb-8 bg-gradient-to-r from-primary/10 to-secondary/10 border-primary/20">
          <div className="flex items-start gap-4">
            <div className="p-3 rounded-lg bg-primary/10">
              <Briefcase className="w-6 h-6 text-primary" />
            </div>
            <div className="flex-1">
              <h2 className="text-2xl font-bold text-foreground mb-2">
                {job.title}
              </h2>
              <p className="text-muted-foreground mb-3">{job.location}</p>
              <div className="flex flex-wrap gap-2">
                <Badge variant="outline" className="capitalize">
                  {job.jobType}
                </Badge>
                <Badge variant="outline" className="capitalize">
                  {job.workArrangement}
                </Badge>
              </div>
            </div>
          </div>
        </Card>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-5 gap-4 mb-8">
          <Card className="p-4">
            <div className="text-sm text-muted-foreground">Total</div>
            <div className="text-3xl font-bold text-foreground">
              {stats.total}
            </div>
          </Card>
          <Card className="p-4 bg-gradient-to-r from-rose-100 to-orange-200">
            <div className="text-sm text-muted-foreground">Pending</div>
            <div className="text-3xl font-bold text-foreground">
              {stats.pending}
            </div>
          </Card>
          <Card className="p-4 bg-gradient-to-r from-cyan-100 to-cyan-300">
            <div className="text-sm text-muted-foreground">Interview</div>
            <div className="text-3xl font-bold text-foreground">
              {stats.interview_scheduled}
            </div>
          </Card>
          <Card className="p-4 bg-gradient-to-r from-green-100 to-green-400/100">
            <div className="text-sm text-muted-foreground">Accepted</div>
            <div className="text-3xl font-bold text-foreground">
              {stats.accepted}
            </div>
          </Card>
          <Card className="p-4 bg-gradient-to-r from-red-100 to-red-400/100">
            <div className="text-sm text-muted-foreground">Rejected</div>
            <div className="text-3xl font-bold text-foreground">
              {stats.rejected}
            </div>
          </Card>
        </div>

        {/* Applications List */}
        {applications.length === 0 ? (
          <Card className="p-12 text-center">
            <p className="text-muted-foreground text-lg">
              No applications yet for this job
            </p>
          </Card>
        ) : (
          <div className="space-y-4">
            {applications.map((application) => (
              <ApplicationCard
                key={application.id}
                application={application}
                onStatusChange={handleStatusChange}
                onDelete={handleDelete}
              />
            ))}
          </div>
        )}
      </main>
    </div>
  );
}
