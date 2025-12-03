import { useState, useEffect } from "react";
import {
  Briefcase,
  Users,
  Eye,
  Clock,
  ArrowRight,
  Sparkles,
} from "lucide-react";
import { Header } from "@/components/Header";
import { StatsCard } from "@/components/StatsCard";
import { JobList } from "@/components/JobList";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { jobApi } from "@/api";
import { JobStats } from "@/types/job";

const Index = () => {
  const navigate = useNavigate();
  const [stats, setStats] = useState<JobStats>({
    totalJobs: 0,
    totalApplications: 0,
    totalViews: 0,
    activeJobs: 0,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const statsData = await jobApi.getJobStats();
        setStats(statsData);
      } catch (error) {
        console.error("Failed to fetch stats:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  const handlePostJob = () => {
    navigate("/post-job");
  };

  const handleSignup = () => {
    navigate("/signup");
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
      <Header />

      {/* Actions + Stats Section */}

      <section className="max-w-7xl mx-auto px-6 py-8">
        <div className="flex flex-col items-center gap-6 mb-12">
          <div className="flex flex-col sm:flex-row gap-4">
            <Button
              size="lg"
              className="bg-primary hover:bg-primary/90 text-white px-8 py-3 text-lg"
              onClick={handlePostJob}
            >
              Post a Job
              <ArrowRight className="ml-2 w-5 h-5" />
            </Button>
            {/* <Button
              size="lg"
              variant="outline"
              className="border-secondary text-foreground hover:bg-secondary px-8 py-3 text-lg"
            >
              Browse Candidates
            </Button> */}
          </div>
          <h2 className="text-3xl font-bold text-foreground mb-4">
            Dashboard Overview
          </h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
          <StatsCard
            title="Total Jobs"
            value={loading ? "..." : stats.totalJobs.toString()}
            icon={Briefcase}
            iconBgColor="bg-gradient-to-br from-primary to-primary/90 text-white"
          />
          <StatsCard
            title="Applications"
            value={loading ? "..." : stats.totalApplications.toString()}
            icon={Users}
            iconBgColor="bg-gradient-to-br from-blue-500 to-blue-600 text-white"
          />

          <StatsCard
            title="Active Jobs"
            value={loading ? "..." : stats.activeJobs.toString()}
            icon={Clock}
            iconBgColor="bg-gradient-to-br from-green-500 to-green-600 text-white"
          />
        </div>

        <JobList />
      </section>
    </div>
  );
};

export default Index;
