import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { resumeApi } from "@/api";
import type { Resume } from "@/types/resume";
import { ArrowLeft, FileText } from "lucide-react";

export default function ResumeDetails() {
  const { userId } = useParams<{ userId: string }>();
  const navigate = useNavigate();
  const [resume, setResume] = useState<Resume | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchResume = async () => {
      if (!userId) return;
      try {
        setLoading(true);
        const data = await resumeApi.getResumeByUserId(Number(userId));
        setResume(data);
      } catch (e) {
        setError(e instanceof Error ? e.message : "Failed to fetch resume");
      } finally {
        setLoading(false);
      }
    };
    fetchResume();
  }, [userId]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <span className="text-muted-foreground">Loading resume...</span>
      </div>
    );
  }

  if (error || !resume) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Card className="p-6 max-w-xl w-full text-center">
          <p className="text-red-500 mb-4">{error || "Resume not found"}</p>
          <Button variant="ghost" onClick={() => navigate(-1)}>Back</Button>
        </Card>
      </div>
    );
  }

  const Section = ({ title, items }: { title: string; items: string[] }) => (
    <Card className="p-6">
      <div className="flex items-center gap-2 mb-4">
        <FileText className="w-5 h-5 text-primary" />
        <h3 className="text-lg font-semibold">{title}</h3>
      </div>
      <ul className="list-disc ml-6 space-y-2">
        {items.map((item, idx) => (
          <li key={idx} className="text-sm text-foreground">{item}</li>
        ))}
      </ul>
    </Card>
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary/10 to-background">
      <div className="max-w-4xl mx-auto px-6 py-8 space-y-6">
        <div className="flex items-center justify-between">
          <Button variant="ghost" onClick={() => navigate(-1)}>
            <ArrowLeft className="w-4 h-4 mr-2" /> Back
          </Button>
          <h2 className="text-2xl font-bold">Resume Details</h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Section title="Education" items={resume.education} />
          <Section title="Experience" items={resume.experience} />
          <Section title="Certificates" items={resume.certificates} />
          <Section title="Skills" items={resume.skills} />
          <Section title="Languages" items={resume.languages} />
        </div>
      </div>
    </div>
  );
}
