import React, { useState } from 'react';
import { CheckCircle, AlertCircle, FileText, Shield, ArrowLeft } from 'lucide-react';

interface TermsAndConditionsProps {
  onAccept?: (accepted: boolean) => void;
  requireAcceptance?: boolean;
  onBack?: () => void;
  showBackButton?: boolean;
  backButtonText?: string;
}

const TermsAndConditions: React.FC<TermsAndConditionsProps> = ({
  onAccept,
  requireAcceptance = false,
  onBack,
  showBackButton = true,
  backButtonText = 'Back',
}) => {
  const [accepted, setAccepted] = useState(false);
  const [isExpanded, setIsExpanded] = useState(false);

  const handleAccept = () => {
    const newAccepted = !accepted;
    setAccepted(newAccepted);
    onAccept?.(newAccepted);
  };

  const handleBack = () => {
    if (onBack) {
      onBack();
    } else {
      // Default back behavior - go to previous page
      window.history.back();
    }
  };

  const sections = [
    {
      id: 'introduction',
      title: '1. Introduction and Acceptance',
      content: `Welcome to SeasonalConnect, a seasonal job matching platform ("Platform") operated by SeasonalConnect Inc. ("we", "us", "our"). These Terms and Conditions ("Terms") govern your use of our Platform as an employer ("Employer", "you", "your") seeking to connect with seasonal employees. By registering, accessing, or using our Platform, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree with these Terms, you must not use our Platform.`
    },
    {
      id: 'definitions',
      title: '2. Definitions',
      content: `- "Platform" refers to SeasonalConnect website, mobile applications, and related services.
      - "Employer" means any business, organization, or individual seeking to hire seasonal workers through the Platform.
      - "Employee" refers to individuals seeking seasonal employment opportunities.
      - "Seasonal Job" means temporary employment positions with a defined start and end date, typically tied to seasonal demand.
      - "Content" includes job postings, company information, messages, and any other materials shared on the Platform.`
    },
    {
      id: 'eligibility',
      title: '3. Employer Eligibility and Registration',
      content: `To use the Platform as an Employer, you must:
      a) Be at least 18 years old
      b) Have the legal authority to represent your business
      c) Provide accurate and complete registration information
      d) Maintain the confidentiality of your account credentials
      e) Not create multiple accounts without authorization
      
      We reserve the right to verify your business information and refuse service to any employer at our discretion.`
    },
    {
      id: 'job-postings',
      title: '4. Job Postings and Listings',
      content: `As an Employer, you agree:
      a) To provide accurate, complete, and non-deceptive job descriptions
      b) To clearly state the seasonal nature, duration, and compensation of positions
      c) To comply with all applicable labor laws and regulations
      d) To not post discriminatory job listings (based on race, gender, religion, age, disability, etc.)
      e) To promptly remove filled or cancelled positions
      f) To not post misleading or fraudulent job opportunities
      
      We reserve the right to review, modify, or remove any job posting that violates these Terms.`
    },
    {
      id: 'hiring-process',
      title: '5. Hiring Process and Employer Responsibilities',
      content: `Employers are solely responsible for:
      a) Conducting their own screening, interviewing, and selection processes
      b) Verifying employee qualifications, work eligibility, and background checks
      c) Drafting and executing employment agreements
      d) Complying with wage and hour laws, including overtime and minimum wage requirements
      e) Providing a safe work environment compliant with OSHA standards
      f) Carrying appropriate workers' compensation insurance
      g) Handling all tax withholding and reporting obligations
      
      SeasonalConnect is not a party to any employment relationship and does not guarantee employee performance or reliability.`
    },
    {
      id: 'fees',
      title: '6. Fees and Payments',
      content: `Use of certain Platform features may require payment of fees. All fees are non-refundable unless otherwise specified. You agree to:
      a) Pay all applicable fees promptly
      b) Provide accurate billing information
      c) Authorize us to charge your chosen payment method
      d) Accept that subscription fees may automatically renew unless cancelled
      
      We reserve the right to modify our fee structure with 30 days' notice.`
    },
    {
      id: 'intellectual-property',
      title: '7. Intellectual Property',
      content: `All Platform content, features, and functionality are owned by SeasonalConnect Inc. and protected by intellectual property laws. You may not:
      a) Copy, modify, or create derivative works
      b) Use our trademarks without permission
      c) Reverse engineer or attempt to extract source code
      d) Use automated systems to access the Platform excessively
      
      You retain ownership of your job postings and company content but grant us a license to display and distribute it on the Platform.`
    },
    {
      id: 'privacy',
      title: '8. Privacy and Data Protection',
      content: `Your privacy is important. Our Privacy Policy explains how we collect, use, and protect your information. By using the Platform, you consent to our collection and use of data as described in the Privacy Policy. Employers must:
      a) Comply with applicable data protection laws (GDPR, CCPA, etc.)
      b) Only use employee data for legitimate hiring purposes
      c) Implement appropriate security measures for employee information
      d) Not share or sell employee data to third parties without consent`
    },
    {
      id: 'liability',
      title: '9. Limitation of Liability and Disclaimer',
      content: `TO THE MAXIMUM EXTENT PERMITTED BY LAW:
      a) The Platform is provided "as is" without warranties of any kind
      b) We do not guarantee job fill rates, employee quality, or Platform availability
      c) We are not liable for any employment disputes, wage claims, or workplace injuries
      d) Our total liability shall not exceed the fees paid by you in the last 6 months
      e) We are not responsible for third-party content or links
      
      Employers assume all risks associated with hiring seasonal workers.`
    },
    {
      id: 'indemnification',
      title: '10. Indemnification',
      content: `You agree to indemnify, defend, and hold harmless SeasonalConnect Inc., its affiliates, officers, and employees from any claims, damages, losses, or expenses arising from:
      a) Your use of the Platform
      b) Your job postings or hiring practices
      c) Violation of these Terms
      d) Employment disputes with seasonal workers
      e) Violation of applicable laws or regulations`
    },
    {
      id: 'termination',
      title: '11. Termination and Suspension',
      content: `We may suspend or terminate your account if:
      a) You violate these Terms
      b) You engage in fraudulent or illegal activity
      c) You fail to pay applicable fees
      d) We discontinue the Platform
      
      You may terminate your account at any time. Upon termination, your job postings will be removed, but obligations under these Terms survive termination.`
    },
    {
      id: 'disputes',
      title: '12. Dispute Resolution and Governing Law',
      content: `These Terms are governed by the laws of the State of Delaware. Any disputes shall be resolved through binding arbitration in Wilmington, Delaware, rather than in court. Class actions and jury trials are waived.`
    },
    {
      id: 'changes',
      title: '13. Changes to Terms',
      content: `We may modify these Terms at any time. We will notify you of material changes via email or Platform notification. Continued use after changes constitutes acceptance.`
    },
    {
      id: 'contact',
      title: '14. Contact Information',
      content: `Questions about these Terms? Contact us:
      SeasonalConnect Inc.
      123 Business Avenue, Suite 100
      Wilmington, DE 19801
      employers@seasonalconnect.com
      (555) 123-4567`
    }
  ];

  const keyHighlights = [
    "You are responsible for compliance with all labor laws and regulations",
    "SeasonalConnect does not guarantee employee performance or reliability",
    "All hiring decisions and employment relationships are your responsibility",
    "Fees for premium features are non-refundable",
    "You must maintain confidentiality of your account credentials",
    "We may modify or remove job postings that violate our policies"
  ];

  return (
    <div className="max-w-4xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      {/* Back Button Section */}
      {showBackButton && (
        <div className="mb-6">
          <button
            onClick={handleBack}
            className="flex items-center gap-2 text-gray-600 hover:text-gray-900 transition-colors group"
            aria-label={backButtonText}
          >
            <ArrowLeft className="w-5 h-5 group-hover:-translate-x-1 transition-transform" />
            <span className="font-medium">{backButtonText}</span>
          </button>
        </div>
      )}

      {/* Header */}
      <div className="flex items-center gap-3 mb-6">
        <FileText className="w-8 h-8 text-blue-600" />
        <h1 className="text-3xl font-bold text-gray-800">Terms and Conditions for Employers</h1>
      </div>

      {/* Important Notice */}
      <div className="mb-8 p-4 bg-blue-50 rounded-lg border border-blue-200">
        <div className="flex items-start gap-3">
          <AlertCircle className="w-6 h-6 text-blue-600 flex-shrink-0 mt-0.5" />
          <div>
            <h3 className="font-semibold text-blue-800 mb-2">Important Notice for Employers</h3>
            <p className="text-blue-700">
              These Terms and Conditions govern your use of SeasonalConnect as an employer seeking seasonal workers. 
              Please read them carefully as they outline your responsibilities, our limitations, and the legal framework 
              for using our platform.
            </p>
          </div>
        </div>
      </div>

      {/* Key Points Summary */}
      <div className="mb-8">
        <h2 className="text-xl font-semibold text-gray-800 mb-4 flex items-center gap-2">
          <Shield className="w-5 h-5 text-green-600" />
          Key Points Summary
        </h2>
        <ul className="grid grid-cols-1 md:grid-cols-2 gap-3">
          {keyHighlights.map((highlight, index) => (
            <li key={index} className="flex items-start gap-2 p-3 bg-gray-50 rounded-lg">
              <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
              <span className="text-gray-700">{highlight}</span>
            </li>
          ))}
        </ul>
      </div>

      {/* Expand/Collapse Button */}
      <div className="mb-6">
        <button
          onClick={() => setIsExpanded(!isExpanded)}
          className="w-full flex justify-between items-center p-4 bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors"
        >
          <span className="font-semibold text-gray-800">
            {isExpanded ? 'Collapse Full Terms' : 'Expand Full Terms and Conditions'}
          </span>
          <svg
            className={`w-5 h-5 transform transition-transform ${isExpanded ? 'rotate-180' : ''}`}
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </button>
      </div>

      {/* Full Terms Content */}
      {isExpanded && (
        <div className="space-y-8 mb-8">
          {sections.map((section) => (
            <div key={section.id} id={section.id} className="border-b border-gray-200 pb-6">
              <h3 className="text-lg font-semibold text-gray-800 mb-3">{section.title}</h3>
              <div className="text-gray-600 whitespace-pre-line leading-relaxed">
                {section.content}
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Acceptance Section */}
      {requireAcceptance && (
        <div className="mt-8 p-6 bg-gray-50 rounded-lg border border-gray-200">
          <div className="flex items-start gap-3">
            <input
              type="checkbox"
              id="accept-terms"
              checked={accepted}
              onChange={handleAccept}
              className="mt-1 w-5 h-5 text-blue-600 rounded focus:ring-blue-500"
            />
            <div>
              <label htmlFor="accept-terms" className="block text-gray-800 font-medium mb-2">
                I accept the Terms and Conditions
              </label>
              <p className="text-gray-600 text-sm">
                By checking this box, you acknowledge that you have read, understood, and agree to 
                be bound by all terms and conditions outlined above. You also confirm that you have 
                the authority to enter into this agreement on behalf of your business.
              </p>
              {!accepted && requireAcceptance && (
                <p className="mt-2 text-red-600 text-sm flex items-center gap-1">
                  <AlertCircle className="w-4 h-4" />
                  You must accept the Terms and Conditions to proceed
                </p>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Footer */}
      <div className="mt-6 pt-6 border-t border-gray-200">
        <p className="text-sm text-gray-500 text-center">
          Last updated: {new Date().toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
          })} | Version 2.1
        </p>
        <p className="text-sm text-gray-500 text-center mt-2">
          © {new Date().getFullYear()} SeasonalConnect Inc. All rights reserved.
        </p>
      </div>
    </div>
  );
};

export default TermsAndConditions;