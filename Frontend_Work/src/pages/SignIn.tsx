import { useState, useEffect } from "react";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";
import { Link, useNavigate } from "react-router-dom";
import { authApi } from "@/api";
import { useToast } from "@/hooks/use-toast";

const slogans = [
  "Let's kick off another great hiring season!",
  "Back for another round? Let's fill those roles fast.",
  "The season's moving, start posting today!",
  "Don't wait, your next hire is only a post away.",
  "Hire smarter this season, welcome back!",
];

export default function SignInPage() {
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });
  const [errors, setErrors] = useState<{ email?: string; password?: string }>(
    {}
  );
  const [randomSlogan, setRandomSlogan] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const { toast } = useToast();

  useEffect(() => {
    // Pick a random slogan on component mount
    const randomIndex = Math.floor(Math.random() * slogans.length);
    setRandomSlogan(slogans[randomIndex]);

    // Check if user is already logged in
    if (authApi.isAuthenticated()) {
      navigate("/dashboard");
    }
  }, [navigate]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
    // live-validate basic rules
    if (name === "email") {
      const email = value.trim();
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      setErrors((prev) => ({
        ...prev,
        email:
          email.length === 0
            ? "Email is required"
            : !emailRegex.test(email)
            ? "Enter a valid email"
            : undefined,
      }));
    }
    if (name === "password") {
      const pwd = value;
      setErrors((prev) => ({
        ...prev,
        password: pwd.trim().length === 0 ? "Password is required" : undefined,
      }));
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      // Trim inputs and validate before hitting API
      const email = formData.email.trim();
      const password = formData.password;
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

      if (!email) {
        setErrors((prev) => ({ ...prev, email: "Email is required" }));
        toast({
          title: "Validation error",
          description: "Email is required",
          variant: "destructive",
        });
        return;
      }
      if (!emailRegex.test(email)) {
        setErrors((prev) => ({ ...prev, email: "Enter a valid email" }));
        toast({
          title: "Validation error",
          description: "Enter a valid email",
          variant: "destructive",
        });
        return;
      }
      if (!password.trim()) {
        setErrors((prev) => ({ ...prev, password: "Password is required" }));
        toast({
          title: "Validation error",
          description: "Password is required",
          variant: "destructive",
        });
        return;
      }

      const response = await authApi.login({ email, password });

      toast({
        title: "Success",
        description: response.message,
      });

      navigate("/dashboard");
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Invalid email or password",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const canSubmit =
    !!formData.email.trim() &&
    !!formData.password.trim() &&
    /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email.trim());

  return (
    <div
      className="min-h-screen flex items-center justify-center py-8 px-4 relative"
      style={{
        backgroundImage:
          "url(https://e0.pxfuel.com/wallpapers/801/82/desktop-wallpaper-purple-white-gradient-linear-dark-violet-9400d3-ffffff-120a%C2%B0.jpg)",
        backgroundSize: "cover",
        backgroundPosition: "center",
        backgroundRepeat: "no-repeat",
      }}
    >
      <div className="absolute inset-0 bg-background/80 backdrop-blur-sm"></div>
      <div className="relative z-10 bg-card rounded-3xl shadow-2xl overflow-hidden w-[1000px] max-w-full flex flex-col md:flex-row">
        {/* Left Section with Slogans */}
        <motion.div
          initial={{ opacity: 0, x: -50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.6 }}
          className="w-full md:w-1/2 p-8 md:p-10 flex flex-col justify-center items-start bg-gradient-to-b from-primary to-primary/80 text-primary-foreground rounded-l-3xl"
        >
          <h1 className="text-3xl md:text-4xl font-bold mb-6">Welcome back!</h1>
          {randomSlogan && (
            <p className="text-xl md:text-2xl opacity-90 leading-relaxed">
              {randomSlogan}
            </p>
          )}
        </motion.div>

        {/* Right Section - Form */}
        <motion.div
          initial={{ opacity: 0, x: 50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.6 }}
          className="w-full md:w-1/2 bg-card p-8 md:p-10 flex flex-col justify-center md:rounded-r-3xl rounded-b-3xl md:rounded-bl-none"
        >
          <div className="flex items-center gap-3 mb-6">
            <img
              src="https://www.somebodydigital.com/wp-content/uploads/2024/08/B2B-Email-Marketing-2.png"
              alt="HireConnect Logo"
              className="w-12 h-12 object-contain"
            />
            <h2 className="text-2xl font-bold text-card-foreground">
              HireConnect
            </h2>
          </div>
          <h3 className="text-xl md:text-2xl font-semibold mb-2 text-card-foreground">
            Sign in to your account
          </h3>
          <p className="text-sm mb-4 md:mb-6 text-muted-foreground">
            Don't have an account?{" "}
            <Link to="/signup" className="text-primary hover:underline">
              Sign up
            </Link>
          </p>

          <form onSubmit={handleSubmit} noValidate>
            <div className="mb-3">
              <Label htmlFor="email">Email</Label>
              <Input
                id="email"
                name="email"
                type="email"
                placeholder="example@email.com"
                value={formData.email}
                onChange={handleChange}
                required
                aria-invalid={!!errors.email}
                aria-describedby={errors.email ? "email-error" : undefined}
              />
              {errors.email && (
                <p id="email-error" className="mt-1 text-xs text-red-500">
                  {errors.email}
                </p>
              )}
            </div>

            <div className="mb-4">
              <Label htmlFor="password">Password</Label>
              <Input
                id="password"
                type="password"
                name="password"
                placeholder="Enter your password"
                value={formData.password}
                onChange={handleChange}
                required
                aria-invalid={!!errors.password}
                aria-describedby={
                  errors.password ? "password-error" : undefined
                }
              />
              {errors.password && (
                <p id="password-error" className="mt-1 text-xs text-red-500">
                  {errors.password}
                </p>
              )}
            </div>

            {/* <div className="flex items-center justify-between mb-6">
              <div className="flex items-center space-x-2">
                <input type="checkbox" id="remember" className="w-4 h-4" />
                <Label
                  htmlFor="remember"
                  className="text-sm text-muted-foreground"
                >
                  Remember me
                </Label>
              </div>
              <Link to="#" className="text-sm text-primary hover:underline">
                Forgot password?
              </Link>
            </div> */}

            <Button
              type="submit"
              disabled={loading || !canSubmit}
              className="w-full bg-primary hover:bg-primary/90 text-primary-foreground font-semibold py-2 disabled:opacity-60"
            >
              {loading ? "Signing in..." : "Sign in"}
            </Button>
          </form>
        </motion.div>
      </div>
    </div>
  );
}
