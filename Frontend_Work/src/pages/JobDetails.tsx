import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { ArrowLeft, MapPin, DollarSign, Users, Eye, Calendar, Clock, Edit, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { jobApi } from "@/services/api";
import { Job } from "@/types/job";

const JobDetails = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [job, setJob] = useState<Job | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchJob = async () => {
      if (!id) return;
      
      try {
        setLoading(true);
        const jobData = await jobApi.getJobById(Number(id));
        setJob(jobData);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch job');
      } finally {
        setLoading(false);
      }
    };

    fetchJob();
  }, [id]);

  const handleBack = () => {
    navigate(-1);
  };



  const statusConfig = {
    active: { 
      label: "Active", 
      className: "bg-gradient-to-r from-green-600 to-green-700 text-white",
    },
    draft: { 
      label: "Draft", 
      className: "bg-gradient-to-r from-primary to-primary/90 text-white",
    },
    closed: { 
      label: "Closed", 
      className: "bg-gradient-to-r from-gray-500 to-gray-600 text-white",
    },
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
        <div className="max-w-4xl mx-auto px-6 py-8">
          <div className="text-center py-8">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary mx-auto"></div>
            <p className="mt-2 text-muted-foreground">Loading job details...</p>
          </div>
        </div>
      </div>
    );
  }

  if (error || !job) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
        <div className="max-w-4xl mx-auto px-6 py-8">
          <div className="text-center py-8">
            <p className="text-red-500 mb-4">Error: {error || 'Job not found'}</p>
            <Button onClick={handleBack}>Go Back</Button>
          </div>
        </div>
      </div>
    );
  }

  const statusInfo = statusConfig[job.status];
  const formatSalary = () => {
    if (typeof job.salary === 'number' && !Number.isNaN(job.salary)) {
      return `$${job.salary.toFixed(2)}`;
    }
    return 'Salary not specified';
  };

  const formatDateRange = () => {
    const start = new Date(job.startDate).toLocaleDateString();
    const end = new Date(job.endDate).toLocaleDateString();
    return `${start} - ${end}`;
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
      {/* Header */}
      <div className="bg-white/80 backdrop-blur-sm border-b border-border/50 sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center gap-4">
            <Button 
              variant="ghost" 
              size="sm" 
              onClick={handleBack}
              className="flex items-center gap-2 text-muted-foreground hover:text-foreground"
            >
              <ArrowLeft className="w-4 h-4" />
              Back
            </Button>
            <div className="h-6 w-px bg-border" />
            <h1 className="text-2xl font-bold text-foreground">Job Details</h1>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto px-6 py-8">
        <Card className="p-8">
          <div className="flex items-start justify-between mb-6">
            <div className="flex-1">
              <div className="flex items-center gap-4 mb-4">
                <h2 className="text-3xl font-bold text-foreground">{job.title}</h2>
                <Badge className={`${statusInfo.className} shadow-md`}>{statusInfo.label}</Badge>
              </div>
              
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                <div className="flex items-center gap-2 p-3 bg-secondary/50 rounded-lg">
                  <MapPin className="w-4 h-4 text-primary" />
                  <span className="text-sm font-medium text-foreground">{job.location}</span>
                </div>
                <div className="flex items-center gap-2 p-3 bg-secondary/50 rounded-lg">
                  <DollarSign className="w-4 h-4 text-green-500" />
                  <span className="text-sm font-medium text-foreground">{formatSalary()}</span>
                </div>
                <div className="flex items-center gap-2 p-3 bg-secondary/50 rounded-lg">
                  <Users className="w-4 h-4 text-blue-500" />
                  <span className="text-sm font-medium text-foreground">{job.applications} applications</span>
                </div>
                <div className="flex items-center gap-2 p-3 bg-secondary/50 rounded-lg">
                  <Eye className="w-4 h-4 text-purple-500" />
                  <span className="text-sm font-medium text-foreground">{job.views} views</span>
                </div>
              </div>

              <div className="flex items-center gap-3 mb-6">
                <Badge variant="outline" className="text-xs border-secondary text-foreground bg-secondary">
                  <Calendar className="w-3 h-3 mr-1" />
                  {formatDateRange()}
                </Badge>
                <Badge variant="outline" className="text-xs border-secondary text-foreground bg-secondary">
                  <Users className="w-3 h-3 mr-1" />
                  {job.positions} positions
                </Badge>
                <Badge variant="outline" className="text-xs border-secondary text-foreground bg-secondary">
                  <Clock className="w-3 h-3 mr-1" />
                  {job.jobType}
                </Badge>
              </div>
            </div>
            

          </div>

          <div className="space-y-6">
            <div>
              <h3 className="text-lg font-semibold text-foreground mb-3">Job Description</h3>
              <p className="text-muted-foreground leading-relaxed">{job.description}</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <h4 className="text-md font-semibold text-foreground mb-2">Job Information</h4>
                <div className="space-y-2 text-sm">
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Job Type:</span>
                    <span className="font-medium capitalize">{job.jobType}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Positions:</span>
                    <span className="font-medium">{job.positions}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Status:</span>
                    <Badge className={`${statusInfo.className} text-xs`}>{statusInfo.label}</Badge>
                  </div>
                </div>
              </div>

              <div>
                <h4 className="text-md font-semibold text-foreground mb-2">Timeline</h4>
                <div className="space-y-2 text-sm">
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Start Date:</span>
                    <span className="font-medium">{new Date(job.startDate).toLocaleDateString()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">End Date:</span>
                    <span className="font-medium">{new Date(job.endDate).toLocaleDateString()}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Created:</span>
                    <span className="font-medium">{new Date(job.createdAt).toLocaleDateString()}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </Card>
      </div>
    </div>
  );
};

export default JobDetails;
