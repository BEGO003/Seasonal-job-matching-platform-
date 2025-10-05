import { Briefcase, Users, Eye, Clock } from "lucide-react";
import { Header } from "@/components/Header";
import { StatsCard } from "@/components/StatsCard";
import { JobList } from "@/components/JobList";

const Index = () => {
  return (
    <div className="min-h-screen bg-background">
      <Header />
      
      <main className="max-w-7xl mx-auto px-6 py-8">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          <StatsCard
            title="Total Jobs"
            value="12"
            icon={Briefcase}
            iconBgColor="bg-primary/10 text-primary"
          />
          <StatsCard
            title="Applications"
            value="248"
            icon={Users}
            iconBgColor="bg-warning/10 text-warning"
          />
          <StatsCard
            title="Total Views"
            value="1.2K"
            icon={Eye}
            iconBgColor="bg-success/10 text-success"
          />
          <StatsCard
            title="Active Jobs"
            value="8"
            icon={Clock}
            iconBgColor="bg-primary/10 text-primary"
          />
        </div>

        <JobList />
      </main>
    </div>
  );
};

export default Index;
