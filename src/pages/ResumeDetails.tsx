import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Header } from "@/components/Header";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import {
  ArrowLeft,
  Mail,
  MapPin,
  Phone,
  GraduationCap,
  Briefcase,
  Award,
  Code,
  Languages,
  User as UserIcon,
} from "lucide-react";
import { resumeApi } from "@/api";
import { Resume } from "@/types/resume";
import { User } from "@/types/user";
import { useToast } from "@/components/ui/use-toast";

const ResumeDetails = () => {
  const { userId } = useParams<{ userId: string }>();
  const navigate = useNavigate();
  const { toast } = useToast();

  const [resume, setResume] = useState<Resume | null>(null);
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      if (!userId) return;

      try {
        setLoading(true);
        const id = parseInt(userId);

        // Parallel fetch for user details and resume
        const [resumeData, userResponse] = await Promise.allSettled([
          resumeApi.getResumeByUserId(id),
          fetch(`/api/users/${id}`).then((res) => {
            if (!res.ok) throw new Error("Failed to fetch user");
            return res.json();
          }),
        ]);

        // Handle Resume Data
        if (resumeData.status === "fulfilled") {
          // resumeApi might return { data: Resume } or Resume directly
          const r = (resumeData.value as any)?.data || resumeData.value;
          setResume(r);
        } else {
          // Resume might not exist, which is fine — show empty state
          console.log("No resume found or error fetching resume", resumeData.reason);
        }

        // Handle User Data
        if (userResponse.status === "fulfilled") {
          // API might return { data: User } or just User
          const userData = (userResponse.value as any)?.data || userResponse.value;
          setUser(userData);
        } else {
          setError("Failed to load user information.");
          toast({
            variant: "destructive",
            title: "Error",
            description: "Could not fetch user details.",
          });
        }
      } catch (err) {
        console.error(err);
        setError("An unexpected error occurred.");
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [userId, toast]);

  if (loading) {
    return (
      <div className="min-h-screen bg-slate-100">
        <Header />
        <main className="container mx-auto px-4 py-8">
          <div className="space-y-6">
            <Skeleton className="h-12 w-32" />
            <div className="grid gap-6 md:grid-cols-3">
              <Skeleton className="h-64 md:col-span-1" />
              <Skeleton className="h-96 md:col-span-2" />
            </div>
          </div>
        </main>
      </div>
    );
  }
if (error || !user) {
    return (
      <div className="min-h-screen bg-slate-100">
        {/* <Header /> */}
        <main className="container mx-auto px-4 py-8 flex flex-col items-center justify-center min-h-[60vh]">
          <h2 className="text-2xl font-bold mb-4 text-slate-900">User Not Found</h2>
          <p className="text-slate-600 mb-6">The user profile you are looking for does not exist or could not be loaded.</p>
          <Button onClick={() => navigate(-1)}>
            <ArrowLeft className="mr-2 h-4 w-4" /> Go Back
          </Button>
        </main>
      </div>
    );
  }
  return (
    <div className="min-h-screen bg-slate-100">
      <Header />

      <main className="container mx-auto px-4 py-8 max-w-6xl">
        <Button
          variant="ghost"
          className="mb-6 hover:bg-slate-200 text-slate-800 bg-primary text-white"
          onClick={() => navigate(-1)}
          aria-label="Back to application"
        >
          <ArrowLeft className="mr-2 h-4 w-4" /> Back to Application
        </Button>

        <div className="grid gap-6 md:grid-cols-12">
          {/* Left Column: User Profile Card */}
          <div className="md:col-span-4 lg:col-span-3">
            <Card className="sticky top-6 border-none shadow-md">
              <CardHeader className="flex flex-col items-center text-center pb-2">
                
                <CardTitle className="text-xl font-bold text-slate-900 truncate">{user.name}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4 pt-4">
                {user.email && (
                  <div className="flex items-center text-sm text-slate-700">
                    <Mail className="mr-3 h-4 w-4 text-sky-600" />
                    <span className="truncate" title={user.email}>
                      {user.email}
                    </span>
                  </div>
                )}
                {user.number && (
                  <div className="flex items-center text-sm text-slate-700">
                    <Phone className="mr-3 h-4 w-4 text-sky-600" />
                    <span>{user.number}</span>
                  </div>
                )}
                {user.country && (
                  <div className="flex items-center text-sm text-slate-700">
                    <MapPin className="mr-3 h-4 w-4 text-sky-600" />
                    <span>{user.country}</span>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Right Column: Resume Details */}
          <div className="md:col-span-8 lg:col-span-9 space-y-6">
            {!resume ? (
              <Card className="border-dashed border-2 shadow-none bg-transparent">
                <CardContent className="flex flex-col items-center justify-center py-12 text-center text-slate-600">
                  <Briefcase className="h-12 w-12 mb-4 opacity-30 text-slate-500" />
                  <h3 className="text-lg font-medium text-slate-900">No Resume Information</h3>
                  <p className="mt-2">This user has not listed any resume details yet.</p>
                </CardContent>
              </Card>
            ) : (
              <>
                {/* Education Section */}
                <Card className="border-none shadow-sm">
                  <CardHeader className="pb-3 border-b border-slate-200">
                    <div className="flex items-center gap-2">
                      <div className="p-2 bg-blue-100 rounded-lg text-blue-700">
                        <GraduationCap className="h-5 w-5" />
                      </div>
                      <CardTitle className="text-lg font-semibold text-slate-900">Education</CardTitle>
                    </div>
                  </CardHeader>
                  <CardContent className="pt-6">
                    {resume.education && resume.education.length > 0 ? (
                      <ul className="space-y-4">
                        {resume.education.map((edu, index) => (
                          <li key={index} className="flex gap-4">
                            <div className="mt-1.5 h-2 w-2 rounded-full bg-blue-500 shrink-0" />
                            <p className="text-slate-700 leading-relaxed">{edu}</p>
                          </li>
                        ))}
                      </ul>
                    ) : (
                      <p className="text-slate-600 italic">No education provided.</p>
                    )}
                  </CardContent>
                </Card>

                {/* Experience Section */}
                <Card className="border-none shadow-sm">
                  <CardHeader className="pb-3 border-b border-slate-200">
                    <div className="flex items-center gap-2">
                      <div className="p-2 bg-purple-100 rounded-lg text-purple-700">
                        <Briefcase className="h-5 w-5" />
                      </div>
                      <CardTitle className="text-lg font-semibold text-slate-900">Experience</CardTitle>
                    </div>
                  </CardHeader>
                  <CardContent className="pt-6">
                    {resume.experience && resume.experience.length > 0 ? (
                      <ul className="space-y-4">
                        {resume.experience.map((exp, index) => (
                          <li key={index} className="flex gap-4">
                            <div className="mt-1.5 h-2 w-2 rounded-full bg-purple-500 shrink-0" />
                            <p className="text-slate-700 leading-relaxed">{exp}</p>
                          </li>
                        ))}
                      </ul>
                    ) : (
                      <p className="text-slate-600 italic">No experience provided.</p>
                    )}
                  </CardContent>
                </Card>

                {/* Skills Section */}
                <Card className="border-none shadow-sm">
                  <CardHeader className="pb-3 border-b border-slate-200">
                    <div className="flex items-center gap-2">
                      <div className="p-2 bg-indigo-100 rounded-lg text-indigo-700">
                        <Code className="h-5 w-5" />
                      </div>
                      <CardTitle className="text-lg font-semibold text-slate-900">Skills</CardTitle>
                    </div>
                  </CardHeader>
                  <CardContent className="pt-6">
                    {resume.skills && resume.skills.length > 0 ? (
                      <div className="flex flex-wrap gap-2">
                        {resume.skills.map((skill, index) => (
                          <span
                            key={index}
                            className="px-3 py-1 bg-indigo-100 text-indigo-800 rounded-full text-sm font-medium border border-indigo-200"
                          >
                            {skill}
                          </span>
                        ))}
                      </div>
                    ) : (
                      <p className="text-slate-600 italic">No skills provided.</p>
                    )}
                  </CardContent>
                </Card>

                <div className="grid md:grid-cols-2 gap-6">
                  {/* Certificates Section */}
                  <Card className="border-none shadow-sm h-full">
                    <CardHeader className="pb-3 border-b border-slate-200">
                      <div className="flex items-center gap-2">
                        <div className="p-2 bg-amber-100 rounded-lg text-amber-700">
                          <Award className="h-5 w-5" />
                        </div>
                        <CardTitle className="text-lg font-semibold text-slate-900">Certificates</CardTitle>
                      </div>
                    </CardHeader>
                    <CardContent className="pt-6">
                      {resume.certificates && resume.certificates.length > 0 ? (
                        <ul className="space-y-3">
                          {resume.certificates.map((cert, index) => (
                            <li key={index} className="flex gap-3">
                              <div className="mt-1.5 h-2 w-2 rounded-full bg-amber-500 shrink-0" />
                              <span className="text-slate-700">{cert}</span>
                            </li>
                          ))}
                        </ul>
                      ) : (
                        <p className="text-slate-600 italic">No certificates provided.</p>
                      )}
                    </CardContent>
                  </Card>

                  {/* Languages Section */}
                  <Card className="border-none shadow-sm h-full">
                    <CardHeader className="pb-3 border-b border-slate-200">
                      <div className="flex items-center gap-2">
                        <div className="p-2 bg-emerald-100 rounded-lg text-emerald-700">
                          <Languages className="h-5 w-5" />
                        </div>
                        <CardTitle className="text-lg font-semibold text-slate-900">Languages</CardTitle>
                      </div>
                    </CardHeader>
                    <CardContent className="pt-6">
                      {resume.languages && resume.languages.length > 0 ? (
                        <div className="flex flex-wrap gap-2">
                          {resume.languages.map((lang, index) => (
                            <span
                              key={index}
                              className="px-3 py-1 bg-emerald-100 text-emerald-800 rounded-md text-sm border border-emerald-200"
                            >
                              {lang}
                            </span>
                          ))}
                        </div>
                      ) : (
                        <p className="text-slate-600 italic">No languages provided.</p>
                      )}
                    </CardContent>
                  </Card>
                </div>
              </>
            )}
          </div>
        </div>
      </main>
    </div>
  );
};

export default ResumeDetails;
