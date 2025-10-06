import { MapPin, DollarSign, Users, Eye, Pencil, Trash2, Calendar, TrendingUp } from "lucide-react";
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
  active: { 
    label: "Active", 
    className: "bg-gradient-to-r from-green-500 to-green-600 text-white",
    bgColor: "bg-gradient-to-r from-green-50 to-green-100/50"
  },
  draft: { 
    label: "Draft", 
    className: "bg-gradient-to-r from-orange-500 to-orange-600 text-white",
    bgColor: "bg-gradient-to-r from-orange-50 to-orange-100/50"
  },
  closed: { 
    label: "Closed", 
    className: "bg-gradient-to-r from-gray-500 to-gray-600 text-white",
    bgColor: "bg-gradient-to-r from-gray-50 to-gray-100/50"
  },
};

export const JobCard = ({ title, location, salary, applications, views, status, season }: JobCardProps) => {
  const statusInfo = statusConfig[status];

  return (
    <Card className={`p-6 hover:shadow-xl transition-all duration-300 hover:scale-[1.02] border-l-4 border-l-orange-500 ${statusInfo.bgColor} group`}>
      <div className="flex items-start justify-between mb-6">
        <div className="flex-1">
          <div className="flex items-center gap-4 mb-4">
            <h3 className="text-xl font-bold text-foreground group-hover:text-orange-600 transition-colors">{title}</h3>
            <Badge className={`${statusInfo.className} shadow-md`}>{statusInfo.label}</Badge>
          </div>
          
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <MapPin className="w-4 h-4 text-orange-500" />
              <span className="text-sm font-medium text-foreground">{location}</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <DollarSign className="w-4 h-4 text-green-500" />
              <span className="text-sm font-medium text-foreground">{salary}</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Users className="w-4 h-4 text-blue-500" />
              <span className="text-sm font-medium text-foreground">{applications} apps</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Eye className="w-4 h-4 text-purple-500" />
              <span className="text-sm font-medium text-foreground">{views} views</span>
            </div>
          </div>
          
          <div className="flex items-center gap-3">
            <Badge variant="outline" className="text-xs border-orange-200 text-orange-700 bg-orange-50">
              <Calendar className="w-3 h-3 mr-1" />
              {season}
            </Badge>
            {applications > 0 && (
              <div className="flex items-center gap-1 text-xs text-orange-600 font-medium">
                <TrendingUp className="w-3 h-3" />
                {Math.round((applications / views) * 100)}% conversion
              </div>
            )}
          </div>
        </div>
        
        <div className="flex items-center gap-1 ml-4">
          <Button size="icon" variant="ghost" className="h-10 w-10 hover:bg-orange-100 hover:text-orange-600 transition-colors">
            <Eye className="w-4 h-4" />
          </Button>
          <Button size="icon" variant="ghost" className="h-10 w-10 hover:bg-blue-100 hover:text-blue-600 transition-colors">
            <Pencil className="w-4 h-4" />
          </Button>
          <Button size="icon" variant="ghost" className="h-10 w-10 hover:bg-red-100 hover:text-red-600 transition-colors">
            <Trash2 className="w-4 h-4" />
          </Button>
        </div>
      </div>
    </Card>
  );
};

