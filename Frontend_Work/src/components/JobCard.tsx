import {
  MapPin,
  DollarSign,
  Users,
  Eye,
  Pencil,
  Trash2,
  Calendar,
  TrendingUp,
} from "lucide-react";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Job } from "@/types/job";
import { useEffect, useState } from "react";
import { applicationApi } from "@/api";
import { useNavigate } from "react-router-dom";
import { formatDateRange } from "@/lib/date";

interface JobCardProps {
  job: Job;
}

const statusConfig = {
  active: {
    label: "Active",
    className: "bg-gradient-to-r from-green-600 to-green-700 text-white",
    bgColor: "bg-gradient-to-r from-green-100 to-green-400/100",
  },
  draft: {
    label: "Draft",
    className: "bg-gradient-to-r from-gray-600 to-gray-700 text-white",
    bgColor: "bg-gradient-to-r from-gray-200 to-gray-400/100",
  },
  closed: {
    label: "Closed",
    className: "bg-gradient-to-r from-red-600 to-red-700 text-white",
    bgColor: "bg-gradient-to-r from-red-100 to-red-400/100",
  },
};

export const JobCard = ({ job }: JobCardProps) => {
  const navigate = useNavigate();
  const [applicantCount, setApplicantCount] = useState<number>(0);
  const {
    id,
    title,
    location,
    amount,
    salary,
    views,
    status,
    startDate,
    duration,
    positions,
  } = job;
  const statusInfo = statusConfig[status];

  useEffect(() => {
    let isMounted = true;
    const loadApps = async () => {
      try {
        const apps = await applicationApi.getApplicationsByJobId(id);
        if (isMounted) setApplicantCount(apps.length);
      } catch (e) {
        // keep silent, fallback to 0
        if (isMounted) setApplicantCount(0);
      }
    };
    loadApps();
    return () => {
      isMounted = false;
    };
  }, [id]);

  const formatSalaryType = (salaryType: string) => {
    const typeMap: Record<string, string> = {
      YEARLY: "Yearly",
      MONTHLY: "Monthly",
      HOURLY: "Hourly",
    };
    return typeMap[salaryType] || salaryType;
  };

  const formatSalary = () => {
    if (typeof amount === "number" && !Number.isNaN(amount)) {
      return `$${amount.toFixed(2)}/${formatSalaryType(salary)}`;
    }
    return "Salary not specified";
  };

  const formatDurationInfo = () => {
    if (duration) {
      return `${duration} Days`;
    }
    return "Duration not specified";
  };

  return (
    <Card
      className={`p-6 hover:shadow-xl transition-all duration-300 hover:scale-[1.02] border-l-4 border-l-primary ${statusInfo.bgColor} group`}
    >
      <div className="flex items-start justify-between mb-6">
        <div className="flex-1">
          <div className="flex items-center gap-4 mb-4">
            <h3 className="text-xl font-bold text-foreground group-hover:text-primary transition-colors">
              {title}
            </h3>
            <Badge className={`${statusInfo.className} shadow-md`}>
              {statusInfo.label}
            </Badge>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <MapPin className="w-4 h-4 text-primary" />
              <span className="text-sm font-medium text-foreground">
                {location}
              </span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <DollarSign className="w-4 h-4 text-green-500" />
              <span className="text-sm font-medium text-foreground">
                {formatSalary()}
              </span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Users className="w-4 h-4 text-blue-500" />
              <span className="text-sm font-medium text-foreground">
                {applicantCount} apps
              </span>
            </div>

            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Users className="w-4 h-4 text-orange-500" />
              <span className="text-sm font-medium text-foreground">
                {positions} positions
              </span>
            </div>
          </div>

          <div className="flex items-center gap-3">
            <Badge
              variant="outline"
              className="text-xs border-secondary text-foreground bg-secondary"
            >
              <Calendar className="w-3 h-3 mr-1" />
              {startDate} / {formatDurationInfo()}
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
            <img
              src={"https://cdn-icons-png.flaticon.com/256/570/570170.png"}
              className="w-5 h-5 object-contain"
            />
          </Button>
          <Button
            size="icon"
            variant="ghost"
            onClick={() => navigate(`/applications/job/${id}`)}
            className="h-10 w-10 hover:bg-blue-100 hover:text-blue-600 transition-colors"
          >
            <img
              src={
                "https://www.pngkey.com/png/full/394-3948444_logo-people-png.png"
              }
              className="w-10 h-10 object-contain"
            />
          </Button>
        </div>
      </div>
    </Card>
  );
};
