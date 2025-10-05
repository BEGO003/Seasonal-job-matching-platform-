import { Briefcase, Plus } from "lucide-react";
import { Button } from "@/components/ui/button";

export const Header = () => {
  return (
    <header className="border-b bg-card px-6 py-4">
      <div className="flex items-center justify-between max-w-7xl mx-auto">
        <div className="flex items-center gap-3">
          <div className="flex items-center justify-center w-10 h-10 bg-primary/10 rounded-lg">
            <Briefcase className="w-6 h-6 text-primary" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-foreground">HireConnect</h1>
            <p className="text-sm text-muted-foreground">Employer Dashboard</p>
          </div>
        </div>
        <Button className="gap-2">
          <Plus className="w-4 h-4" />
          New Job Post
        </Button>
      </div>
    </header>
  );
};
