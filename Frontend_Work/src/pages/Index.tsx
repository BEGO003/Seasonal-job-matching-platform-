import { Briefcase, Users, Eye, Clock, ArrowRight, Sparkles } from "lucide-react";
import { Header } from "@/components/Header";
import { StatsCard } from "@/components/StatsCard";
import { JobList } from "@/components/JobList";
import { Button } from "@/components/ui/button";

const Index = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary via-background to-secondary/30">
      <Header />
      
      {/* Hero Section */}
      <section className="relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-r from-primary/5 via-transparent to-primary/5"></div>
        <div className="absolute top-0 right-0 w-96 h-96 bg-gradient-to-bl from-primary/20 to-transparent rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 left-0 w-80 h-80 bg-gradient-to-tr from-primary/20 to-transparent rounded-full blur-3xl"></div>
        
        <div className="relative max-w-7xl mx-auto px-6 py-16">
          <div className="text-center mb-12">
            <div className="inline-flex items-center gap-3 px-6 py-3 rounded-full bg-primary/30 text-secondary-foreground text-base font-semibold mb-8 text-lg">
              <Sparkles className="w-4 h-4" />
              Welcome to HireConnect
            </div>
            <h1 className="text-5xl font-bold text-foreground mb-6 bg-gradient-to-r from-foreground to-primary bg-clip-text text-transparent">
              Find Your Perfect
              <br />
              <span className="text-primary">Seasonal Talent</span>
            </h1>
            <p className="text-xl text-muted-foreground mb-8 max-w-2xl mx-auto">
              Connect with skilled professionals for seasonal positions. Streamline your hiring process and find the right candidates quickly.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button size="lg" className="bg-primary hover:bg-primary/90 text-white px-8 py-3 text-lg">
                Post a Job
                <ArrowRight className="ml-2 w-5 h-5" />
              </Button>
              <Button size="lg" variant="outline" className="border-secondary text-foreground hover:bg-secondary px-8 py-3 text-lg">
                Browse Candidates
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Enhanced Stats Section */}
      <section className="max-w-7xl mx-auto px-6 py-8">
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold text-foreground mb-4">Dashboard Overview</h2>
          
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
          <StatsCard
            title="Total Jobs"
            value="3"
            icon={Briefcase}
            iconBgColor="bg-gradient-to-br from-blue-500 to-blue-600 text-white"
          />
          <StatsCard
            title="Applications"
            value="111"
            icon={Users}
            iconBgColor="bg-gradient-to-br from-primary to-primary/90 text-white"
          />
          <StatsCard
            title="Total Views"
            value="498"
            icon={Eye}
            iconBgColor="bg-gradient-to-br from-green-500 to-green-600 text-white"
          />
          <StatsCard
            title="Active Jobs"
            value="1"
            icon={Clock}
            iconBgColor="bg-gradient-to-br from-purple-500 to-purple-600 text-white"
          />
        </div>

        

        <JobList />
      </section>
    </div>
  );
};

export default Index;
