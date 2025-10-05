import { useState } from "react";
import { Search } from "lucide-react";
import { Input } from "@/components/ui/input";
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
  const [searchQuery, setSearchQuery] = useState("");

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-foreground mb-1">Your Job Posts</h2>
        <p className="text-muted-foreground">Manage and track your seasonal job postings</p>
      </div>

      <Tabs defaultValue="all" className="w-full">
        <div className="flex items-center justify-between mb-6">
          <TabsList>
            <TabsTrigger value="all">All Jobs</TabsTrigger>
            <TabsTrigger value="active">Active</TabsTrigger>
            <TabsTrigger value="drafts">Drafts</TabsTrigger>
            <TabsTrigger value="closed">Closed</TabsTrigger>
          </TabsList>
          <div className="relative w-80">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input
              placeholder="Search jobs..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-9"
            />
          </div>
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
