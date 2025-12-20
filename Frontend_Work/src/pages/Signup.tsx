import { useState, useEffect } from "react";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import { motion } from "framer-motion";
import { Link, useNavigate } from "react-router-dom";
import { authApi } from "@/api";
import {
  Select,
  SelectTrigger,
  SelectContent,
  SelectItem,
  SelectValue,
} from "@/components/ui/select";
import { countryCodes } from "@/data/countryCodes";

const slogans = [
  "New here? Let's get you set up to start hiring.",
  "Create your account, it only takes a minute to start finding talent.",
  "Welcome! Ready to find your first seasonal hires?",
  "We're excited to have you, let's fill those roles together.",
  "Join our community of employers and make this season a success.",
];

export default function SignupPage() {
  const navigate = useNavigate();
  const [submitting, setSubmitting] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    number: "",
    country: "",
    password: "",
    confirmPassword: "",
  });
  const [phoneIso, setPhoneIso] = useState("");
  const [randomSlogan, setRandomSlogan] = useState("");

  useEffect(() => {
    // Pick a random slogan on component mount
    const randomIndex = Math.floor(Math.random() * slogans.length);
    setRandomSlogan(slogans[randomIndex]);
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.name.trim()) {
      alert("Please enter your full name.");
      return;
    }
    if (!formData.email.trim()) {
      alert("Please enter your email.");
      return;
    }
    if (!formData.number.trim()) {
      alert("Please enter your number.");
      return;
    }
    if (!formData.country.trim()) {
      alert("Please enter your country.");
      return;
    }
    if (!formData.password.trim()) {
      alert("Please enter your password.");
      return;
    }
    if (!formData.confirmPassword.trim()) {
      alert("Please confirm your password.");
      return;
    }
    if (formData.password !== formData.confirmPassword) {
      alert("Passwords do not match.");
      return;
    }
    try {
      setSubmitting(true);
      await authApi.signup({
        name: formData.name.trim(),
        email: formData.email.trim(),
        password: formData.password,
        country: formData.country.trim(),
        number: `${
          countryCodes.find((c) => c.country === phoneIso)?.code || ""
        }${formData.number.trim()}`,
      });
      navigate(-1);
    } catch (err: any) {
      alert(err?.message || "Signup failed");
    } finally {
      setSubmitting(false);
    }
  };

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
          <h1 className="text-3xl md:text-4xl font-bold mb-6">Get Started</h1>
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
            Create an account
          </h3>
          <p className="text-sm mb-4 md:mb-6 text-muted-foreground">
            Already have an account?{" "}
            <Link to="/profile" className="text-primary hover:underline">
              Login
            </Link>
          </p>

          <form onSubmit={handleSubmit}>
            <div className="mb-3">
              <Label htmlFor="name">Full Name</Label>
              <Input
                id="name"
                name="name"
                onChange={handleChange}
              />
            </div>

            <div className="mb-3">
              <Label htmlFor="number">Phone Number</Label>
              <div className="flex gap-2">
                <Select value={phoneIso} onValueChange={setPhoneIso}>
                  <SelectTrigger className="w-[110px]">
                    <SelectValue placeholder="Code" />
                  </SelectTrigger>
                  <SelectContent>
                    {countryCodes.map((item) => (
                      <SelectItem key={item.country} value={item.country}>
                        {item.code} ({item.country})
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Input
                  id="number"
                  name="number"
                  type="tel"
                  placeholder="123 4567"
                  onChange={handleChange}
                  className="flex-1"
                />
              </div>
            </div>
             <div>
                <Label htmlFor="country">Country</Label>
                <Select
                  value={formData.country}
                  onValueChange={(value) =>
                    setFormData({ ...formData, country: value })
                  }
                >
                  <SelectTrigger id="country">
                    <SelectValue placeholder="Select country" />
                  </SelectTrigger>
                  <SelectContent>
  
<SelectItem value="Åland Islands">Åland Islands</SelectItem>
<SelectItem value="Albania">Albania</SelectItem>
<SelectItem value="Algeria">Algeria</SelectItem>
<SelectItem value="American Samoa">American Samoa</SelectItem>
<SelectItem value="Andorra">Andorra</SelectItem>
<SelectItem value="Angola">Angola</SelectItem>
<SelectItem value="Anguilla">Anguilla</SelectItem>
<SelectItem value="Antarctica">Antarctica</SelectItem>
<SelectItem value="Antigua and Barbuda">Antigua and Barbuda</SelectItem>
<SelectItem value="Argentina">Argentina</SelectItem>
<SelectItem value="Armenia">Armenia</SelectItem>
<SelectItem value="Aruba">Aruba</SelectItem>
<SelectItem value="Australia">Australia</SelectItem>
<SelectItem value="Austria">Austria</SelectItem>
<SelectItem value="Azerbaijan">Azerbaijan</SelectItem>
<SelectItem value="Bahamas (the)">Bahamas (the)</SelectItem>
<SelectItem value="Bahrain">Bahrain</SelectItem>
<SelectItem value="Bangladesh">Bangladesh</SelectItem>
<SelectItem value="Barbados">Barbados</SelectItem>
<SelectItem value="Belarus">Belarus</SelectItem>
<SelectItem value="Belgium">Belgium</SelectItem>
<SelectItem value="Belize">Belize</SelectItem>
<SelectItem value="Benin">Benin</SelectItem>
<SelectItem value="Bermuda">Bermuda</SelectItem>
<SelectItem value="Bhutan">Bhutan</SelectItem>
<SelectItem value="Bolivia (Plurinational State of)">Bolivia (Plurinational State of)</SelectItem>
<SelectItem value="Bonaire, Sint Eustatius and Saba">Bonaire, Sint Eustatius and Saba</SelectItem>
<SelectItem value="Bosnia and Herzegovina">Bosnia and Herzegovina</SelectItem>
<SelectItem value="Botswana">Botswana</SelectItem>
<SelectItem value="Bouvet Island">Bouvet Island</SelectItem>
<SelectItem value="Brazil">Brazil</SelectItem>
<SelectItem value="British Indian Ocean Territory (the)">British Indian Ocean Territory (the)</SelectItem>
<SelectItem value="Brunei Darussalam">Brunei Darussalam</SelectItem>
<SelectItem value="Bulgaria">Bulgaria</SelectItem>
<SelectItem value="Burkina Faso">Burkina Faso</SelectItem>
<SelectItem value="Burundi">Burundi</SelectItem>
<SelectItem value="Cabo Verde">Cabo Verde</SelectItem>
<SelectItem value="Cambodia">Cambodia</SelectItem>
<SelectItem value="Cameroon">Cameroon</SelectItem>
<SelectItem value="Canada">Canada</SelectItem>
<SelectItem value="Cayman Islands (the)">Cayman Islands (the)</SelectItem>
<SelectItem value="Central African Republic (the)">Central African Republic (the)</SelectItem>
<SelectItem value="Chad">Chad</SelectItem>
<SelectItem value="Chile">Chile</SelectItem>
<SelectItem value="China">China</SelectItem>
<SelectItem value="Christmas Island">Christmas Island</SelectItem>
<SelectItem value="Cocos (Keeling) Islands (the)">Cocos (Keeling) Islands (the)</SelectItem>
<SelectItem value="Colombia">Colombia</SelectItem>
<SelectItem value="Comoros (the)">Comoros (the)</SelectItem>
<SelectItem value="Congo (the Democratic Republic of the)">Congo (the Democratic Republic of the)</SelectItem>
<SelectItem value="Congo (the)">Congo (the)</SelectItem>
<SelectItem value="Cook Islands (the)">Cook Islands (the)</SelectItem>
<SelectItem value="Costa Rica">Costa Rica</SelectItem>
<SelectItem value="Croatia">Croatia</SelectItem>
<SelectItem value="Cuba">Cuba</SelectItem>
<SelectItem value="Curaçao">Curaçao</SelectItem>
<SelectItem value="Cyprus">Cyprus</SelectItem>
<SelectItem value="Czechia">Czechia</SelectItem>
<SelectItem value="Côte d'Ivoire">Côte d'Ivoire</SelectItem>
<SelectItem value="Denmark">Denmark</SelectItem>
<SelectItem value="Djibouti">Djibouti</SelectItem>
<SelectItem value="Dominica">Dominica</SelectItem>
<SelectItem value="Dominican Republic (the)">Dominican Republic (the)</SelectItem>
<SelectItem value="Ecuador">Ecuador</SelectItem>
<SelectItem value="Egypt">Egypt</SelectItem>
<SelectItem value="El Salvador">El Salvador</SelectItem>
<SelectItem value="Equatorial Guinea">Equatorial Guinea</SelectItem>
<SelectItem value="Eritrea">Eritrea</SelectItem>
<SelectItem value="Estonia">Estonia</SelectItem>
<SelectItem value="Eswatini">Eswatini</SelectItem>
<SelectItem value="Ethiopia">Ethiopia</SelectItem>
<SelectItem value="Falkland Islands (the) [Malvinas]">Falkland Islands (the) [Malvinas]</SelectItem>
<SelectItem value="Faroe Islands (the)">Faroe Islands (the)</SelectItem>
<SelectItem value="Fiji">Fiji</SelectItem>
<SelectItem value="Finland">Finland</SelectItem>
<SelectItem value="France">France</SelectItem>
<SelectItem value="French Guiana">French Guiana</SelectItem>
<SelectItem value="French Polynesia">French Polynesia</SelectItem>
<SelectItem value="French Southern Territories (the)">French Southern Territories (the)</SelectItem>
<SelectItem value="Gabon">Gabon</SelectItem>
<SelectItem value="Gambia (the)">Gambia (the)</SelectItem>
<SelectItem value="Georgia">Georgia</SelectItem>
<SelectItem value="Germany">Germany</SelectItem>
<SelectItem value="Ghana">Ghana</SelectItem>
<SelectItem value="Gibraltar">Gibraltar</SelectItem>
<SelectItem value="Greece">Greece</SelectItem>
<SelectItem value="Greenland">Greenland</SelectItem>
<SelectItem value="Grenada">Grenada</SelectItem>
<SelectItem value="Guadeloupe">Guadeloupe</SelectItem>
<SelectItem value="Guam">Guam</SelectItem>
<SelectItem value="Guatemala">Guatemala</SelectItem>
<SelectItem value="Guernsey">Guernsey</SelectItem>
<SelectItem value="Guinea">Guinea</SelectItem>
<SelectItem value="Guinea-Bissau">Guinea-Bissau</SelectItem>
<SelectItem value="Guyana">Guyana</SelectItem>
<SelectItem value="Haiti">Haiti</SelectItem>
<SelectItem value="Heard Island and McDonald Islands">Heard Island and McDonald Islands</SelectItem>
<SelectItem value="Holy See (the)">Holy See (the)</SelectItem>
<SelectItem value="Honduras">Honduras</SelectItem>
<SelectItem value="Hong Kong">Hong Kong</SelectItem>
<SelectItem value="Hungary">Hungary</SelectItem>
<SelectItem value="Iceland">Iceland</SelectItem>
<SelectItem value="India">India</SelectItem>
<SelectItem value="Indonesia">Indonesia</SelectItem>
<SelectItem value="Iran (Islamic Republic of)">Iran (Islamic Republic of)</SelectItem>
<SelectItem value="Iraq">Iraq</SelectItem>
<SelectItem value="Ireland">Ireland</SelectItem>
<SelectItem value="Isle of Man">Isle of Man</SelectItem>
<SelectItem value="Italy">Italy</SelectItem>
<SelectItem value="Jamaica">Jamaica</SelectItem>
<SelectItem value="Japan">Japan</SelectItem>
<SelectItem value="Jersey">Jersey</SelectItem>
<SelectItem value="Jordan">Jordan</SelectItem>
<SelectItem value="Kazakhstan">Kazakhstan</SelectItem>
<SelectItem value="Kenya">Kenya</SelectItem>
<SelectItem value="Kiribati">Kiribati</SelectItem>
<SelectItem value="Korea (the Democratic People's Republic of)">Korea (the Democratic People's Republic of)</SelectItem>
<SelectItem value="Korea (the Republic of)">Korea (the Republic of)</SelectItem>
<SelectItem value="Kuwait">Kuwait</SelectItem>
<SelectItem value="Kyrgyzstan">Kyrgyzstan</SelectItem>
<SelectItem value="Lao People's Democratic Republic (the)">Lao People's Democratic Republic (the)</SelectItem>
<SelectItem value="Latvia">Latvia</SelectItem>
<SelectItem value="Lebanon">Lebanon</SelectItem>
<SelectItem value="Lesotho">Lesotho</SelectItem>
<SelectItem value="Liberia">Liberia</SelectItem>
<SelectItem value="Libya">Libya</SelectItem>
<SelectItem value="Liechtenstein">Liechtenstein</SelectItem>
<SelectItem value="Lithuania">Lithuania</SelectItem>
<SelectItem value="Luxembourg">Luxembourg</SelectItem>
<SelectItem value="Macao">Macao</SelectItem>
<SelectItem value="Madagascar">Madagascar</SelectItem>
<SelectItem value="Malawi">Malawi</SelectItem>
<SelectItem value="Malaysia">Malaysia</SelectItem>
<SelectItem value="Maldives">Maldives</SelectItem>
<SelectItem value="Mali">Mali</SelectItem>
<SelectItem value="Malta">Malta</SelectItem>
<SelectItem value="Marshall Islands (the)">Marshall Islands (the)</SelectItem>
<SelectItem value="Martinique">Martinique</SelectItem>
<SelectItem value="Mauritania">Mauritania</SelectItem>
<SelectItem value="Mauritius">Mauritius</SelectItem>
<SelectItem value="Mayotte">Mayotte</SelectItem>
<SelectItem value="Mexico">Mexico</SelectItem>
<SelectItem value="Micronesia (Federated States of)">Micronesia (Federated States of)</SelectItem>
<SelectItem value="Moldova (the Republic of)">Moldova (the Republic of)</SelectItem>
<SelectItem value="Monaco">Monaco</SelectItem>
<SelectItem value="Mongolia">Mongolia</SelectItem>
<SelectItem value="Montenegro">Montenegro</SelectItem>
<SelectItem value="Montserrat">Montserrat</SelectItem>
<SelectItem value="Morocco">Morocco</SelectItem>
<SelectItem value="Mozambique">Mozambique</SelectItem>
<SelectItem value="Myanmar">Myanmar</SelectItem>
<SelectItem value="Namibia">Namibia</SelectItem>
<SelectItem value="Nauru">Nauru</SelectItem>
<SelectItem value="Nepal">Nepal</SelectItem>
<SelectItem value="Netherlands (the)">Netherlands (the)</SelectItem>
<SelectItem value="New Caledonia">New Caledonia</SelectItem>
<SelectItem value="New Zealand">New Zealand</SelectItem>
<SelectItem value="Nicaragua">Nicaragua</SelectItem>
<SelectItem value="Niger (the)">Niger (the)</SelectItem>
<SelectItem value="Nigeria">Nigeria</SelectItem>
<SelectItem value="Niue">Niue</SelectItem>
<SelectItem value="Norfolk Island">Norfolk Island</SelectItem>
<SelectItem value="Northern Mariana Islands (the)">Northern Mariana Islands (the)</SelectItem>
<SelectItem value="Norway">Norway</SelectItem>
<SelectItem value="Oman">Oman</SelectItem>
<SelectItem value="Pakistan">Pakistan</SelectItem>
<SelectItem value="Palau">Palau</SelectItem>
<SelectItem value="Palestine">Palestine</SelectItem>
<SelectItem value="Panama">Panama</SelectItem>
<SelectItem value="Papua New Guinea">Papua New Guinea</SelectItem>
<SelectItem value="Paraguay">Paraguay</SelectItem>
<SelectItem value="Peru">Peru</SelectItem>
<SelectItem value="Philippines (the)">Philippines (the)</SelectItem>
<SelectItem value="Pitcairn">Pitcairn</SelectItem>
<SelectItem value="Poland">Poland</SelectItem>
<SelectItem value="Portugal">Portugal</SelectItem>
<SelectItem value="Puerto Rico">Puerto Rico</SelectItem>
<SelectItem value="Qatar">Qatar</SelectItem>
<SelectItem value="Republic of North Macedonia">Republic of North Macedonia</SelectItem>
<SelectItem value="Romania">Romania</SelectItem>
<SelectItem value="Russian Federation (the)">Russian Federation (the)</SelectItem>
<SelectItem value="Rwanda">Rwanda</SelectItem>
<SelectItem value="Réunion">Réunion</SelectItem>
<SelectItem value="Saint Barthélemy">Saint Barthélemy</SelectItem>
<SelectItem value="Saint Helena, Ascension and Tristan da Cunha">Saint Helena, Ascension and Tristan da Cunha</SelectItem>
<SelectItem value="Saint Kitts and Nevis">Saint Kitts and Nevis</SelectItem>
<SelectItem value="Saint Lucia">Saint Lucia</SelectItem>
<SelectItem value="Saint Martin (French part)">Saint Martin (French part)</SelectItem>
<SelectItem value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</SelectItem>
<SelectItem value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</SelectItem>
<SelectItem value="Samoa">Samoa</SelectItem>
<SelectItem value="San Marino">San Marino</SelectItem>
<SelectItem value="Sao Tome and Principe">Sao Tome and Principe</SelectItem>
<SelectItem value="Saudi Arabia">Saudi Arabia</SelectItem>
<SelectItem value="Senegal">Senegal</SelectItem>
<SelectItem value="Serbia">Serbia</SelectItem>
<SelectItem value="Seychelles">Seychelles</SelectItem>
<SelectItem value="Sierra Leone">Sierra Leone</SelectItem>
<SelectItem value="Singapore">Singapore</SelectItem>
<SelectItem value="Sint Maarten (Dutch part)">Sint Maarten (Dutch part)</SelectItem>
<SelectItem value="Slovakia">Slovakia</SelectItem>
<SelectItem value="Slovenia">Slovenia</SelectItem>
<SelectItem value="Solomon Islands">Solomon Islands</SelectItem>
<SelectItem value="Somalia">Somalia</SelectItem>
<SelectItem value="South Africa">South Africa</SelectItem>
<SelectItem value="South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</SelectItem>
<SelectItem value="South Sudan">South Sudan</SelectItem>
<SelectItem value="Spain">Spain</SelectItem>
<SelectItem value="Sri Lanka">Sri Lanka</SelectItem>
<SelectItem value="Sudan (the)">Sudan (the)</SelectItem>
<SelectItem value="Suriname">Suriname</SelectItem>
<SelectItem value="Svalbard and Jan Mayen">Svalbard and Jan Mayen</SelectItem>
<SelectItem value="Sweden">Sweden</SelectItem>
<SelectItem value="Switzerland">Switzerland</SelectItem>
<SelectItem value="Syrian Arab Republic">Syrian Arab Republic</SelectItem>
<SelectItem value="Taiwan (Province of China)">Taiwan (Province of China)</SelectItem>
<SelectItem value="Tajikistan">Tajikistan</SelectItem>
<SelectItem value="Tanzania, United Republic of">Tanzania, United Republic of</SelectItem>
<SelectItem value="Thailand">Thailand</SelectItem>
<SelectItem value="Timor-Leste">Timor-Leste</SelectItem>
<SelectItem value="Togo">Togo</SelectItem>
<SelectItem value="Tokelau">Tokelau</SelectItem>
<SelectItem value="Tonga">Tonga</SelectItem>
<SelectItem value="Trinidad and Tobago">Trinidad and Tobago</SelectItem>
<SelectItem value="Tunisia">Tunisia</SelectItem>
<SelectItem value="Turkey">Turkey</SelectItem>
<SelectItem value="Turkmenistan">Turkmenistan</SelectItem>
<SelectItem value="Turks and Caicos Islands (the)">Turks and Caicos Islands (the)</SelectItem>
<SelectItem value="Tuvalu">Tuvalu</SelectItem>
<SelectItem value="Uganda">Uganda</SelectItem>
<SelectItem value="Ukraine">Ukraine</SelectItem>
<SelectItem value="United Arab Emirates (the)">United Arab Emirates (the)</SelectItem>
<SelectItem value="United Kingdom of Great Britain and Northern Ireland (the)">United Kingdom of Great Britain and Northern Ireland (the)</SelectItem>
<SelectItem value="United States Minor Outlying Islands (the)">United States Minor Outlying Islands (the)</SelectItem>
<SelectItem value="United States of America (the)">United States of America (the)</SelectItem>
<SelectItem value="Uruguay">Uruguay</SelectItem>
<SelectItem value="Uzbekistan">Uzbekistan</SelectItem>
<SelectItem value="Vanuatu">Vanuatu</SelectItem>
<SelectItem value="Venezuela (Bolivarian Republic of)">Venezuela (Bolivarian Republic of)</SelectItem>
<SelectItem value="Viet Nam">Viet Nam</SelectItem>
<SelectItem value="Virgin Islands (British)">Virgin Islands (British)</SelectItem>
<SelectItem value="Virgin Islands (U.S.)">Virgin Islands (U.S.)</SelectItem>
<SelectItem value="Wallis and Futuna">Wallis and Futuna</SelectItem>
<SelectItem value="Western Sahara">Western Sahara</SelectItem>
<SelectItem value="Yemen">Yemen</SelectItem>
<SelectItem value="Zambia">Zambia</SelectItem>
<SelectItem value="Zimbabwe">Zimbabwe</SelectItem>

</SelectContent>

                </Select>
              </div>
            <div className="mb-3">
              <Label htmlFor="email">Email</Label>
              <Input
                id="email"
                name="email"
                placeholder="example@email.com"
                onChange={handleChange}
              />
            </div>

            <div className="mb-3">
              <Label htmlFor="password">Password</Label>
              <Input
                id="password"
                type="password"
                name="password"
                onChange={handleChange}
              />
            </div>

            <div className="mb-4">
              <Label htmlFor="confirmPassword">Confirm Password</Label>
              <Input
                id="confirmPassword"
                type="password"
                name="confirmPassword"
                onChange={handleChange}
              />
            </div>

            <div className="flex items-center space-x-2 mb-6">
              <Checkbox id="terms" />
              <Label htmlFor="terms" className="text-sm text-muted-foreground">
                I agree to the{" "}
                <a href="#" className="text-primary hover:underline">
                  terms & conditions
                </a>
              </Label>
            </div>

            <Button
              type="submit"
              disabled={submitting}
              className="w-full bg-primary hover:bg-primary/90 text-primary-foreground font-semibold py-2"
            >
              {submitting ? "Creating..." : "Create account"}
            </Button>
          </form>
        </motion.div>
      </div>
    </div>
  );
}
