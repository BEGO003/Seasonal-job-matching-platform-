import { useState } from "react";
import { ArrowLeft, Briefcase, MapPin, DollarSign, Calendar, Users, FileText } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useNavigate } from "react-router-dom";
import { jobApi } from "@/services/api";
import { JobFormData } from "@/types/job";

const PostJob = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleBack = () => {
    navigate(-1);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const formData = new FormData(e.currentTarget as HTMLFormElement);
      const jobData: JobFormData = {
        title: formData.get('jobTitle') as string,
        description: formData.get('jobdescription') as string,
        location: formData.get('location') as string,
        jobType: formData.get('jobType') as 'full-time' | 'part-time' | 'contract' | 'temporary',
        startDate: formData.get('startDate') as string,
        endDate: formData.get('endDate') as string,
        salary: Number(formData.get('salary')),
        positions: Number(formData.get('positions')),
        status: 'active'
      };

      await jobApi.createJob(jobData);
      navigate(-1);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to create job');
    } finally {
      setLoading(false);
    }
  };

  const handleSaveDraft = async () => {
    setLoading(true);
    setError(null);

    try {
      const form = document.querySelector('form') as HTMLFormElement;
      const formData = new FormData(form);
      const jobData: JobFormData = {
        title: formData.get('jobTitle') as string,
        description: formData.get('jobdescription') as string,
        location: formData.get('location') as string,
        jobType: formData.get('jobType') as 'full-time' | 'part-time' | 'contract' | 'temporary',
        startDate: formData.get('startDate') as string,
        endDate: formData.get('endDate') as string,
        salary: Number(formData.get('salary')),
        positions: Number(formData.get('positions')),
        status: 'draft'
      };

      await jobApi.saveDraft(jobData);
      navigate(-1);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to save draft');
    } finally {
      setLoading(false);
    }
  };
  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
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
            <h1 className="text-2xl font-bold text-foreground">Post a New Job</h1>
          </div>
        </div>
      </div>

      <div className="max-w-4xl mx-auto px-6 py-8">
        <Card className="p-8">
          <div className="mb-8">
            <div className="flex items-center gap-3 mb-2">
              <Briefcase className="w-6 h-6 text-primary" />
              <h2 className="text-xl font-semibold text-foreground">Job Information</h2>
            </div>
          </div>

          {error && (
            <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
              <p className="text-red-600">{error}</p>
            </div>
          )}

          <form className="space-y-6" onSubmit={handleSubmit}>
            <div className="space-y-2">
              <Label htmlFor="jobTitle" className="text-sm font-medium">Job Title *</Label>
              <Input 
                id="jobTitle" 
                placeholder="e.g., Software Engineer" 
                className="w-full"
              />
            </div>

            
            <div className="space-y-2">
              <Label htmlFor="jobdescription" className="text-sm font-medium">Job Description *</Label>
              <Input 
                id="jobdescription" 
                placeholder="e.g., We want a Software Engineer for our company" 
                className="w-full"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="location" className="text-sm font-medium flex items-center gap-2">
                <MapPin className="w-4 h-4" />
                Location *
              </Label>
              <Input 
                id="location" 
                placeholder="e.g., New York, NY" 
                className="w-full"
              />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <Label htmlFor="salary" className="text-sm font-medium flex items-center gap-2">
                  <DollarSign className="w-4 h-4" />
                  Salary *
                </Label>
                <Input 
                  id="salary"
                  name="salary"
                  placeholder="e.g., 100.00" 
                  type="number"
                  step="0.01"
                  min="0"
                  className="w-full"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="jobType" className="text-sm font-medium">Job Type *</Label>
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder="Select job type" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="full-time">Full-time</SelectItem>
                    <SelectItem value="part-time">Part-time</SelectItem>
                    <SelectItem value="contract">Contract</SelectItem>
                    <SelectItem value="temporary">Temporary</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <Label htmlFor="startDate" className="text-sm font-medium flex items-center gap-2">
                  <Calendar className="w-4 h-4" />
                  Start Date *
                </Label>
                <Input 
                  id="startDate"
                  name="startDate"
                  type="date" 
                  className="w-full"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="endDate" className="text-sm font-medium flex items-center gap-2">
                  <Calendar className="w-4 h-4" />
                  End Date *
                </Label>
                <Input 
                  id="endDate"
                  name="endDate"
                  type="date" 
                  className="w-full"
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="positions" className="text-sm font-medium flex items-center gap-2">
                <Users className="w-4 h-4" />
                Number of Positions *
              </Label>
              <Input 
                id="positions" 
                placeholder="e.g., 5" 
                type="number"
                className="w-full md:w-32"
              />
            </div>

            



            <div className="flex flex-col sm:flex-row gap-4 pt-6 border-t border-border">
              <Button 
                type="submit" 
                disabled={loading}
                className="bg-primary hover:bg-primary/90 text-white px-8 py-2 disabled:opacity-50"
              >
                {loading ? 'Posting...' : 'Post Job'}
              </Button>
              <Button 
                type="button" 
                variant="outline" 
                onClick={handleSaveDraft}
                disabled={loading}
                className="border-secondary text-foreground hover:bg-secondary px-8 py-2 disabled:opacity-50"
              >
                {loading ? 'Saving...' : 'Save as Draft'}
              </Button>
              <Button 
                type="button" 
                variant="ghost" 
                onClick={handleBack}
                disabled={loading}
                className="text-muted-foreground hover:text-foreground px-8 py-2 disabled:opacity-50"
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
