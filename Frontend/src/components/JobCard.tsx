import { MapPin, DollarSign, Users, Eye, Pencil, Trash2 } from "lucide-react";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

interface JobCardProps {
  title: string;
  location: string;
  salary: string;
  applications: number;
  views: number;
  status: "active" | "draft" | "closed";
  season: string;
}

const statusConfig = {
  active: { label: "Active", className: "bg-success text-success-foreground" },
  draft: { label: "Draft", className: "bg-muted text-muted-foreground" },
  closed: { label: "Closed", className: "bg-destructive text-destructive-foreground" },
};

export const JobCard = ({ title, location, salary, applications, views, status, season }: JobCardProps) => {
  const statusInfo = statusConfig[status];

  return (
    <Card className="p-6 hover:shadow-md transition-shadow border-l-4 border-l-primary">
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-3">
            <h3 className="text-lg font-semibold text-foreground">{title}</h3>
            <Badge className={statusInfo.className}>{statusInfo.label}</Badge>
          </div>
          <div className="flex flex-wrap items-center gap-4 text-sm text-muted-foreground mb-3">
            <div className="flex items-center gap-1">
              <MapPin className="w-4 h-4" />
              <span>{location}</span>
            </div>
            <div className="flex items-center gap-1">
              <DollarSign className="w-4 h-4" />
              <span>{salary}</span>
            </div>
            <div className="flex items-center gap-1">
              <Users className="w-4 h-4" />
              <span>{applications} applications</span>
            </div>
            <div className="flex items-center gap-1">
              <Eye className="w-4 h-4" />
              <span>{views} views</span>
            </div>
          </div>
          <Badge variant="outline" className="text-xs">{season}</Badge>
        </div>
        <div className="flex items-center gap-2">
          <Button size="icon" variant="ghost" className="h-8 w-8">
            <Eye className="w-4 h-4" />
          </Button>
          <Button size="icon" variant="ghost" className="h-8 w-8">
            <Pencil className="w-4 h-4" />
          </Button>
          <Button size="icon" variant="ghost" className="h-8 w-8 text-destructive hover:text-destructive">
            <Trash2 className="w-4 h-4" />
          </Button>
        </div>
      </div>
    </Card>
  );
};
