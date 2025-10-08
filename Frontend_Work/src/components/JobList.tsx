import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { JobCard } from "./JobCard";

const mockJobs = [
  {
    id: 1,
    title: "Summer Camp Counselor",
    location: "Denver, CO",
    salary: "$15-18/hour",
    applications: 24,
    views: 156,
    status: "active" as const,
    season: "Summer Seasonal",
  },
  {
    id: 2,
    title: "Holiday Retail Associate",
    location: "Boulder, CO",
    salary: "$16-20/hour",
    applications: 0,
    views: 0,
    status: "draft" as const,
    season: "Holiday Seasonal",
  },
  {
    id: 3,
    title: "Ski Instructor",
    location: "Aspen, CO",
    salary: "$25-35/hour",
    applications: 87,
    views: 342,
    status: "closed" as const,
    season: "Winter Seasonal",
  },
];

export const JobList = () => {
  return (
    <div className="space-y-8">
      <div className="text-center">
        <h2 className="text-4xl font-bold text-foreground mb-4 bg-gradient-to-r from-foreground to-primary bg-clip-text text-transparent">
        Job Posts
        </h2>
        
      </div>

      <Tabs defaultValue="all" className="w-full">
        <div className="flex items-center justify-center mb-8">
          <TabsList className="grid w-full max-w-xl grid-cols-4 bg-gradient-to-r from-secondary to-secondary/70 p-1 rounded-xl">
            <TabsTrigger value="all" className="data-[state=active]:bg-primary data-[state=active]:text-white rounded-lg">
              All Jobs
            </TabsTrigger>
            <TabsTrigger value="active" className="data-[state=active]:bg-primary data-[state=active]:text-white rounded-lg">
              Active
            </TabsTrigger>
            <TabsTrigger value="drafts" className="data-[state=active]:bg-primary data-[state=active]:text-white rounded-lg">
              Drafts
            </TabsTrigger>
            <TabsTrigger value="closed" className="data-[state=active]:bg-primary data-[state=active]:text-white rounded-lg">
              Closed
            </TabsTrigger>
          </TabsList>
        </div>

        <TabsContent value="all" className="space-y-4">
          {mockJobs.map((job) => (
            <JobCard key={job.id} {...job} />
          ))}
        </TabsContent>

        <TabsContent value="active" className="space-y-4">
          {mockJobs
            .filter((job) => job.status === "active")
            .map((job) => (
              <JobCard key={job.id} {...job} />
            ))}
        </TabsContent>

        <TabsContent value="drafts" className="space-y-4">
          {mockJobs
            .filter((job) => job.status === "draft")
            .map((job) => (
              <JobCard key={job.id} {...job} />
            ))}
        </TabsContent>

        <TabsContent value="closed" className="space-y-4">
          {mockJobs
            .filter((job) => job.status === "closed")
            .map((job) => (
              <JobCard key={job.id} {...job} />
            ))}
        </TabsContent>
      </Tabs>
    </div>
  );
};
