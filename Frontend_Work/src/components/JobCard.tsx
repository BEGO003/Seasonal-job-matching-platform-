import { MapPin, DollarSign, Users, Eye, Pencil, Trash2, Calendar, TrendingUp } from "lucide-react";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Job } from "@/types/job";
import { useNavigate } from "react-router-dom";

interface JobCardProps {
  job: Job;
}

const statusConfig = {
  active: { 
    label: "Active", 
    className: "bg-gradient-to-r from-green-600 to-green-700 text-white",
    bgColor: "bg-gradient-to-r from-green-100 to-green-200/100"
  },
  draft: { 
    label: "Draft", 
    className: "bg-gradient-to-r from-primary to-primary/90 text-white",
    bgColor: "bg-gradient-to-r from-secondary to-secondary/70"
  },
  closed: { 
    label: "Closed", 
    className: "bg-gradient-to-r from-gray-500 to-gray-600 text-white",
    bgColor: "bg-gradient-to-r from-gray-50 to-gray-100/50"
  },
};

export const JobCard = ({ job }: JobCardProps) => {
  const navigate = useNavigate();
  const { id, title, location, salary, applications, views, status, startDate, endDate, positions } = job;
  const statusInfo = statusConfig[status];
  
  const formatSalary = () => {
    if (typeof salary === 'number' && !Number.isNaN(salary)) {
      return `$${salary.toFixed(2)}`;
    }
    return 'Salary not specified';
  };

  const formatDateRange = () => {
    const start = new Date(startDate).toLocaleDateString();
    const end = new Date(endDate).toLocaleDateString();
    return `${start} - ${end}`;
  };

  return (
    <Card className={`p-6 hover:shadow-xl transition-all duration-300 hover:scale-[1.02] border-l-4 border-l-primary ${statusInfo.bgColor} group`}>
      <div className="flex items-start justify-between mb-6">
        <div className="flex-1">
          <div className="flex items-center gap-4 mb-4">
            <h3 className="text-xl font-bold text-foreground group-hover:text-primary transition-colors">{title}</h3>
            <Badge className={`${statusInfo.className} shadow-md`}>{statusInfo.label}</Badge>
          </div>
          
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <MapPin className="w-4 h-4 text-primary" />
              <span className="text-sm font-medium text-foreground">{location}</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <DollarSign className="w-4 h-4 text-green-500" />
              <span className="text-sm font-medium text-foreground">{formatSalary()}</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Users className="w-4 h-4 text-blue-500" />
              <span className="text-sm font-medium text-foreground">{applications} apps</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Eye className="w-4 h-4 text-purple-500" />
              <span className="text-sm font-medium text-foreground">{views} views</span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Users className="w-4 h-4 text-orange-500" />
              <span className="text-sm font-medium text-foreground">{positions} positions</span>
            </div>
          </div>
          
          <div className="flex items-center gap-3">
            <Badge variant="outline" className="text-xs border-secondary text-foreground bg-secondary">
              <Calendar className="w-3 h-3 mr-1" />
              {formatDateRange()}
            </Badge>
            
          </div>
        </div>
        
        <div className="flex items-center gap-1 ml-4">
          <Button 
            size="icon" 
            variant="ghost" 
            onClick={() => navigate(`/job/${id}`)}
            className="h-10 w-10 hover:bg-secondary hover:text-primary transition-colors"
          >
            <Eye className="w-4 h-4" />
          </Button>
          <Button 
            size="icon" 
            variant="ghost" 
            onClick={() => navigate(`/edit-job/${id}`)}
            className="h-10 w-10 hover:bg-blue-100 hover:text-blue-600 transition-colors"
          >
            <Pencil className="w-4 h-4" />
          </Button>
          <Button 
            size="icon" 
            variant="ghost" 
            onClick={() => {/* TODO: Add delete functionality */}}
            className="h-10 w-10 hover:bg-red-100 hover:text-red-600 transition-colors"
          >
            <Trash2 className="w-4 h-4" />
          </Button>
        </div>
      </div>
    </Card>
  );
};

