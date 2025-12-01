import { LucideIcon } from "lucide-react";
import { Card } from "@/components/ui/card";

interface StatsCardProps {
  title: string;
  value: string | number;
  icon: LucideIcon;
  iconBgColor: string;
}

export const StatsCard = ({ title, value, icon: Icon, iconBgColor }: StatsCardProps) => {
  return (
    <Card className="p-6 hover:shadow-lg transition-all duration-300 hover:scale-105 border-l-4 border-l-primary/30 bg-gradient-to-br from-white to-secondary/30">
      <div className="flex items-center justify-between mb-4">
        <div className={`flex items-center justify-center w-14 h-14 rounded-2xl ${iconBgColor} shadow-lg`}>
          <Icon className="w-7 h-7" />
        </div>
      </div>
      <div>
        <p className="text-sm text-muted-foreground mb-2">{title}</p>
        <p className="text-4xl font-bold text-foreground mb-1">{value}</p>
      </div>
    </Card>
  );
};
