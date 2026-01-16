// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Easy Hire';

  @override
  String get appSubtitle => 'Find jobs in Singapore easily';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInSubtitle => 'Sign in to continue to your account';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get signInContinue => 'Continue';

  @override
  String get signUpContinue => 'Continue';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpSubtitle => 'Create your account to get started';

  @override
  String get createAccountTitle => 'Create Account';

  @override
  String get createAccountSubtitle => 'Sign up with your phone number';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get phoneNumberRequire => 'Phone number is required';

  @override
  String get passwordRequire => 'Password is required';

  @override
  String get fullNameRequire => 'Full name is required';

  @override
  String get employerApp => 'Employer App';

  @override
  String get helperApp => 'Helper App';

  @override
  String get employerSubtitle => 'Find Helper for your needs';

  @override
  String get helperSubtitle => 'Find your dream job in Singapore';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get verifyCodeSubtitle => 'Verify your number with the 6-digit code we just sent via SMS.';

  @override
  String get pinIncorrect => 'PIN is incorrect.';

  @override
  String get dontReceiveOtp => 'Don\'t receive the OTP?';

  @override
  String get resendOtp => 'RESEND OTP';

  @override
  String get resendOtpFailed => 'We couldn\'t resend the code. Please try again.';

  @override
  String get resendOtpSuccess => 'A new code has been sent to your phone.';

  @override
  String get verifyFailed => 'Verification failed. Please try again.';

  @override
  String get verifySuccess => 'Verification successful! Your account is now ready.';

  @override
  String get verify => 'Verify';

  @override
  String get onboardingTitle => 'Help Us Know You Better';

  @override
  String get onboardingSubtitle => 'Complete your profile to increase your chances of finding the perfect job';

  @override
  String get estimatedTimeTitle => 'Estimated Time: 10–15 minutes';

  @override
  String get estimatedTimeDesc => 'This questionnaire helps employers understand your skills, experience, and preferences to match you with suitable job opportunities.';

  @override
  String get whatWeAskTitle => 'What We\'ll Ask About:';

  @override
  String get askPersonalInfo => 'Personal information (name, age, nationality)';

  @override
  String get askContactFamily => 'Contact details and family background';

  @override
  String get askMedicalFood => 'Medical history and food preferences';

  @override
  String get askLanguageSkills => 'Languages spoken and skills';

  @override
  String get askWorkPreference => 'Work experience and job preferences';

  @override
  String get askDocuments => 'Document uploads (passport, certificates, photo)';

  @override
  String get importantInfoTitle => 'Important Information';

  @override
  String get infoSkip_part1 => 'You can ';

  @override
  String get infoSkip_bold => 'skip any questions';

  @override
  String get infoSkip_part2 => ' you\'re not ready to answer';

  @override
  String get infoMandatory_part1 => '';

  @override
  String get infoMandatory_bold => 'Mandatory fields (*)';

  @override
  String get infoMandatory_part2 => ' are required for your biodata to be visible to employers';

  @override
  String get infoApplyLater => 'If you skip now, you\'ll be asked to complete this when applying for jobs';

  @override
  String get infoViews_part1 => 'Complete profiles get ';

  @override
  String get infoViews_bold => '3x more views';

  @override
  String get infoViews_part2 => ' from employers';

  @override
  String get skipForNow => 'Skip for Now';

  @override
  String get getStarted => 'Let\'s Get Started';

  @override
  String get back => 'Back';

  @override
  String get languageSettingsTitle => 'Language Settings';

  @override
  String get skip => 'Skip For Now';

  @override
  String get appLanguage => 'App language';

  @override
  String get appLanguageDesc => 'Choose your preferred language for the app interface';

  @override
  String get availableLanguages => 'Available Languages';

  @override
  String get availableLanguagesDesc => 'Select a language to change the app interface';

  @override
  String get saveLanguagePreference => 'Save Language Preference';

  @override
  String get languageRefreshHint => 'The app will refresh to apply the new language';

  @override
  String get english => 'English';

  @override
  String get myanmar => 'Myanmar';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String dashboardGreeting(Object name) {
    return 'Hello, $name!';
  }

  @override
  String get dashboardSubtitle => 'Ready to find your next opportunity?';

  @override
  String get profileViews => 'Profile Views';

  @override
  String get appliedJobs => 'Applied Jobs';

  @override
  String get interviews => 'Interviews';

  @override
  String profileCompletionTitle(Object percent) {
    return 'Profile: $percent% Complete';
  }

  @override
  String get profileCompletionSubtitle => 'Add documents to boost visibility';

  @override
  String get quickActionsTitle => 'Quick Actions';

  @override
  String get quickActionUpdateBiodata => 'Update Biodata';

  @override
  String get quickActionPersonalityTest => 'Personality Test';

  @override
  String get quickActionGuidelines => 'Guidelines';

  @override
  String get quickActionUploadDocuments => 'Upload Documents';

  @override
  String get quickActionSearchJobs => 'Search Jobs';

  @override
  String get nextInterviewTitle => 'Next Interview';

  @override
  String get interviewDateLabel => 'Interview Date';

  @override
  String get interviewTomorrow => 'Tomorrow';

  @override
  String get interviewSalaryLabel => 'Salary';

  @override
  String get interviewFamilyLabel => 'Family';

  @override
  String interviewFamilyMembers(Object count) {
    return '$count members';
  }

  @override
  String get interviewDutiesLabel => 'Duties';

  @override
  String get interviewOffDaysLabel => 'Off Days';

  @override
  String get interviewCancel => 'Cancel';

  @override
  String jobInFamily(Object count) {
    return '$count in family';
  }

  @override
  String jobChildren(Object count) {
    return '$count children';
  }

  @override
  String jobOffDays(Object days) {
    return 'Off days: $days';
  }

  @override
  String get jobApplied => 'Applied';

  @override
  String get jobApplyNow => 'Apply Now';

  @override
  String jobSalaryFormat(Object period, Object salary) {
    return '$salary/$period';
  }

  @override
  String get all => 'All';

  @override
  String get viewDetails => 'View Details';

  @override
  String adultCountLabel(int count) {
    return '$count Adult';
  }

  @override
  String elderlyCountLabel(int count) {
    return '$count Elderly';
  }

  @override
  String get countdownDays => 'days';

  @override
  String get countdownHours => 'hrs';

  @override
  String get countdownMinutes => 'mins';

  @override
  String get interviewStatusAccept => 'Accept';

  @override
  String get interviewStatusCancel => 'Cancel';

  @override
  String get interviewStatusCompleted => 'Completed';

  @override
  String get interviewStatusCancelled => 'Cancelled';

  @override
  String get interviewStatusNoShow => 'No Show';

  @override
  String get interviewStatusProcessing => 'Interviewing';

  @override
  String get time => 'Time';

  @override
  String get selectInterviewTime => 'Select Interview Time';

  @override
  String get selectInterviewTimeSubtitle => 'Choose your preferred time slot for the interview';

  @override
  String get interviewScheduledSuccess => 'Interview scheduled for selected time!';

  @override
  String get confirmSelection => 'Confirm Selection';

  @override
  String get cancel => 'Cancel';

  @override
  String get date => 'Date';

  @override
  String get profilePendingTitle => 'Profile Pending';

  @override
  String get profilePendingDesc => 'Admin is checking your biodata';

  @override
  String get profileApprovedTitle => 'Profile Approved';

  @override
  String get profileApprovedDesc => 'Your profile has been approved';

  @override
  String get profileRejectedTitle => 'Profile Rejected';

  @override
  String get profileRejectedDesc => 'Your profile was rejected. Please update your biodata';

  @override
  String stepProgress(Object current, Object total) {
    return 'Step $current of $total';
  }

  @override
  String get personalInfoTitle => 'Personal Information';

  @override
  String get personalInfoSubtitle => 'Let\'s start with your basic details';

  @override
  String get fullNamePlaceholder => 'Enter your full name';

  @override
  String get dateOfBirthLabel => 'Date of Birth';

  @override
  String get dateOfBirthPlaceholder => 'dd/mm/yyyy';

  @override
  String get placeOfBirthLabel => 'Place of Birth';

  @override
  String get placeOfBirthPlaceholder => 'City/Town';

  @override
  String get nationalityLabel => 'Nationality';

  @override
  String get nationalityPlaceholder => 'Select nationality';

  @override
  String get genderLabel => 'Gender';

  @override
  String get genderPlaceholder => 'Select gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get heightLabel => 'Height (cm)';

  @override
  String get heightPlaceholder => 'e.g., 161';

  @override
  String get weightLabel => 'Weight (kg)';

  @override
  String get weightPlaceholder => 'e.g., 41';

  @override
  String get submitSuccess => 'Submitted successfully';

  @override
  String get draftSaveSuccess => 'Draft saved successfully';

  @override
  String get submitFailed => 'Submission failed';

  @override
  String get calendarDialogTitle => 'Select date';

  @override
  String fieldRequiredError(Object field) {
    return '$field is required';
  }

  @override
  String get contactFamilyTitle => 'Contact & Family Details';

  @override
  String get contactFamilySubtitle => 'How can we reach you and your family information';

  @override
  String get residentialAddressLabel => 'Residential Address in Home Country';

  @override
  String get residentialAddressPlaceholder => 'Enter your full address';

  @override
  String get contactNumberLabel => 'Contact Number in Home Country';

  @override
  String get contactNumberPlaceholder => 'e.g., +95 123456789';

  @override
  String get airportLabel => 'Port/Airport for Repatriation';

  @override
  String get airportPlaceholder => 'e.g., Yangon International Airport';

  @override
  String get emailLabel => 'Email Address (Optional)';

  @override
  String get emailPlaceholder => 'your.email@example.com';

  @override
  String get religionLabel => 'Religion';

  @override
  String get religionPlaceholder => 'Select religion';

  @override
  String get educationLabel => 'Education Level';

  @override
  String get educationPlaceholder => 'Select education level';

  @override
  String get siblingsLabel => 'Number of Siblings';

  @override
  String get childrenLabel => 'Number of Children';

  @override
  String get maritalStatusLabel => 'Marital Status';

  @override
  String get maritalStatusPlaceholder => 'Select marital status';

  @override
  String get childrenAgeLabel => 'Age(s) of Children (if any)';

  @override
  String get childrenAgePlaceholder => 'e.g., 5, 8, 12';

  @override
  String get saveDraft => 'Save Draft';

  @override
  String get next => 'Next';

  @override
  String get medicalHistoryTitle => 'Medical History';

  @override
  String get medicalHistorySubtitle => 'Please provide your medical information';

  @override
  String get allergiesLabel => 'Do you have any allergies?';

  @override
  String get allergiesPlaceholder => 'List any allergies (or write \'NIL\' if none)';

  @override
  String get pastExistingIllnessesTitle => 'Past and Existing Illnesses';

  @override
  String get pastExistingIllnessesSubtitle => 'Select any conditions you have or had:';

  @override
  String get illnessMental => 'Mental illness';

  @override
  String get illnessTuberculosis => 'Tuberculosis';

  @override
  String get illnessEpilepsy => 'Epilepsy';

  @override
  String get illnessHeartDisease => 'Heart disease';

  @override
  String get illnessAsthma => 'Asthma';

  @override
  String get illnessMalaria => 'Malaria';

  @override
  String get illnessDiabetes => 'Diabetes';

  @override
  String get illnessOperations => 'Had Operations';

  @override
  String get illnessHypertension => 'Hypertension';

  @override
  String get otherIllnessesLabel => 'Other Illnesses (if any)';

  @override
  String get otherIllnessesPlaceholder => 'Please specify';

  @override
  String get physicalDisabilitiesLabel => 'Physical Disabilities';

  @override
  String get physicalDisabilitiesPlaceholder => 'List any physical disabilities (or write \'NIL\' if none)';

  @override
  String get dietaryRestrictionsLabel => 'Dietary Restrictions';

  @override
  String get dietaryRestrictionsPlaceholder => 'Any dietary restrictions? (or write \'NIL\' if none)';

  @override
  String get foodHandlingPreferencesTitle => 'Food Handling Preferences';

  @override
  String get accommodationPreferencesTitle => 'Accommodation Preferences';

  @override
  String get selectAllThatApply => 'Select all that apply to you';

  @override
  String get languagesSpokenTitle => 'Languages Spoken';

  @override
  String get selectLanguagesSpoken => 'Select all languages you can speak';

  @override
  String get experienceAndSkills => 'Experience & Skills';

  @override
  String get totalExperience => 'Total Experience';

  @override
  String get totalExperiencePlaceholder => 'e.g. 5 year';

  @override
  String get skills => 'Skills';

  @override
  String get skillsPlaceholder => 'e.g. Cooking, Childcare, Cleaning';

  @override
  String get jobPreferences => 'Job Preferences';

  @override
  String get jobPreferencesDesc => 'Tell us about your job expectations';

  @override
  String get expectedMonthlySalary => 'Expected Monthly Salary';

  @override
  String get selectYourExperience => 'Select your experience';

  @override
  String get experienceRequired => 'Experience is required';

  @override
  String get salary => 'Salary';

  @override
  String get preferredOffDays => 'Preferred Off Days per Month';

  @override
  String get selectPreferredOffDays => 'Select your preferred off days';

  @override
  String get preferredLocation => 'Preferred Location in Singapore';

  @override
  String get selectPreferredLocation => 'Select your preferred location';

  @override
  String get willingRestDay => 'Willing to work on rest days for compensation?';

  @override
  String get willingYes => 'Yes, willing';

  @override
  String get willingNo => 'Prefer not to';

  @override
  String get salaryInputRequired => 'Please input your expected salary';

  @override
  String get selectExperienceAndSalary => 'Please select your experience and input expected salary.';

  @override
  String get salaryLimit500 => 'Your expected salary shouldn\'t be greater than \$500';

  @override
  String get salaryLimit520 => 'Your expected salary shouldn\'t be greater than \$520';

  @override
  String get salaryLimit580 => 'Your expected salary shouldn\'t be greater than \$580';

  @override
  String get salaryLimit700 => 'Your expected salary shouldn\'t be greater than \$700';

  @override
  String get salaryLimit670 => 'Your expected salary shouldn\'t be greater than \$670';

  @override
  String get expNo => 'No experiences';

  @override
  String get expNoCert => 'No experiences but nursing aid certificates';

  @override
  String get expMiddleEast => 'Middle east experiences';

  @override
  String get expSingapore => 'Singapore experiences';

  @override
  String get expTaiwan => 'Taiwan experiences';

  @override
  String get offDay1 => '1 day';

  @override
  String get offDay2 => '2 days';

  @override
  String get offDay3 => '3 days';

  @override
  String get offDay4 => '4 days';

  @override
  String get offDay5 => '5 days';

  @override
  String get offDay6 => '6 days';

  @override
  String get offDay7 => '7 days';

  @override
  String get offDay8 => '8 days';

  @override
  String get locationAny => 'Any location in Singapore';

  @override
  String get locationNorth => 'North';

  @override
  String get locationSouth => 'South';

  @override
  String get locationEast => 'East';

  @override
  String get locationWest => 'West';

  @override
  String get locationCentral => 'Central';

  @override
  String get workHistory => 'Work History';

  @override
  String get remove => 'Remove';

  @override
  String get location => 'Location';

  @override
  String get selectCountry => 'Select Country';

  @override
  String get duration => 'Duration';

  @override
  String get durationPlaceholder => '2 years';

  @override
  String get description => 'Description';

  @override
  String get descriptionPlaceholder => 'Family with 2 children';

  @override
  String get duties => 'Duties';

  @override
  String get dutiesPlaceholder => 'Childcare, Cooking';

  @override
  String get addWorkHistory => '+ Add Work History';

  @override
  String get uploadDocumentsTitle => 'Upload Your Documents';

  @override
  String get documentsSavedSuccess => 'Your documents have been saved';

  @override
  String get documentsSaveFailed => 'Failed to save your documents. Please try again.';

  @override
  String get documentsEmptyError => 'Documents are empty.';

  @override
  String get draftSavedSuccess => 'Draft saved successfully.';

  @override
  String get introductionVideo => 'Introduction Video';

  @override
  String get introVideoFormats => 'mp4, mov, avi, mkv, wmv, flv, webm';

  @override
  String get profilePhoto => 'Profile Photo';

  @override
  String get photoFormats => 'JPG, PNG (Max 5MB)';

  @override
  String get passport => 'Passport';

  @override
  String get passportFormats => 'PDF, JPG, PNG (Max 5MB)';

  @override
  String get medicalCertificate => 'Medical Certificate';

  @override
  String get policeClearance => 'Police Clearance';

  @override
  String get documentFormats => 'PDF, JPG, PNG (Max 5MB)';

  @override
  String get documentFormatsMultiple => 'PDF, JPG, PNG (Max 5MB each)';

  @override
  String get educationalCertificates => 'Educational Certificates';

  @override
  String get workReferences => 'Work References';

  @override
  String get submit => 'Submit';

  @override
  String get personalityTestTitle => 'Personality Test';

  @override
  String get personalityTestDescription => 'Answer a few statements to get a quick MBTI-style type (E/I, S/N, T/F, J/P). This is an unofficial educational tool.';

  @override
  String get personalityTestInfo => 'There are 16 questions. Tap a dot to show how much you agree. Try to answer based on your typical behavior.';

  @override
  String get start => 'Start';

  @override
  String questionsRangeTitle(int start, int end, int total) {
    return 'Questions $start - $end / $total';
  }

  @override
  String get pleaseAnswerAllQuestions => 'Please answer all questions.';

  @override
  String get previous => 'Previous';

  @override
  String get finish => 'Finish';

  @override
  String get language => 'Language';

  @override
  String get guidelines => 'Guidelines';

  @override
  String get important => 'Important';

  @override
  String get platformGuidelines => 'Platform Guidelines';

  @override
  String get platformGuidelinesDesc => 'Follow these guidelines to ensure a positive experience and increase your chances of finding the perfect job.';

  @override
  String get profileCompletion => 'Profile Completion';

  @override
  String get profileCompletionDesc => 'Complete your profile accurately';

  @override
  String get profileItem1 => 'Provide accurate personal information';

  @override
  String get profileItem2 => 'Upload a clear, professional photo';

  @override
  String get profileItem3 => 'List all relevant work experience';

  @override
  String get profileItem4 => 'Include certifications and skills';

  @override
  String get profileItem5 => 'Keep your contact information updated';

  @override
  String get safetySecurity => 'Safety & Security';

  @override
  String get safetySecurityDesc => 'Stay safe while using the platform';

  @override
  String get safetyItem1 => 'Never share your password with anyone';

  @override
  String get safetyItem2 => 'Verify employer information before interviews';

  @override
  String get safetyItem3 => 'Report suspicious activities immediately';

  @override
  String get safetyItem4 => 'Use only official communication channels';

  @override
  String get safetyItem5 => 'Protect your personal documents';

  @override
  String get professionalConduct => 'Professional Conduct';

  @override
  String get professionalConductDesc => 'Maintain professionalism at all times';

  @override
  String get professionalItem1 => 'Respond to messages promptly';

  @override
  String get professionalItem2 => 'Be honest about your skills and experience';

  @override
  String get professionalItem3 => 'Dress appropriately for interviews';

  @override
  String get professionalItem4 => 'Communicate respectfully with employers';

  @override
  String get professionalItem5 => 'Honor your commitments and schedules';

  @override
  String get interviewGuidelines => 'Interview Guidelines';

  @override
  String get interviewGuidelinesDesc => 'Prepare for successful interviews';

  @override
  String get interviewItem1 => 'Arrive on time for scheduled interviews';

  @override
  String get interviewItem2 => 'Prepare questions about the job';

  @override
  String get interviewItem3 => 'Bring necessary documents';

  @override
  String get interviewItem4 => 'Follow up after interviews';

  @override
  String get interviewItem5 => 'Notify if you need to reschedule';

  @override
  String get dosAndDonts => 'Do\'s and Don\'ts';

  @override
  String get dos => 'Do\'s';

  @override
  String get doItem1 => 'Keep your profile updated regularly';

  @override
  String get doItem2 => 'Respond to job offers within 24 hours';

  @override
  String get doItem3 => 'Provide honest feedback after placements';

  @override
  String get doItem4 => 'Report any issues through proper channels';

  @override
  String get doItem5 => 'Maintain confidentiality of employer information';

  @override
  String get donts => 'Don\'ts';

  @override
  String get dontItem1 => 'Share login credentials with others';

  @override
  String get dontItem2 => 'Accept payment outside the platform';

  @override
  String get dontItem3 => 'Misrepresent your qualifications';

  @override
  String get dontItem4 => 'Ghost employers or miss interviews';

  @override
  String get dontItem5 => 'Share inappropriate content';

  @override
  String get needHelp => 'Need Help?';

  @override
  String get contactSupport => 'Contact our support team';

  @override
  String get getHelp => 'Get Help';

  @override
  String get activelyHiring => 'Actively Hiring';

  @override
  String get positionClosed => 'Position Closed';

  @override
  String postedTimeAgo(Object time) {
    return 'Posted $time';
  }

  @override
  String get startDate => 'Start Date';

  @override
  String get immediate => 'Immediate';

  @override
  String get contract => 'Contract';

  @override
  String get applicants => 'Applicants';

  @override
  String get applied => 'applied';

  @override
  String get employerInformation => 'Employer Information';

  @override
  String get hires => 'hires';

  @override
  String get jobDescription => 'Job Description';

  @override
  String get responsibilities => 'Responsibilities';

  @override
  String get requirements => 'Requirements:';

  @override
  String get otherInfo => 'Other Info';

  @override
  String get offDay => 'Off Day';

  @override
  String get children => 'Children';

  @override
  String get childrenAre => 'Children are';

  @override
  String get adult => 'Adult';

  @override
  String get elderly => 'Elderly';

  @override
  String get homeType => 'Home Type';

  @override
  String get roomType => 'Room Type';

  @override
  String get fullTime => 'Full-time';

  @override
  String get interviewDetails => 'Interview Details';

  @override
  String get videoInterview => 'Video Interview';

  @override
  String get dateOptions => 'Date Options';

  @override
  String get timeOptions => 'Time Options';

  @override
  String get minutes30 => '30 minutes';

  @override
  String get interviewNotes => 'Interview Notes';

  @override
  String reviewsCount(Object rating, Object count) {
    return '$rating • $count reviews';
  }

  @override
  String get contact => 'Contact:';

  @override
  String get email => 'Email:';

  @override
  String get address => 'Address:';

  @override
  String get jobDetails => 'Job Details';

  @override
  String personalityType(Object type) {
    return 'Personality type: $type';
  }

  @override
  String get yourJobOffers => 'Your Job Offers';

  @override
  String get viewJobsOfferedToYou => 'View the jobs offered to you';

  @override
  String get noOfferJobsYet => 'No offer jobs yet';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get adminSupport => 'Admin Support';

  @override
  String get customerService247 => '24/7 Customer Service';

  @override
  String get needHelpChat => 'Need help? Chat with our support team';

  @override
  String get support => 'Support';

  @override
  String get quickLinks => 'Quick Links';

  @override
  String get viewGuidelines => 'View Guidelines';

  @override
  String get updateDocuments => 'Update Documents';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get frequentlyAskedQuestions => 'Frequently Asked Questions';

  @override
  String get faqUpdateBiodataQ => 'How do I update my biodata?';

  @override
  String get faqUpdateBiodataA => 'Go to your profile section and click on \'Edit Biodata\'. You can update your personal information, work experience, and skills from there.';

  @override
  String get faqApplyJobQ => 'How do I apply for a job?';

  @override
  String get faqApplyJobA => 'Browse available jobs in the Jobs section. Click on any job listing to view details, then tap \'Apply Now\' to submit your application.';

  @override
  String get faqInterviewQ => 'How do interviews work?';

  @override
  String get faqInterviewA => 'Once an employer is interested, they\'ll schedule an interview. You\'ll receive a notification and can view all interview details in the Interviews section.';

  @override
  String get faqMessageEmployerQ => 'How do I message an employer?';

  @override
  String get faqMessageEmployerA => 'After being matched with an employer, you can access the Messages section to communicate directly with them.';

  @override
  String get faqDocumentsQ => 'What documents do I need to upload?';

  @override
  String get faqDocumentsA => 'Required documents typically include ID, passport, work permit, and any relevant certifications. Check the Documents section for specific requirements.';

  @override
  String get stillNeedHelp => 'Still need help?';

  @override
  String get adminAvailable247 => 'Admin is available 24/7 to assist you';

  @override
  String get startLiveChat => 'Start Live Chat';

  @override
  String get supportChatTitleSelectItem => 'Select an item';

  @override
  String supportChooseSpecific(Object type) {
    return 'Choose the specific $type you need help with';
  }

  @override
  String supportCreatedAt(Object date) {
    return 'Created at: $date';
  }

  @override
  String get supportSubjectPrefix => 'Support';

  @override
  String get supportEmptyTitle => 'No items found';

  @override
  String supportEmptyDescription(Object type) {
    return 'There are no $type available at the moment';
  }

  @override
  String get supportChatTitle => 'Support Chat';

  @override
  String get supportOnlineTitle => 'Support Online';

  @override
  String get supportOnlineSubtitle => 'Ready to help you';

  @override
  String get supportHelpQuestion => 'What do you need help with?';

  @override
  String get supportHelpDescription => 'Select a category to start chatting with our support team';

  @override
  String get supportCategoryHiredJobs => 'Hired Jobs';

  @override
  String get supportCategoryHiredJobsDesc => 'Issues related to your current or past employment';

  @override
  String get supportCategoryTransaction => 'Transaction';

  @override
  String get supportCategoryTransactionDesc => 'Payment, salary, or financial concerns';

  @override
  String get supportCategoryDocuments => 'Documents';

  @override
  String get supportCategoryDocumentsDesc => 'Document verification or upload issues';

  @override
  String get supportCategoryAccount => 'Account';

  @override
  String get supportCategoryAccountDesc => 'Profile, settings, or account access';

  @override
  String get supportCategoryOther => 'Other';

  @override
  String get supportCategoryOtherDesc => 'General inquiries or other issues';

  @override
  String get supportErrorGeneric => 'Something was wrong!';

  @override
  String get relatedTypeHiredJobs => 'Hired Jobs';

  @override
  String get relatedTypeTransaction => 'Transactions';

  @override
  String get relatedTypeDocument => 'Documents';

  @override
  String get relatedTypeAccount => 'Account';

  @override
  String get relatedTypeGeneral => 'General';

  @override
  String noModelTypeYet(Object modelType) {
    return 'No $modelType yet';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get noNameSet => 'No Name Set';

  @override
  String get noPhoneSet => 'No Phone Set';

  @override
  String get avatarLabel => 'Avatar';

  @override
  String get updateButton => 'Update';

  @override
  String get noConversationsTitle => 'No conversations yet';

  @override
  String get noConversationsSubtitle => 'Apply to jobs and connect with employers to start chatting. Your conversations will appear here.';

  @override
  String get browseJobs => 'Browse Jobs';

  @override
  String get updateBiodata => 'Update Biodata';

  @override
  String get employerDashboard_headerTitle => 'The Tan Family';

  @override
  String get employerDashboard_headerSubtitle => 'Manage your hiring process';

  @override
  String get employerDashboard_weeklyInterviewQuota => 'Weekly Interview Quota';

  @override
  String employerDashboard_interviewsRemainingThisWeek(int count) {
    return '$count interviews remaining this week';
  }

  @override
  String get employerDashboard_quickActions => 'Quick Actions';

  @override
  String get employerDashboard_browseHelpers => 'Browse\nHelpers';

  @override
  String get employerDashboard_viewApplicants => 'View\nApplicants';

  @override
  String get employerDashboard_editJobPost => 'Edit Job\nPost';

  @override
  String get employerDashboard_appGuide => 'App\nGuide';

  @override
  String get employerDashboard_upcomingInterview => 'Upcoming Interview';

  @override
  String get employerDashboard_confirmed => 'Confirmed';

  @override
  String get employerDashboard_age => 'Age';

  @override
  String get employerDashboard_weight => 'Weight';

  @override
  String get employerDashboard_height => 'Height';

  @override
  String get employerDashboard_days => 'days';

  @override
  String get employerDashboard_hours => 'hours';

  @override
  String get employerDashboard_minutes => 'minutes';

  @override
  String get employerDashboard_documentStatus => 'Document Status';

  @override
  String get employerDashboard_passport => 'Passport';

  @override
  String get employerDashboard_medical => 'Medical';

  @override
  String get employerDashboard_training => 'Training';

  @override
  String get employerDashboard_verified => 'Verified';

  @override
  String get employerDashboard_pending => 'Pending';

  @override
  String get employerDashboard_timeUntilInterview => 'Time until interview';

  @override
  String get employerDashboard_viewBiodata => 'View Biodata';

  @override
  String get employerDashboard_cancel => 'Cancel';

  @override
  String get employerDashboard_joinCall => 'Join Call';

  @override
  String get employerDashboard_cancelFailed => 'Failed to cancel the interview. Please try again.';

  @override
  String get employerDashboard_cancelSuccess => 'Interview cancelled successfully.';

  @override
  String get employerDashboard_singleHelperPolicyTitle => 'Single Helper Policy';

  @override
  String get employerDashboard_singleHelperPolicyDesc => 'You can only hire one helper at a time. Once you accept an order, other helper profiles will be hidden.';

  @override
  String get employerDashboard_needAssistance => 'Need Assistance?';

  @override
  String get employerDashboard_supportSubtitle => 'Contact support for help with your hiring process';

  @override
  String get employerDashboard_contactSupport => 'Contact Support';

  @override
  String get findHelpers_title => 'Find Helpers';

  @override
  String get findHelpers_searchHint => 'Search by name, skills, nationality...';

  @override
  String get findHelpers_filterSkillsAll => 'Skills: All';

  @override
  String get findHelpers_filterLanguageAll => 'Language: All';

  @override
  String get findHelpers_filterCompatiblePersonality => 'Compatible Personality';

  @override
  String get findHelpers_noResults => 'No matching results found.';

  @override
  String get employerInterview_title => 'Interviews';

  @override
  String get employerInterview_subtitle => 'Manage your interview requests';

  @override
  String get employerInterview_tabConfirmed => 'Confirmed';

  @override
  String get employerInterview_tabPending => 'Pending';

  @override
  String get employerInterview_tabCompleted => 'Completed';

  @override
  String get employerInterview_noResults => 'No matching results found.';

  @override
  String get messages_title => 'Messages';

  @override
  String get messages_subtitle => 'Chat with helpers after interviews';

  @override
  String get messages_infoTitle => 'Chat After Interview';

  @override
  String get messages_infoDesc => 'You can chat with helpers after completing an interview. Use chat to make offers or arrange additional interviews.';

  @override
  String get messages_availableChats => 'Available Chats';

  @override
  String messages_interviewCompletedOn(String date) {
    return 'Interview completed on $date';
  }

  @override
  String get messages_statusAvailable => 'Available';

  @override
  String get messages_needHelp => 'Need Help?';

  @override
  String get messages_supportSubtitle => 'Our support team is here to assist you';

  @override
  String get messages_contactSupport => 'Contact Support';

  @override
  String get employerAccount_title => 'Employer Account';

  @override
  String get employerAccount_menu_personalInformation => 'Personal Information';

  @override
  String get employerAccount_menu_personalityTest => 'Personality Test';

  @override
  String get employerAccount_menu_jobDescription => 'Job Description';

  @override
  String get employerAccount_menu_favoriteHelpers => 'Favorite Helpers';

  @override
  String get employerAccount_menu_paymentMethod => 'Payment Method';

  @override
  String get employerAccount_menu_offeredJobs => 'Offered Jobs';

  @override
  String get employerAccount_hiringProgressTitle => 'Hiring Progress';

  @override
  String get employerAccount_progress_profileCreated => 'Profile Created';

  @override
  String get employerAccount_progress_jobPosted => 'Job Posted';

  @override
  String get employerAccount_progress_interviewScheduled => 'Interview Scheduled';

  @override
  String get employerAccount_progress_offerMade => 'Offer Made';

  @override
  String get employerAccount_progress_offerMadeSubtitle => 'Awaiting helper\'s response';

  @override
  String get employerAccount_progress_inProgress => 'In Progress';

  @override
  String get employerAccount_progress_contractSigned => 'Contract Signed';

  @override
  String get employerAccount_progress_contractSignedSubtitle => 'Both parties sign service agreement';

  @override
  String get employerAccount_progress_contractSignedStatus => '~2 days after acceptance';

  @override
  String get employerAccount_progress_passportVerification => 'Helper Passport Verification';

  @override
  String get employerAccount_progress_passportVerificationSubtitle => 'If not previously completed';

  @override
  String get employerAccount_progress_passportVerificationStatus => '~3-5 days';

  @override
  String get employerAccount_progress_medicalExam => 'Medical Examination';

  @override
  String get employerAccount_progress_medicalExamSubtitle => 'Helper completes medical check';

  @override
  String get employerAccount_progress_medicalExamStatus => '~1 week';

  @override
  String get employerAccount_progress_trainingArrival => 'Training Centre Arrival';

  @override
  String get employerAccount_progress_trainingArrivalSubtitle => 'Helper arrives at training facility';

  @override
  String get employerAccount_progress_trainingArrivalStatus => '~2 weeks';

  @override
  String get employerAccount_progress_ipaApplication => 'IPA Application';

  @override
  String get employerAccount_progress_ipaApplicationSubtitle => 'In-Principle Approval processing';

  @override
  String get employerAccount_progress_ipaApplicationStatus => '~3-4 weeks';

  @override
  String get employerAccount_progress_insurancePurchase => 'Insurance Purchase';

  @override
  String get employerAccount_progress_insurancePurchaseSubtitle => 'Employer purchases insurance policy';

  @override
  String get employerAccount_progress_insurancePurchaseStatus => 'After IPA approval';

  @override
  String get employerAccount_progress_airTicketPurchase => 'Air Ticket Purchase';

  @override
  String get employerAccount_progress_airTicketPurchaseSubtitle => 'Book helper\'s flight';

  @override
  String get employerAccount_progress_airTicketPurchaseStatus => '~5-6 weeks';

  @override
  String get employerAccount_progress_sipMedicalScheduled => 'SIP & Medical Scheduled';

  @override
  String get employerAccount_progress_sipMedicalScheduledSubtitle => 'Settling-In Programme and medical appointments';

  @override
  String get employerAccount_progress_sipMedicalScheduledStatus => 'Before arrival';

  @override
  String get employerAccount_progress_handoverDate => 'Handover Date';

  @override
  String get employerAccount_progress_handoverDateSubtitle => 'Helper arrives and starts work';

  @override
  String get employerAccount_progress_handoverDateStatus => '~6-8 weeks total';

  @override
  String get employerAccount_logout => 'Logout';

  @override
  String get employerAccount_deleteAccount => 'Delete Account';

  @override
  String get employerAccount_deleteDialogTitle => 'Delete Account';

  @override
  String get employerAccount_deleteDialogDesc => 'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get employerAccount_cancel => 'Cancel';

  @override
  String get employerAccount_delete => 'Delete';

  @override
  String get jobSearchDashboard_title => 'Job Search Dashboard';

  @override
  String get jobSearchDashboard_profileCompletionTitle => 'Complete Your Profile';

  @override
  String get jobSearchDashboard_profileCompletionSubtitle => 'Finish your profile to increase your chances of getting hired';

  @override
  String get jobSearchDashboard_quickActions => 'Quick Actions';

  @override
  String get jobSearchDashboard_quickActionBrowseJobs => 'Browse Jobs';

  @override
  String get jobSearchDashboard_quickActionSavedJobs => 'Saved Jobs';

  @override
  String get jobSearchDashboard_quickActionApplications => 'My Applications';

  @override
  String get jobSearchDashboard_nextInterview => 'Next Interview';

  @override
  String get jobSearchDashboard_noUpcomingInterview => 'No upcoming interviews';

  @override
  String get jobSearchDashboard_recommendedJobs => 'Recommended Jobs';

  @override
  String get jobSearchDashboard_viewAllJobs => 'View All Jobs';

  @override
  String get findJobs_title => 'Find Jobs';

  @override
  String get findJobs_filterAll => 'All';

  @override
  String get findJobs_filterFullTime => 'Full Time';

  @override
  String get findJobs_filterPartTime => 'Part Time';

  @override
  String get findJobs_filterLiveIn => 'Live-in';

  @override
  String get findJobs_filterLiveOut => 'Live-out';

  @override
  String get findJobs_searchHint => 'Search jobs by title, location, or skills';

  @override
  String get findJobs_noResults => 'No matching results found.';

  @override
  String get helperInterviews_title => 'My Interviews';

  @override
  String get helperInterviews_tabPending => 'Pending';

  @override
  String get helperInterviews_tabAccepted => 'Accepted';

  @override
  String get helperInterviews_tabCompletedCancelled => 'Completed / Cancelled';

  @override
  String get helperInterviews_tabCompleted => 'Completed';

  @override
  String get helperInterviews_tabCancelled => 'Cancelled';

  @override
  String get helperInterviews_noPending => 'No pending interviews';

  @override
  String get helperInterviews_noAccepted => 'No accepted interviews';

  @override
  String get helperInterviews_noCompletedCancelled => 'No completed or cancelled interviews';

  @override
  String get helperMessages_title => 'Messages';

  @override
  String get helperMessages_timeJustNow => 'Just now';

  @override
  String helperMessages_timeMinutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String helperMessages_timeHoursAgo(int count) {
    return '$count hour ago';
  }

  @override
  String get helperMessages_timeYesterday => 'Yesterday';

  @override
  String helperMessages_timeDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String helperMessages_jobOfferExtended(String salary) {
    return '🎉 Job Offer Extended - $salary/month';
  }

  @override
  String get helperMessages_interviewFollowUp => 'Thank you for the interview. We will get back to you soon.';

  @override
  String get helperMessages_workPassApproved => 'Your work pass application has been approved';

  @override
  String get helperMessages_welcomeSupport => 'Welcome to Helper App! How can we help you?';

  @override
  String get helperMessages_emptyTitle => 'No messages yet';

  @override
  String get helperMessages_emptySubtitle => 'Your messages with employers will appear here';

  @override
  String get helperAccount_biodata => 'Biodata';

  @override
  String get helperAccount_biodataSubtitle => 'Name, contact, nationality';

  @override
  String get helperAccount_documents => 'Documents';

  @override
  String get helperAccount_documentsSubtitle => 'Passport, certificates, medical';

  @override
  String get helperAccount_preferences => 'Preferences';

  @override
  String get helperAccount_preferencesSubtitle => 'Salary, location, duties';

  @override
  String get helperAccount_jobOffers => 'Job Offers';

  @override
  String get helperAccount_jobOffersSubtitle => 'View offers received from employers';

  @override
  String helperAccount_newCount(int count) {
    return '$count New';
  }

  @override
  String get helperAccount_progressTracking => 'Progress Tracking';

  @override
  String get helperAccount_progressTrackingSubtitle => 'View hiring process status';

  @override
  String get helperAccount_helpSupport => 'Help & Support';

  @override
  String get helperAccount_helpSupportSubtitle => 'FAQs, contact agency';

  @override
  String get helperAccount_settings => 'Settings';

  @override
  String get helperAccount_settingsSubtitle => 'Profile Manage';

  @override
  String get helperAccount_logout => 'Log Out';

  @override
  String get helperAccount_deleteAccount => 'Delete Account';

  @override
  String get helperAccount_deleteAccountSubtitle => 'Permanently remove your account';

  @override
  String get helperAccount_logoutDialogTitle => 'Logout';

  @override
  String get helperAccount_logoutDialogDesc => 'Are you sure you want to logout?';

  @override
  String get helperAccount_deleteDialogTitle => 'Delete Account';

  @override
  String get helperAccount_deleteDialogDesc => 'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get helperAccount_cancel => 'Cancel';

  @override
  String get helperAccount_delete => 'Delete';

  @override
  String get helperAccount_snackLoggedOut => 'Logged out!';

  @override
  String get helperAccount_snackAccountDeleted => 'Account deleted successfully.';
}
