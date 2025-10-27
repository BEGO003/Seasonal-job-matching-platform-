import { useState } from "react";
import {
  ArrowLeft,
  Briefcase,
  MapPin,
  DollarSign,
  Calendar,
  Users,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useNavigate } from "react-router-dom";
import { jobApi, ApiError } from "@/api";
import { JobFormData, WorkArrangement, JobType } from "@/types/job";

const PostJob = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [jobType, setJobType] = useState<JobType | "">("");
  const [workArrangement, setWorkArrangement] = useState<WorkArrangement | "">(
    ""
  );

  const handleBack = () => navigate(-1);

  const validateForm = (data: JobFormData): string | null => {
    if (!data.title?.trim()) return "Job title is required.";
    if (!data.description?.trim()) return "Job description is required.";
    if (!data.location?.trim()) return "Location is required.";
    if (!data.jobType) return "Please select a job type.";
    if (!data.workArrangement) return "Please select a work arrangement.";
    if (!data.startDate) return "Start date is required.";
    if (!data.endDate) return "End date is required.";
    if (isNaN(data.salary) || data.salary <= 0)
      return "Salary must be a valid positive number.";
    if (isNaN(data.positions) || data.positions <= 0)
      return "Number of positions must be a valid positive number.";

    const start = new Date(data.startDate);
    const end = new Date(data.endDate);
    if (start >= end) return "Start date must be earlier than end date.";

    return null;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    const formData = new FormData(e.currentTarget as HTMLFormElement);
    const jobData: JobFormData = {
      title: formData.get("jobTitle") as string,
      description: formData.get("jobdescription") as string,
      location: formData.get("location") as string,
      jobType: jobType as "full-time" | "part-time" | "contract" | "temporary",
      workArrangement: workArrangement as WorkArrangement,
      startDate: formData.get("startDate") as string,
      endDate: formData.get("endDate") as string,
      salary: Number(formData.get("salary")),
      positions: Number(formData.get("positions")),
      status: "active",
    };

    const validationError = validateForm(jobData);
    if (validationError) {
      setError(validationError);
      setLoading(false);
      return;
    }

    try {
      await jobApi.createJob(jobData);
      navigate(-1);
    } catch (err) {
      if (err instanceof ApiError) {
        if (err.status === 401) {
          setError("Please login first or check your authorization");
        } else {
          setError(`API Error: ${err.message}`);
        }
      } else {
        setError(err instanceof Error ? err.message : "Failed to create job");
      }
    } finally {
      setLoading(false);
    }
  };

  const handleSaveDraft = async () => {
    setLoading(true);
    setError(null);

    const form = document.querySelector("form") as HTMLFormElement;
    const formData = new FormData(form);
    const jobData: JobFormData = {
      title: formData.get("jobTitle") as string,
      description: formData.get("jobdescription") as string,
      location: formData.get("location") as string,
      jobType: jobType as "full-time" | "part-time" | "contract" | "temporary",
      workArrangement: workArrangement as WorkArrangement,
      startDate: formData.get("startDate") as string,
      endDate: formData.get("endDate") as string,
      salary: Number(formData.get("salary")),
      positions: Number(formData.get("positions")),
      status: "draft",
    };

    // For drafts, only validate that there's at least some data
    if (!jobData.title?.trim() && !jobData.description?.trim()) {
      setError("Please fill at least the job title or description to save a draft");
      setLoading(false);
      return;
    }

    try {
      await jobApi.saveDraft(jobData);
      navigate(-1);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Failed to save draft");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
      <div className="bg-white/80 backdrop-blur-sm border-b border-border/50 sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center gap-4">
          <Button
            variant="ghost"
            size="sm"
            onClick={handleBack}
            className="flex items-center gap-2 text-muted-foreground hover:text-foreground"
          >
            <ArrowLeft className="w-4 h-4" /> Back
          </Button>
          <div className="h-6 w-px bg-border" />
          <h1 className="text-2xl font-bold text-foreground">Post a New Job</h1>
        </div>
      </div>

      <div className="max-w-4xl mx-auto px-6 py-8">
        <Card className="p-8">
          <div className="mb-8 flex items-center gap-3">
            <Briefcase className="w-6 h-6 text-primary" />
            <h2 className="text-xl font-semibold text-foreground">
              Job Information
            </h2>
          </div>

          {error && (
            <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
              <p className="text-red-600">{error}</p>
            </div>
          )}

          <form className="space-y-6" onSubmit={handleSubmit}>
            <div className="space-y-2">
              <Label htmlFor="jobTitle">Job Title *</Label>
              <Input
                id="jobTitle"
                name="jobTitle"
                placeholder="e.g., Software Engineer"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="jobdescription">Job Description *</Label>
              <Input
                id="jobdescription"
                name="jobdescription"
                placeholder="e.g., We need a backend developer"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="location" className="flex items-center gap-2">
                <MapPin className="w-4 h-4" /> Location *
              </Label>
              <Input
                id="location"
                name="location"
                placeholder="e.g., Cairo, Egypt"
              />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <Label htmlFor="salary" className="flex items-center gap-2">
                  <DollarSign className="w-4 h-4" /> Salary *
                </Label>
                <Input
                  id="salary"
                  name="salary"
                  type="number"
                  placeholder="e.g., 5000"
                  min="0"
                  step="0.01"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="jobType">Job Type *</Label>
                <Select onValueChange={(value) => setJobType(value as any)}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select job type" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="full-time">Full-time</SelectItem>
                    <SelectItem value="part-time">Part-time</SelectItem>
                    <SelectItem value="contract">Contract</SelectItem>
                    <SelectItem value="temporary">Temporary</SelectItem>
                    <SelectItem value="freelance">Freelance</SelectItem>
                    <SelectItem value="volunteer">Volunteer</SelectItem>
                    <SelectItem value="internship">Internship</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="workArrangement">Work Arrangement *</Label>
                <Select
                  onValueChange={(value) =>
                    setWorkArrangement(value as WorkArrangement)
                  }
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select work arrangement" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="remote">Remote</SelectItem>
                    <SelectItem value="hybrid">Hybrid</SelectItem>
                    <SelectItem value="onsite">Onsite</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <Label htmlFor="startDate" className="flex items-center gap-2">
                  <Calendar className="w-4 h-4" /> Start Date *
                </Label>
                <Input id="startDate" name="startDate" type="date" />
              </div>

              <div className="space-y-2">
                <Label htmlFor="endDate" className="flex items-center gap-2">
                  <Calendar className="w-4 h-4" /> End Date *
                </Label>
                <Input id="endDate" name="endDate" type="date" />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="positions" className="flex items-center gap-2">
                <Users className="w-4 h-4" /> Number of Positions *
              </Label>
              <Input
                id="positions"
                name="positions"
                type="number"
                placeholder="e.g., 3"
                min="1"
              />
            </div>

            <div className="flex flex-col sm:flex-row gap-4 pt-6 ">
              <Button
                type="submit"
                disabled={loading}
                className="bg-primary hover:bg-primary/90 text-white px-8 py-2"
              >
                {loading ? "Posting..." : "Post Job"}
              </Button>
              <Button
                type="button"
                variant="outline"
                onClick={handleSaveDraft}
                disabled={loading}
                className="border-secondary text-foreground hover:bg-secondary px-8 py-2"
              >
                {loading ? "Saving..." : "Save as Draft"}
              </Button>
              <Button
                type="button"
                variant="outline"
                onClick={handleBack}
                disabled={loading}
                className="border-secondary text-foreground hover:bg-secondary px-8 py-2"
              >
                Cancel
              </Button>
            </div>
          </form>
        </Card>
      </div>
    </div>
  );
};

export default PostJob;
