import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import {
  ArrowLeft,
  Briefcase,
  MapPin,
  DollarSign,
  Calendar,
  Users,
  Plus,
  X,
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
import {
  JobFormData,
  WorkArrangement,
  JobType,
  Job,
  SalaryType,
} from "@/types/job";
import { Textarea } from "@/components/ui/textarea";

const PostJob = () => {
  const DatePickerAny = DatePicker as any;
  const navigate = useNavigate();
  const { id } = useParams<{ id: string }>();
  const isEditMode = !!id;
  const [loading, setLoading] = useState(false);
  const [loadingJob, setLoadingJob] = useState(isEditMode);
  const [error, setError] = useState<string | null>(null);
  const [jobType, setJobType] = useState<JobType | "">("");
  const [workArrangement, setWorkArrangement] = useState<WorkArrangement | "">(
    ""
  );
  const [categories, setCategories] = useState<string[]>([]);
  const [requirements, setRequirements] = useState<string[]>([]);
  const [benefits, setBenefits] = useState<string[]>([]);
  const [newCategory, setNewCategory] = useState("");
  const [newRequirement, setNewRequirement] = useState("");
  const [newBenefit, setNewBenefit] = useState("");
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [duration, setDuration] = useState("");
  const [currentJob, setCurrentJob] = useState<Job | null>(null);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [location, setLocation] = useState("");
  const [amount, setAmount] = useState("");
  const [salaryType, setSalaryType] = useState<SalaryType | "">("YEARLY");
  const [positions, setPositions] = useState("");

  // Load job data if editing
  useEffect(() => {
    const loadJob = async () => {
      if (!id) return;
      try {
        setLoadingJob(true);
        const job = await jobApi.getJobById(Number(id));
        setCurrentJob(job);

        // Populate form fields
        if (job) {
          setTitle(job.title || "");
          setDescription(job.description || "");
          setLocation(job.location || "");
          setAmount(String(job.amount || 0));
          setSalaryType(job.salary || "YEARLY");
          setDuration(String(job.duration || 0));
          setPositions(String(job.positions || 1));
          setJobType(job.jobType || "");
          setWorkArrangement(job.workArrangement || "");

          // Set start date
          if (job.startDate) {
            const [year, month, day] = job.startDate.split("-");
            setStartDate(
              new Date(Number(year), Number(month) - 1, Number(day))
            );
          }

          // Set arrays
          console.log("[PostJob] Loaded arrays from job:", {
            categories: job.categories,
            requirements: job.requirements,
            benefits: job.benefits,
          });
          setCategories(job.categories || []);
          setRequirements(job.requirements || []);
          setBenefits(job.benefits || []);
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : "Failed to load job");
      } finally {
        setLoadingJob(false);
      }
    };

    loadJob();
  }, [id]);

  const handleBack = () => navigate(-1);

  const addCategory = () => {
    if (newCategory.trim() && !categories.includes(newCategory.trim())) {
      setCategories([...categories, newCategory.trim()]);
      setNewCategory("");
    }
  };

  const removeCategory = (index: number) => {
    setCategories(categories.filter((_, i) => i !== index));
  };

  const addRequirement = () => {
    if (
      newRequirement.trim() &&
      !requirements.includes(newRequirement.trim())
    ) {
      setRequirements([...requirements, newRequirement.trim()]);
      setNewRequirement("");
    }
  };

  const removeRequirement = (index: number) => {
    setRequirements(requirements.filter((_, i) => i !== index));
  };

  const addBenefit = () => {
    if (newBenefit.trim() && !benefits.includes(newBenefit.trim())) {
      setBenefits([...benefits, newBenefit.trim()]);
      setNewBenefit("");
    }
  };

  const removeBenefit = (index: number) => {
    setBenefits(benefits.filter((_, i) => i !== index));
  };

  const validateForm = (data: JobFormData): string | null => {
    if (!data.title?.trim()) return "Job title is required.";
    if (!data.description?.trim()) return "Job description is required.";
    if (!data.location?.trim()) return "Location is required.";
    if (!data.jobType) return "Please select a job type.";
    if (!data.workArrangement) return "Please select a work arrangement.";
    if (!data.startDate) return "Start date is required.";
    if (!data.duration || data.duration <= 0)
      return "Duration must be a valid positive number.";
    if (!data.amount || data.amount <= 0)
      return "Amount must be a valid positive number.";
    if (!data.salary) return "Please select a salary type.";
    if (!data.positions || data.positions <= 0)
      return "Number of positions must be a valid positive number.";

    // Require at least one category
    if (!data.categories || data.categories.length === 0) {
      return "At least one category is required.";
    }

    // Require at least one requirement
    if (!data.requirements || data.requirements.length === 0) {
      return "At least one requirement is required.";
    }

    // Require at least one benefit
    if (!data.benefits || data.benefits.length === 0) {
      return "At least one benefit is required.";
    }

    return null;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    const toYmd = (d: Date | null): string => {
      if (!d) return "";
      const y = d.getFullYear();
      const m = String(d.getMonth() + 1).padStart(2, "0");
      const day = String(d.getDate()).padStart(2, "0");
      return `${y}-${m}-${day}`;
    };
    const jobData: JobFormData = {
      title: title,
      description: description,
      location: location,
      jobType: jobType as "full-time" | "part-time" | "contract" | "temporary",
      workArrangement: workArrangement as WorkArrangement,
      startDate: toYmd(startDate),
      duration: Number(duration),
      amount: Number(amount),
      salary: salaryType as SalaryType,
      positions: Number(positions),
      // If editing a draft and all fields are filled, make it active
      status:
        isEditMode && currentJob?.status === "draft"
          ? "active"
          : isEditMode && currentJob
          ? currentJob.status
          : "active",
      // Always send arrays, even if empty
      categories: categories,
      requirements: requirements,
      benefits: benefits,
    };

    const validationError = validateForm(jobData);
    if (validationError) {
      setError(validationError);
      setLoading(false);
      return;
    }

    try {
      if (isEditMode && id) {
        // When posting a draft job, set status to active if all fields are valid
        const updateData = {
          ...jobData,
          status: currentJob?.status === "draft" ? "active" : jobData.status,
        };
        console.log("[PostJob] Updating draft job with:", {
          id,
          title: updateData.title,
          categories: updateData.categories,
          requirements: updateData.requirements,
          benefits: updateData.benefits,
          status: updateData.status,
        });
        await jobApi.updateJob(Number(id), updateData);
      } else {
        await jobApi.createJob(jobData);
      }
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

    const toYmd = (d: Date | null): string => {
      if (!d) return "";
      const y = d.getFullYear();
      const m = String(d.getMonth() + 1).padStart(2, "0");
      const day = String(d.getDate()).padStart(2, "0");
      return `${y}-${m}-${day}`;
    };
    const jobData: JobFormData = {
      title: title,
      description: description,
      location: location,
      jobType: jobType as "full-time" | "part-time" | "contract" | "temporary",
      workArrangement: workArrangement as WorkArrangement,
      startDate: toYmd(startDate),
      duration: Number(duration),
      amount: Number(amount),
      salary: salaryType as SalaryType,
      positions: Number(positions),
      status: "draft",
      // Always send arrays, even if empty
      categories: categories,
      requirements: requirements,
      benefits: benefits,
    };

    // For drafts, validate that there's at least some data
    if (!jobData.title?.trim() && !jobData.description?.trim()) {
      setError(
        "Please fill at least the job title or description to save a draft"
      );
      setLoading(false);
      return;
    }

    // For drafts, if arrays are empty, use placeholder values (backend doesn't allow null)
    // User's actual data will be used when provided
    if (!jobData.categories || jobData.categories.length === 0) {
      jobData.categories = ["To be added"];
    }
    if (!jobData.requirements || jobData.requirements.length === 0) {
      jobData.requirements = ["To be added"];
    }
    if (!jobData.benefits || jobData.benefits.length === 0) {
      jobData.benefits = ["To be added"];
    }

    try {
      if (isEditMode && id) {
        // Update existing job as draft
        console.log("[PostJob] Saving draft with:", {
          id,
          title: jobData.title,
          categories: jobData.categories,
          requirements: jobData.requirements,
          benefits: jobData.benefits,
        });
        await jobApi.updateJob(Number(id), { ...jobData, status: "draft" });
      } else {
        await jobApi.saveDraft(jobData);
      }
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
          <h1 className="text-2xl font-bold text-foreground">
            {isEditMode ? "Edit Job" : "Post a New Job"}
          </h1>
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

          {loadingJob && (
            <div className="mb-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
              <p className="text-blue-600">Loading job data...</p>
            </div>
          )}

          <form className="space-y-6" onSubmit={handleSubmit}>
            <div className="space-y-2">
              <Label htmlFor="jobTitle">Job Title *</Label>
              <Input
                id="jobTitle"
                name="jobTitle"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="e.g., Software Engineer"
                disabled={loadingJob}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="jobdescription">Job Description *</Label>
              <Textarea
                id="jobdescription"
                name="jobdescription"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                placeholder="e.g., We are looking for a backend developer with 3 years of experience in Node.js and React."
                className="min-h-[120px]"
                disabled={loadingJob}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="location" className="flex items-center gap-2">
                <MapPin className="w-4 h-4" /> Location *
              </Label>
              <Input
                id="location"
                name="location"
                value={location}
                onChange={(e) => setLocation(e.target.value)}
                placeholder="e.g., Cairo, Egypt"
                disabled={loadingJob}
              />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="space-y-2">
                <Label htmlFor="amount" className="flex items-center gap-2">
                  <DollarSign className="w-4 h-4" /> Amount *
                </Label>
                <Input
                  id="amount"
                  name="amount"
                  type="number"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                  placeholder="e.g., 5000"
                  min="0"
                  step="0.01"
                  disabled={loadingJob}
                />
              </div>

              <div className="space-y">
                <Label htmlFor="salaryType">Salary Type *</Label>
                <Select
                  value={salaryType}
                  onValueChange={(value) => setSalaryType(value as SalaryType)}
                  disabled={loadingJob}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select salary type" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="YEARLY">Yearly</SelectItem>
                    <SelectItem value="MONTHLY">Monthly</SelectItem>
                    <SelectItem value="HOURLY">Hourly</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="duration" className="flex items-center gap-2">
                  <Calendar className="w-4 h-4" /> Duration (Weeks) *
                </Label>
                <Input
                  id="duration"
                  name="duration"
                  type="number"
                  value={duration}
                  onChange={(e) => setDuration(e.target.value)}
                  placeholder="e.g., 120"
                  min="1"
                  disabled={loadingJob}
                />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <Label htmlFor="jobType">Job Type *</Label>
                <Select
                  value={jobType}
                  onValueChange={(value) => setJobType(value as any)}
                  disabled={loadingJob}
                >
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
                  value={workArrangement}
                  onValueChange={(value) =>
                    setWorkArrangement(value as WorkArrangement)
                  }
                  disabled={loadingJob}
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
                <DatePickerAny
                  selected={startDate}
                  onChange={(date: Date | null) => setStartDate(date)}
                  dateFormat="dd/MM/yyyy"
                  customInput={<Input disabled={loadingJob} />}
                  placeholderText="dd/mm/yyyy"
                  disabled={loadingJob}
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="positions" className="flex items-center gap-2">
                  <Users className="w-4 h-4" /> Number of Positions *
                </Label>
                <Input
                  id="positions"
                  name="positions"
                  type="number"
                  value={positions}
                  onChange={(e) => setPositions(e.target.value)}
                  placeholder="e.g., 3"
                  min="1"
                  disabled={loadingJob}
                />
              </div>
            </div>

            {/* Categories Section */}
            <div className="space-y-3 pt-4 border-t">
              <Label htmlFor="categories">Categories *</Label>
              <div className="flex gap-2">
                <Input
                  id="categories"
                  value={newCategory}
                  onChange={(e) => setNewCategory(e.target.value)}
                  onKeyPress={(e) =>
                    e.key === "Enter" && (e.preventDefault(), addCategory())
                  }
                  placeholder="e.g., DevOps, Cloud Computing"
                  disabled={loadingJob}
                />
                <Button
                  type="button"
                  variant="outline"
                  onClick={addCategory}
                  className="flex items-center gap-1"
                >
                  <Plus className="w-4 h-4" /> Add
                </Button>
              </div>
              {categories.length > 0 ? (
                <div className="flex flex-wrap gap-2 mt-2">
                  {categories.map((category, index) => (
                    <span
                      key={index}
                      className="inline-flex items-center gap-1 px-3 py-1 bg-primary/10 text-primary rounded-full text-sm"
                    >
                      {category}
                      <button
                        type="button"
                        onClick={() => removeCategory(index)}
                        className="hover:bg-primary/20 rounded-full p-0.5"
                      >
                        <X className="w-3 h-3" />
                      </button>
                    </span>
                  ))}
                </div>
              ) : (
                <p className="text-sm text-muted-foreground mt-2">
                  At least one category is required
                </p>
              )}
            </div>

            {/* Requirements Section */}
            <div className="space-y-3">
              <Label htmlFor="requirements">Requirements *</Label>
              <div className="flex gap-2">
                <Input
                  id="requirements"
                  value={newRequirement}
                  onChange={(e) => setNewRequirement(e.target.value)}
                  onKeyPress={(e) =>
                    e.key === "Enter" && (e.preventDefault(), addRequirement())
                  }
                  placeholder="e.g., 5+ years AWS/Azure experience"
                  disabled={loadingJob}
                />
                <Button
                  type="button"
                  variant="outline"
                  onClick={addRequirement}
                  className="flex items-center gap-1"
                >
                  <Plus className="w-4 h-4" /> Add
                </Button>
              </div>
              {requirements.length > 0 ? (
                <ul className="space-y-2 mt-2">
                  {requirements.map((req, index) => (
                    <li
                      key={index}
                      className="flex items-start gap-2 p-2 bg-secondary/50 rounded-md"
                    >
                      <span className="flex-1 text-sm">{req}</span>
                      <button
                        type="button"
                        onClick={() => removeRequirement(index)}
                        className="hover:bg-destructive/10 rounded-full p-1"
                      >
                        <X className="w-4 h-4 text-destructive" />
                      </button>
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="text-sm text-muted-foreground mt-2">
                  At least one requirement is required
                </p>
              )}
            </div>

            {/* Benefits Section */}
            <div className="space-y-3">
              <Label htmlFor="benefits">Benefits *</Label>
              <div className="flex gap-2">
                <Input
                  id="benefits"
                  value={newBenefit}
                  onChange={(e) => setNewBenefit(e.target.value)}
                  onKeyPress={(e) =>
                    e.key === "Enter" && (e.preventDefault(), addBenefit())
                  }
                  placeholder="e.g., Unlimited PTO, Stock Options"
                  disabled={loadingJob}
                />
                <Button
                  type="button"
                  variant="outline"
                  onClick={addBenefit}
                  className="flex items-center gap-1"
                >
                  <Plus className="w-4 h-4" /> Add
                </Button>
              </div>
              {benefits.length > 0 ? (
                <ul className="space-y-2 mt-2">
                  {benefits.map((benefit, index) => (
                    <li
                      key={index}
                      className="flex items-start gap-2 p-2 bg-green-50 rounded-md"
                    >
                      <span className="flex-1 text-sm">{benefit}</span>
                      <button
                        type="button"
                        onClick={() => removeBenefit(index)}
                        className="hover:bg-destructive/10 rounded-full p-1"
                      >
                        <X className="w-4 h-4 text-destructive" />
                      </button>
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="text-sm text-muted-foreground mt-2">
                  At least one benefit is required
                </p>
              )}
            </div>

            <div className="flex flex-col sm:flex-row gap-4 pt-6 ">
              <Button
                type="submit"
                disabled={loading || loadingJob}
                className="bg-primary hover:bg-primary/90 text-white px-8 py-2"
              >
                {loading ? "Posting..." : "Post Job"}
              </Button>
              {/* <Button
                type="button"
                variant="outline"
                onClick={handleSaveDraft}
                disabled={loading || loadingJob}
                className="border-secondary text-foreground hover:bg-secondary px-8 py-2"
              >
                {loading
                  ? "Saving..."
                  : isEditMode
                  ? "Save as Draft"
                  : "Save as Draft"}
              </Button> */}
              <Button
                type="button"
                variant="outline"
                onClick={handleBack}
                disabled={loading || loadingJob}
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
