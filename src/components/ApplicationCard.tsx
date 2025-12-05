import {
  Mail,
  MapPin,
  Phone,
  Calendar,
  CheckCircle,
  XCircle,
  Clock,
  Briefcase,
} from "lucide-react";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Application, ApplicationStatus } from "@/types/application";
import { applicationApi } from "@/api";
import { useNavigate } from "react-router-dom";

interface ApplicationCardProps {
  application: Application;
  onStatusChange?: (appId: number, newStatus: ApplicationStatus) => void;
  onDelete?: (appId: number) => void;
}

const statusConfig = {
  PENDING: {
    label: "Pending",
    className: "bg-gradient-to-r from-yellow-600 to-yellow-700 text-white",
    bgColor: "bg-gradient-to-r from-yellow-100 to-yellow-400/100",
    icon: Clock,
  },
  ACCEPTED: {
    label: "Accepted",
    className: "bg-gradient-to-r from-green-600 to-green-700 text-white",
    bgColor: "bg-gradient-to-r from-green-100 to-green-400/100",
    icon: CheckCircle,
  },
  REJECTED: {
    label: "Rejected",
    className: "bg-gradient-to-r from-red-600 to-red-700 text-white",
    bgColor: "bg-gradient-to-r from-red-100 to-red-400/100",
    icon: XCircle,
  },
  INTERVIEW_SCHEDULED: {
    label: "Interview Scheduled",
    className: "bg-gradient-to-r from-blue-600 to-blue-700 text-white",
    bgColor: "bg-gradient-to-r from-blue-100 to-blue-400/100",
    icon: Briefcase,
  },
};

export const ApplicationCard = ({
  application,
  onStatusChange,
  onDelete,
}: ApplicationCardProps) => {
  const navigate = useNavigate();
  const statusInfo = statusConfig[application.applicationStatus];
  const StatusIcon = statusInfo.icon;

  const handleStatusChange = async (newStatus: ApplicationStatus) => {
    try {
      await applicationApi.updateApplicationStatus(application.id, newStatus);
      onStatusChange?.(application.id, newStatus);
    } catch (err) {
      console.error("Failed to update application status:", err);
    }
  };

  const handleDelete = async () => {
    if (confirm("Are you sure you want to delete this application?")) {
      try {
        await applicationApi.deleteApplication(application.id);
        onDelete?.(application.id);
      } catch (err) {
        console.error("Failed to delete application:", err);
      }
    }
  };

  return (
    <Card
      className={`p-6 hover:shadow-xl transition-all duration-300 border-l-4 border-l-yellow-500 ${statusInfo.bgColor} group`}
    >
      <div className="flex items-start justify-between mb-4">
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-3">
            <h3 className="text-lg font-bold text-foreground">
              {application.user.name}
            </h3>
            <Badge className={statusInfo.className}>
              <StatusIcon className="w-3 h-3 mr-1" />
              {statusInfo.label}
            </Badge>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-3 mb-4">
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Mail className="w-4 h-4 text-primary" />
              <span className="text-sm text-foreground break-all">
                {application.user.email}
              </span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <Phone className="w-4 h-4 text-primary" />
              <span className="text-sm font-medium text-foreground">
                {application.user.number}
              </span>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white/60 rounded-lg">
              <MapPin className="w-4 h-4 text-primary" />
              <span className="text-sm font-medium text-foreground">
                {application.user.country}
              </span>
            </div>
          </div>

          <div className="mb-4 p-4 bg-white/70 rounded-lg border border-border">
            <h4 className="text-sm font-semibold text-foreground mb-2">
              About the Applicant
            </h4>
            <p className="text-sm text-muted-foreground whitespace-pre-wrap leading-relaxed">
              {application.describeYourself}
            </p>
          </div>

          <div className="flex items-center gap-2 text-xs text-muted-foreground">
            <Calendar className="w-3 h-3" />
            <span>Applied on {application.createdAt}</span>
          </div>
        </div>
      </div>

      <div className="flex flex-wrap gap-2 pt-4 border-t">
        <Button
          size="sm"
          variant="outline"
          className="border-primary text-primary hover:bg-primary/10"
          onClick={() => navigate(`/resumes/${application.user.id}`)}
        >
          <Briefcase className="w-4 h-4 mr-1" /> View Resume
        </Button>
        {application.applicationStatus !== "ACCEPTED" && (
          <Button
            size="sm"
            variant="outline"
            className="border-green-600 text-green-600 hover:bg-green-50"
            onClick={() => handleStatusChange("ACCEPTED")}
          >
            <CheckCircle className="w-4 h-4 mr-1" />
            Accept
          </Button>
        )}
        {application.applicationStatus !== "INTERVIEW_SCHEDULED" && (
          <Button
            size="sm"
            variant="outline"
            className="border-blue-600 text-blue-600 hover:bg-blue-50"
            onClick={() => handleStatusChange("INTERVIEW_SCHEDULED")}
          >
            <Briefcase className="w-4 h-4 mr-1" />
            Schedule Interview
          </Button>
        )}
        {application.applicationStatus !== "REJECTED" && (
          <Button
            size="sm"
            variant="outline"
            className="border-red-600 text-red-600 hover:bg-red-50"
            onClick={() => handleStatusChange("REJECTED")}
          >
            <XCircle className="w-4 h-4 mr-1" />
            Reject
          </Button>
        )}
        {application.applicationStatus !== "PENDING" && (
          <Button
            size="sm"
            variant="outline"
            className="border-yellow-600 text-yellow-600 hover:bg-yellow-50"
            onClick={() => handleStatusChange("PENDING")}
          >
            <Clock className="w-4 h-4 mr-1" />
            Mark Pending
          </Button>
        )}
        <Button
          size="sm"
          variant="destructive"
          className="ml-auto"
          onClick={handleDelete}
        >
          Delete
        </Button>
      </div>
    </Card>
  );
};
