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
