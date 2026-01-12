// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Easy Hire'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find jobs in Singapore easily'**
  String get appSubtitle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to your account'**
  String get signInSubtitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @signInContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get signInContinue;

  /// No description provided for @signUpContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get signUpContinue;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started'**
  String get signUpSubtitle;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up with your phone number'**
  String get createAccountSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @phoneNumberRequire.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequire;

  /// No description provided for @passwordRequire.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequire;

  /// No description provided for @fullNameRequire.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequire;

  /// No description provided for @employerApp.
  ///
  /// In en, this message translates to:
  /// **'Employer App'**
  String get employerApp;

  /// No description provided for @helperApp.
  ///
  /// In en, this message translates to:
  /// **'Helper App'**
  String get helperApp;

  /// No description provided for @employerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find Helper for your needs'**
  String get employerSubtitle;

  /// No description provided for @helperSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your dream job in Singapore'**
  String get helperSubtitle;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @verifyCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number with the 6-digit code we just sent via SMS.'**
  String get verifyCodeSubtitle;

  /// No description provided for @pinIncorrect.
  ///
  /// In en, this message translates to:
  /// **'PIN is incorrect.'**
  String get pinIncorrect;

  /// No description provided for @dontReceiveOtp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t receive the OTP?'**
  String get dontReceiveOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'RESEND OTP'**
  String get resendOtp;

  /// No description provided for @resendOtpFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t resend the code. Please try again.'**
  String get resendOtpFailed;

  /// No description provided for @resendOtpSuccess.
  ///
  /// In en, this message translates to:
  /// **'A new code has been sent to your phone.'**
  String get resendOtpSuccess;

  /// No description provided for @verifyFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed. Please try again.'**
  String get verifyFailed;

  /// No description provided for @verifySuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification successful! Your account is now ready.'**
  String get verifySuccess;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Us Know You Better'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile to increase your chances of finding the perfect job'**
  String get onboardingSubtitle;

  /// No description provided for @estimatedTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated Time: 10–15 minutes'**
  String get estimatedTimeTitle;

  /// No description provided for @estimatedTimeDesc.
  ///
  /// In en, this message translates to:
  /// **'This questionnaire helps employers understand your skills, experience, and preferences to match you with suitable job opportunities.'**
  String get estimatedTimeDesc;

  /// No description provided for @whatWeAskTitle.
  ///
  /// In en, this message translates to:
  /// **'What We\'ll Ask About:'**
  String get whatWeAskTitle;

  /// No description provided for @askPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information (name, age, nationality)'**
  String get askPersonalInfo;

  /// No description provided for @askContactFamily.
  ///
  /// In en, this message translates to:
  /// **'Contact details and family background'**
  String get askContactFamily;

  /// No description provided for @askMedicalFood.
  ///
  /// In en, this message translates to:
  /// **'Medical history and food preferences'**
  String get askMedicalFood;

  /// No description provided for @askLanguageSkills.
  ///
  /// In en, this message translates to:
  /// **'Languages spoken and skills'**
  String get askLanguageSkills;

  /// No description provided for @askWorkPreference.
  ///
  /// In en, this message translates to:
  /// **'Work experience and job preferences'**
  String get askWorkPreference;

  /// No description provided for @askDocuments.
  ///
  /// In en, this message translates to:
  /// **'Document uploads (passport, certificates, photo)'**
  String get askDocuments;

  /// No description provided for @importantInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Information'**
  String get importantInfoTitle;

  /// No description provided for @infoSkip_part1.
  ///
  /// In en, this message translates to:
  /// **'You can '**
  String get infoSkip_part1;

  /// No description provided for @infoSkip_bold.
  ///
  /// In en, this message translates to:
  /// **'skip any questions'**
  String get infoSkip_bold;

  /// No description provided for @infoSkip_part2.
  ///
  /// In en, this message translates to:
  /// **' you\'re not ready to answer'**
  String get infoSkip_part2;

  /// No description provided for @infoMandatory_part1.
  ///
  /// In en, this message translates to:
  /// **''**
  String get infoMandatory_part1;

  /// No description provided for @infoMandatory_bold.
  ///
  /// In en, this message translates to:
  /// **'Mandatory fields (*)'**
  String get infoMandatory_bold;

  /// No description provided for @infoMandatory_part2.
  ///
  /// In en, this message translates to:
  /// **' are required for your biodata to be visible to employers'**
  String get infoMandatory_part2;

  /// No description provided for @infoApplyLater.
  ///
  /// In en, this message translates to:
  /// **'If you skip now, you\'ll be asked to complete this when applying for jobs'**
  String get infoApplyLater;

  /// No description provided for @infoViews_part1.
  ///
  /// In en, this message translates to:
  /// **'Complete profiles get '**
  String get infoViews_part1;

  /// No description provided for @infoViews_bold.
  ///
  /// In en, this message translates to:
  /// **'3x more views'**
  String get infoViews_bold;

  /// No description provided for @infoViews_part2.
  ///
  /// In en, this message translates to:
  /// **' from employers'**
  String get infoViews_part2;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get getStarted;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @languageSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettingsTitle;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip For Now'**
  String get skip;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @appLanguageDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language for the app interface'**
  String get appLanguageDesc;

  /// No description provided for @availableLanguages.
  ///
  /// In en, this message translates to:
  /// **'Available Languages'**
  String get availableLanguages;

  /// No description provided for @availableLanguagesDesc.
  ///
  /// In en, this message translates to:
  /// **'Select a language to change the app interface'**
  String get availableLanguagesDesc;

  /// No description provided for @saveLanguagePreference.
  ///
  /// In en, this message translates to:
  /// **'Save Language Preference'**
  String get saveLanguagePreference;

  /// No description provided for @languageRefreshHint.
  ///
  /// In en, this message translates to:
  /// **'The app will refresh to apply the new language'**
  String get languageRefreshHint;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @myanmar.
  ///
  /// In en, this message translates to:
  /// **'Myanmar'**
  String get myanmar;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @dashboardGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String dashboardGreeting(Object name);

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to find your next opportunity?'**
  String get dashboardSubtitle;

  /// No description provided for @profileViews.
  ///
  /// In en, this message translates to:
  /// **'Profile Views'**
  String get profileViews;

  /// No description provided for @appliedJobs.
  ///
  /// In en, this message translates to:
  /// **'Applied Jobs'**
  String get appliedJobs;

  /// No description provided for @interviews.
  ///
  /// In en, this message translates to:
  /// **'Interviews'**
  String get interviews;

  /// No description provided for @profileCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile: {percent}% Complete'**
  String profileCompletionTitle(Object percent);

  /// No description provided for @profileCompletionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add documents to boost visibility'**
  String get profileCompletionSubtitle;

  /// No description provided for @quickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActionsTitle;

  /// No description provided for @quickActionUpdateBiodata.
  ///
  /// In en, this message translates to:
  /// **'Update Biodata'**
  String get quickActionUpdateBiodata;

  /// No description provided for @quickActionPersonalityTest.
  ///
  /// In en, this message translates to:
  /// **'Personality Test'**
  String get quickActionPersonalityTest;

  /// No description provided for @quickActionGuidelines.
  ///
  /// In en, this message translates to:
  /// **'Guidelines'**
  String get quickActionGuidelines;

  /// No description provided for @quickActionUploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get quickActionUploadDocuments;

  /// No description provided for @quickActionSearchJobs.
  ///
  /// In en, this message translates to:
  /// **'Search Jobs'**
  String get quickActionSearchJobs;

  /// No description provided for @nextInterviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Next Interview'**
  String get nextInterviewTitle;

  /// No description provided for @interviewDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Interview Date'**
  String get interviewDateLabel;

  /// No description provided for @interviewTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get interviewTomorrow;

  /// No description provided for @interviewSalaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get interviewSalaryLabel;

  /// No description provided for @interviewFamilyLabel.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get interviewFamilyLabel;

  /// No description provided for @interviewFamilyMembers.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String interviewFamilyMembers(Object count);

  /// No description provided for @interviewDutiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Duties'**
  String get interviewDutiesLabel;

  /// No description provided for @interviewOffDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Off Days'**
  String get interviewOffDaysLabel;

  /// No description provided for @interviewCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get interviewCancel;

  /// No description provided for @jobInFamily.
  ///
  /// In en, this message translates to:
  /// **'{count} in family'**
  String jobInFamily(Object count);

  /// No description provided for @jobChildren.
  ///
  /// In en, this message translates to:
  /// **'{count} children'**
  String jobChildren(Object count);

  /// No description provided for @jobOffDays.
  ///
  /// In en, this message translates to:
  /// **'Off days: {days}'**
  String jobOffDays(Object days);

  /// No description provided for @jobApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get jobApplied;

  /// No description provided for @jobApplyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get jobApplyNow;

  /// No description provided for @jobSalaryFormat.
  ///
  /// In en, this message translates to:
  /// **'{salary}/{period}'**
  String jobSalaryFormat(Object period, Object salary);

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// Number of adults in the household
  ///
  /// In en, this message translates to:
  /// **'{count} Adult'**
  String adultCountLabel(int count);

  /// Number of elderly people in the household
  ///
  /// In en, this message translates to:
  /// **'{count} Elderly'**
  String elderlyCountLabel(int count);

  /// No description provided for @countdownDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get countdownDays;

  /// No description provided for @countdownHours.
  ///
  /// In en, this message translates to:
  /// **'hrs'**
  String get countdownHours;

  /// No description provided for @countdownMinutes.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get countdownMinutes;

  /// No description provided for @interviewStatusAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get interviewStatusAccept;

  /// No description provided for @interviewStatusCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get interviewStatusCancel;

  /// No description provided for @interviewStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get interviewStatusCompleted;

  /// No description provided for @interviewStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get interviewStatusCancelled;

  /// No description provided for @interviewStatusNoShow.
  ///
  /// In en, this message translates to:
  /// **'No Show'**
  String get interviewStatusNoShow;

  /// No description provided for @interviewStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Interviewing'**
  String get interviewStatusProcessing;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @selectInterviewTime.
  ///
  /// In en, this message translates to:
  /// **'Select Interview Time'**
  String get selectInterviewTime;

  /// No description provided for @selectInterviewTimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred time slot for the interview'**
  String get selectInterviewTimeSubtitle;

  /// No description provided for @interviewScheduledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Interview scheduled for selected time!'**
  String get interviewScheduledSuccess;

  /// No description provided for @confirmSelection.
  ///
  /// In en, this message translates to:
  /// **'Confirm Selection'**
  String get confirmSelection;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @employerDashboard_headerTitle.
  ///
  /// In en, this message translates to:
  /// **'The Tan Family'**
  String get employerDashboard_headerTitle;

  /// No description provided for @employerDashboard_headerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your hiring process'**
  String get employerDashboard_headerSubtitle;

  /// No description provided for @employerDashboard_weeklyInterviewQuota.
  ///
  /// In en, this message translates to:
  /// **'Weekly Interview Quota'**
  String get employerDashboard_weeklyInterviewQuota;

  /// No description provided for @employerDashboard_interviewsRemainingThisWeek.
  ///
  /// In en, this message translates to:
  /// **'{count} interviews remaining this week'**
  String employerDashboard_interviewsRemainingThisWeek(int count);

  /// No description provided for @employerDashboard_quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get employerDashboard_quickActions;

  /// No description provided for @employerDashboard_browseHelpers.
  ///
  /// In en, this message translates to:
  /// **'Browse\nHelpers'**
  String get employerDashboard_browseHelpers;

  /// No description provided for @employerDashboard_viewApplicants.
  ///
  /// In en, this message translates to:
  /// **'View\nApplicants'**
  String get employerDashboard_viewApplicants;

  /// No description provided for @employerDashboard_editJobPost.
  ///
  /// In en, this message translates to:
  /// **'Edit Job\nPost'**
  String get employerDashboard_editJobPost;

  /// No description provided for @employerDashboard_appGuide.
  ///
  /// In en, this message translates to:
  /// **'App\nGuide'**
  String get employerDashboard_appGuide;

  /// No description provided for @employerDashboard_upcomingInterview.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Interview'**
  String get employerDashboard_upcomingInterview;

  /// No description provided for @employerDashboard_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get employerDashboard_confirmed;

  /// No description provided for @employerDashboard_age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get employerDashboard_age;

  /// No description provided for @employerDashboard_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get employerDashboard_weight;

  /// No description provided for @employerDashboard_height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get employerDashboard_height;

  /// No description provided for @employerDashboard_days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get employerDashboard_days;

  /// No description provided for @employerDashboard_hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get employerDashboard_hours;

  /// No description provided for @employerDashboard_minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get employerDashboard_minutes;

  /// No description provided for @employerDashboard_documentStatus.
  ///
  /// In en, this message translates to:
  /// **'Document Status'**
  String get employerDashboard_documentStatus;

  /// No description provided for @employerDashboard_passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get employerDashboard_passport;

  /// No description provided for @employerDashboard_medical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get employerDashboard_medical;

  /// No description provided for @employerDashboard_training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get employerDashboard_training;

  /// No description provided for @employerDashboard_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get employerDashboard_verified;

  /// No description provided for @employerDashboard_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get employerDashboard_pending;

  /// No description provided for @employerDashboard_timeUntilInterview.
  ///
  /// In en, this message translates to:
  /// **'Time until interview'**
  String get employerDashboard_timeUntilInterview;

  /// No description provided for @employerDashboard_viewBiodata.
  ///
  /// In en, this message translates to:
  /// **'View Biodata'**
  String get employerDashboard_viewBiodata;

  /// No description provided for @employerDashboard_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get employerDashboard_cancel;

  /// No description provided for @employerDashboard_joinCall.
  ///
  /// In en, this message translates to:
  /// **'Join Call'**
  String get employerDashboard_joinCall;

  /// No description provided for @employerDashboard_cancelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel the interview. Please try again.'**
  String get employerDashboard_cancelFailed;

  /// No description provided for @employerDashboard_cancelSuccess.
  ///
  /// In en, this message translates to:
  /// **'Interview cancelled successfully.'**
  String get employerDashboard_cancelSuccess;

  /// No description provided for @employerDashboard_singleHelperPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Single Helper Policy'**
  String get employerDashboard_singleHelperPolicyTitle;

  /// No description provided for @employerDashboard_singleHelperPolicyDesc.
  ///
  /// In en, this message translates to:
  /// **'You can only hire one helper at a time. Once you accept an order, other helper profiles will be hidden.'**
  String get employerDashboard_singleHelperPolicyDesc;

  /// No description provided for @employerDashboard_needAssistance.
  ///
  /// In en, this message translates to:
  /// **'Need Assistance?'**
  String get employerDashboard_needAssistance;

  /// No description provided for @employerDashboard_supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Contact support for help with your hiring process'**
  String get employerDashboard_supportSubtitle;

  /// No description provided for @employerDashboard_contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get employerDashboard_contactSupport;

  /// No description provided for @findHelpers_title.
  ///
  /// In en, this message translates to:
  /// **'Find Helpers'**
  String get findHelpers_title;

  /// No description provided for @findHelpers_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, skills, nationality...'**
  String get findHelpers_searchHint;

  /// No description provided for @findHelpers_filterSkillsAll.
  ///
  /// In en, this message translates to:
  /// **'Skills: All'**
  String get findHelpers_filterSkillsAll;

  /// No description provided for @findHelpers_filterLanguageAll.
  ///
  /// In en, this message translates to:
  /// **'Language: All'**
  String get findHelpers_filterLanguageAll;

  /// No description provided for @findHelpers_filterCompatiblePersonality.
  ///
  /// In en, this message translates to:
  /// **'Compatible Personality'**
  String get findHelpers_filterCompatiblePersonality;

  /// No description provided for @findHelpers_noResults.
  ///
  /// In en, this message translates to:
  /// **'No matching results found.'**
  String get findHelpers_noResults;

  /// No description provided for @employerInterview_title.
  ///
  /// In en, this message translates to:
  /// **'Interviews'**
  String get employerInterview_title;

  /// No description provided for @employerInterview_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your interview requests'**
  String get employerInterview_subtitle;

  /// No description provided for @employerInterview_tabConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get employerInterview_tabConfirmed;

  /// No description provided for @employerInterview_tabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get employerInterview_tabPending;

  /// No description provided for @employerInterview_tabCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get employerInterview_tabCompleted;

  /// No description provided for @employerInterview_noResults.
  ///
  /// In en, this message translates to:
  /// **'No matching results found.'**
  String get employerInterview_noResults;

  /// No description provided for @messages_title.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages_title;

  /// No description provided for @messages_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with helpers after interviews'**
  String get messages_subtitle;

  /// No description provided for @messages_infoTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat After Interview'**
  String get messages_infoTitle;

  /// No description provided for @messages_infoDesc.
  ///
  /// In en, this message translates to:
  /// **'You can chat with helpers after completing an interview. Use chat to make offers or arrange additional interviews.'**
  String get messages_infoDesc;

  /// No description provided for @messages_availableChats.
  ///
  /// In en, this message translates to:
  /// **'Available Chats'**
  String get messages_availableChats;

  /// No description provided for @messages_interviewCompletedOn.
  ///
  /// In en, this message translates to:
  /// **'Interview completed on {date}'**
  String messages_interviewCompletedOn(String date);

  /// No description provided for @messages_statusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get messages_statusAvailable;

  /// No description provided for @messages_needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get messages_needHelp;

  /// No description provided for @messages_supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our support team is here to assist you'**
  String get messages_supportSubtitle;

  /// No description provided for @messages_contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get messages_contactSupport;

  /// No description provided for @employerAccount_title.
  ///
  /// In en, this message translates to:
  /// **'Employer Account'**
  String get employerAccount_title;

  /// No description provided for @employerAccount_menu_personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get employerAccount_menu_personalInformation;

  /// No description provided for @employerAccount_menu_personalityTest.
  ///
  /// In en, this message translates to:
  /// **'Personality Test'**
  String get employerAccount_menu_personalityTest;

  /// No description provided for @employerAccount_menu_jobDescription.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get employerAccount_menu_jobDescription;

  /// No description provided for @employerAccount_menu_favoriteHelpers.
  ///
  /// In en, this message translates to:
  /// **'Favorite Helpers'**
  String get employerAccount_menu_favoriteHelpers;

  /// No description provided for @employerAccount_menu_paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get employerAccount_menu_paymentMethod;

  /// No description provided for @employerAccount_menu_offeredJobs.
  ///
  /// In en, this message translates to:
  /// **'Offered Jobs'**
  String get employerAccount_menu_offeredJobs;

  /// No description provided for @employerAccount_hiringProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Hiring Progress'**
  String get employerAccount_hiringProgressTitle;

  /// No description provided for @employerAccount_progress_profileCreated.
  ///
  /// In en, this message translates to:
  /// **'Profile Created'**
  String get employerAccount_progress_profileCreated;

  /// No description provided for @employerAccount_progress_jobPosted.
  ///
  /// In en, this message translates to:
  /// **'Job Posted'**
  String get employerAccount_progress_jobPosted;

  /// No description provided for @employerAccount_progress_interviewScheduled.
  ///
  /// In en, this message translates to:
  /// **'Interview Scheduled'**
  String get employerAccount_progress_interviewScheduled;

  /// No description provided for @employerAccount_progress_offerMade.
  ///
  /// In en, this message translates to:
  /// **'Offer Made'**
  String get employerAccount_progress_offerMade;

  /// No description provided for @employerAccount_progress_offerMadeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Awaiting helper\'s response'**
  String get employerAccount_progress_offerMadeSubtitle;

  /// No description provided for @employerAccount_progress_inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get employerAccount_progress_inProgress;

  /// No description provided for @employerAccount_progress_contractSigned.
  ///
  /// In en, this message translates to:
  /// **'Contract Signed'**
  String get employerAccount_progress_contractSigned;

  /// No description provided for @employerAccount_progress_contractSignedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Both parties sign service agreement'**
  String get employerAccount_progress_contractSignedSubtitle;

  /// No description provided for @employerAccount_progress_contractSignedStatus.
  ///
  /// In en, this message translates to:
  /// **'~2 days after acceptance'**
  String get employerAccount_progress_contractSignedStatus;

  /// No description provided for @employerAccount_progress_passportVerification.
  ///
  /// In en, this message translates to:
  /// **'Helper Passport Verification'**
  String get employerAccount_progress_passportVerification;

  /// No description provided for @employerAccount_progress_passportVerificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If not previously completed'**
  String get employerAccount_progress_passportVerificationSubtitle;

  /// No description provided for @employerAccount_progress_passportVerificationStatus.
  ///
  /// In en, this message translates to:
  /// **'~3-5 days'**
  String get employerAccount_progress_passportVerificationStatus;

  /// No description provided for @employerAccount_progress_medicalExam.
  ///
  /// In en, this message translates to:
  /// **'Medical Examination'**
  String get employerAccount_progress_medicalExam;

  /// No description provided for @employerAccount_progress_medicalExamSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Helper completes medical check'**
  String get employerAccount_progress_medicalExamSubtitle;

  /// No description provided for @employerAccount_progress_medicalExamStatus.
  ///
  /// In en, this message translates to:
  /// **'~1 week'**
  String get employerAccount_progress_medicalExamStatus;

  /// No description provided for @employerAccount_progress_trainingArrival.
  ///
  /// In en, this message translates to:
  /// **'Training Centre Arrival'**
  String get employerAccount_progress_trainingArrival;

  /// No description provided for @employerAccount_progress_trainingArrivalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Helper arrives at training facility'**
  String get employerAccount_progress_trainingArrivalSubtitle;

  /// No description provided for @employerAccount_progress_trainingArrivalStatus.
  ///
  /// In en, this message translates to:
  /// **'~2 weeks'**
  String get employerAccount_progress_trainingArrivalStatus;

  /// No description provided for @employerAccount_progress_ipaApplication.
  ///
  /// In en, this message translates to:
  /// **'IPA Application'**
  String get employerAccount_progress_ipaApplication;

  /// No description provided for @employerAccount_progress_ipaApplicationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'In-Principle Approval processing'**
  String get employerAccount_progress_ipaApplicationSubtitle;

  /// No description provided for @employerAccount_progress_ipaApplicationStatus.
  ///
  /// In en, this message translates to:
  /// **'~3-4 weeks'**
  String get employerAccount_progress_ipaApplicationStatus;

  /// No description provided for @employerAccount_progress_insurancePurchase.
  ///
  /// In en, this message translates to:
  /// **'Insurance Purchase'**
  String get employerAccount_progress_insurancePurchase;

  /// No description provided for @employerAccount_progress_insurancePurchaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Employer purchases insurance policy'**
  String get employerAccount_progress_insurancePurchaseSubtitle;

  /// No description provided for @employerAccount_progress_insurancePurchaseStatus.
  ///
  /// In en, this message translates to:
  /// **'After IPA approval'**
  String get employerAccount_progress_insurancePurchaseStatus;

  /// No description provided for @employerAccount_progress_airTicketPurchase.
  ///
  /// In en, this message translates to:
  /// **'Air Ticket Purchase'**
  String get employerAccount_progress_airTicketPurchase;

  /// No description provided for @employerAccount_progress_airTicketPurchaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Book helper\'s flight'**
  String get employerAccount_progress_airTicketPurchaseSubtitle;

  /// No description provided for @employerAccount_progress_airTicketPurchaseStatus.
  ///
  /// In en, this message translates to:
  /// **'~5-6 weeks'**
  String get employerAccount_progress_airTicketPurchaseStatus;

  /// No description provided for @employerAccount_progress_sipMedicalScheduled.
  ///
  /// In en, this message translates to:
  /// **'SIP & Medical Scheduled'**
  String get employerAccount_progress_sipMedicalScheduled;

  /// No description provided for @employerAccount_progress_sipMedicalScheduledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Settling-In Programme and medical appointments'**
  String get employerAccount_progress_sipMedicalScheduledSubtitle;

  /// No description provided for @employerAccount_progress_sipMedicalScheduledStatus.
  ///
  /// In en, this message translates to:
  /// **'Before arrival'**
  String get employerAccount_progress_sipMedicalScheduledStatus;

  /// No description provided for @employerAccount_progress_handoverDate.
  ///
  /// In en, this message translates to:
  /// **'Handover Date'**
  String get employerAccount_progress_handoverDate;

  /// No description provided for @employerAccount_progress_handoverDateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Helper arrives and starts work'**
  String get employerAccount_progress_handoverDateSubtitle;

  /// No description provided for @employerAccount_progress_handoverDateStatus.
  ///
  /// In en, this message translates to:
  /// **'~6-8 weeks total'**
  String get employerAccount_progress_handoverDateStatus;

  /// No description provided for @employerAccount_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get employerAccount_logout;

  /// No description provided for @employerAccount_deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get employerAccount_deleteAccount;

  /// No description provided for @employerAccount_deleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get employerAccount_deleteDialogTitle;

  /// No description provided for @employerAccount_deleteDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get employerAccount_deleteDialogDesc;

  /// No description provided for @employerAccount_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get employerAccount_cancel;

  /// No description provided for @employerAccount_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get employerAccount_delete;

  /// No description provided for @jobSearchDashboard_title.
  ///
  /// In en, this message translates to:
  /// **'Job Search Dashboard'**
  String get jobSearchDashboard_title;

  /// No description provided for @jobSearchDashboard_profileCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get jobSearchDashboard_profileCompletionTitle;

  /// No description provided for @jobSearchDashboard_profileCompletionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Finish your profile to increase your chances of getting hired'**
  String get jobSearchDashboard_profileCompletionSubtitle;

  /// No description provided for @jobSearchDashboard_quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get jobSearchDashboard_quickActions;

  /// No description provided for @jobSearchDashboard_quickActionBrowseJobs.
  ///
  /// In en, this message translates to:
  /// **'Browse Jobs'**
  String get jobSearchDashboard_quickActionBrowseJobs;

  /// No description provided for @jobSearchDashboard_quickActionSavedJobs.
  ///
  /// In en, this message translates to:
  /// **'Saved Jobs'**
  String get jobSearchDashboard_quickActionSavedJobs;

  /// No description provided for @jobSearchDashboard_quickActionApplications.
  ///
  /// In en, this message translates to:
  /// **'My Applications'**
  String get jobSearchDashboard_quickActionApplications;

  /// No description provided for @jobSearchDashboard_nextInterview.
  ///
  /// In en, this message translates to:
  /// **'Next Interview'**
  String get jobSearchDashboard_nextInterview;

  /// No description provided for @jobSearchDashboard_noUpcomingInterview.
  ///
  /// In en, this message translates to:
  /// **'No upcoming interviews'**
  String get jobSearchDashboard_noUpcomingInterview;

  /// No description provided for @jobSearchDashboard_recommendedJobs.
  ///
  /// In en, this message translates to:
  /// **'Recommended Jobs'**
  String get jobSearchDashboard_recommendedJobs;

  /// No description provided for @jobSearchDashboard_viewAllJobs.
  ///
  /// In en, this message translates to:
  /// **'View All Jobs'**
  String get jobSearchDashboard_viewAllJobs;

  /// No description provided for @findJobs_title.
  ///
  /// In en, this message translates to:
  /// **'Find Jobs'**
  String get findJobs_title;

  /// No description provided for @findJobs_filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get findJobs_filterAll;

  /// No description provided for @findJobs_filterFullTime.
  ///
  /// In en, this message translates to:
  /// **'Full Time'**
  String get findJobs_filterFullTime;

  /// No description provided for @findJobs_filterPartTime.
  ///
  /// In en, this message translates to:
  /// **'Part Time'**
  String get findJobs_filterPartTime;

  /// No description provided for @findJobs_filterLiveIn.
  ///
  /// In en, this message translates to:
  /// **'Live-in'**
  String get findJobs_filterLiveIn;

  /// No description provided for @findJobs_filterLiveOut.
  ///
  /// In en, this message translates to:
  /// **'Live-out'**
  String get findJobs_filterLiveOut;

  /// No description provided for @findJobs_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search jobs by title, location, or skills'**
  String get findJobs_searchHint;

  /// No description provided for @findJobs_noResults.
  ///
  /// In en, this message translates to:
  /// **'No matching results found.'**
  String get findJobs_noResults;

  /// No description provided for @helperInterviews_title.
  ///
  /// In en, this message translates to:
  /// **'My Interviews'**
  String get helperInterviews_title;

  /// No description provided for @helperInterviews_tabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get helperInterviews_tabPending;

  /// No description provided for @helperInterviews_tabAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get helperInterviews_tabAccepted;

  /// No description provided for @helperInterviews_tabCompletedCancelled.
  ///
  /// In en, this message translates to:
  /// **'Completed / Cancelled'**
  String get helperInterviews_tabCompletedCancelled;

  /// No description provided for @helperInterviews_noPending.
  ///
  /// In en, this message translates to:
  /// **'No pending interviews'**
  String get helperInterviews_noPending;

  /// No description provided for @helperInterviews_noAccepted.
  ///
  /// In en, this message translates to:
  /// **'No accepted interviews'**
  String get helperInterviews_noAccepted;

  /// No description provided for @helperInterviews_noCompletedCancelled.
  ///
  /// In en, this message translates to:
  /// **'No completed or cancelled interviews'**
  String get helperInterviews_noCompletedCancelled;

  /// No description provided for @helperMessages_title.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get helperMessages_title;

  /// No description provided for @helperMessages_timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get helperMessages_timeJustNow;

  /// No description provided for @helperMessages_timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String helperMessages_timeMinutesAgo(int count);

  /// No description provided for @helperMessages_timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hour ago'**
  String helperMessages_timeHoursAgo(int count);

  /// No description provided for @helperMessages_timeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get helperMessages_timeYesterday;

  /// No description provided for @helperMessages_timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String helperMessages_timeDaysAgo(int count);

  /// No description provided for @helperMessages_jobOfferExtended.
  ///
  /// In en, this message translates to:
  /// **'🎉 Job Offer Extended - {salary}/month'**
  String helperMessages_jobOfferExtended(String salary);

  /// No description provided for @helperMessages_interviewFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Thank you for the interview. We will get back to you soon.'**
  String get helperMessages_interviewFollowUp;

  /// No description provided for @helperMessages_workPassApproved.
  ///
  /// In en, this message translates to:
  /// **'Your work pass application has been approved'**
  String get helperMessages_workPassApproved;

  /// No description provided for @helperMessages_welcomeSupport.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Helper App! How can we help you?'**
  String get helperMessages_welcomeSupport;

  /// No description provided for @helperMessages_emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get helperMessages_emptyTitle;

  /// No description provided for @helperMessages_emptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your messages with employers will appear here'**
  String get helperMessages_emptySubtitle;

  /// No description provided for @helperAccount_biodata.
  ///
  /// In en, this message translates to:
  /// **'Biodata'**
  String get helperAccount_biodata;

  /// No description provided for @helperAccount_biodataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, contact, nationality'**
  String get helperAccount_biodataSubtitle;

  /// No description provided for @helperAccount_documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get helperAccount_documents;

  /// No description provided for @helperAccount_documentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Passport, certificates, medical'**
  String get helperAccount_documentsSubtitle;

  /// No description provided for @helperAccount_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get helperAccount_preferences;

  /// No description provided for @helperAccount_preferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Salary, location, duties'**
  String get helperAccount_preferencesSubtitle;

  /// No description provided for @helperAccount_jobOffers.
  ///
  /// In en, this message translates to:
  /// **'Job Offers'**
  String get helperAccount_jobOffers;

  /// No description provided for @helperAccount_jobOffersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View offers received from employers'**
  String get helperAccount_jobOffersSubtitle;

  /// No description provided for @helperAccount_newCount.
  ///
  /// In en, this message translates to:
  /// **'{count} New'**
  String helperAccount_newCount(int count);

  /// No description provided for @helperAccount_progressTracking.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking'**
  String get helperAccount_progressTracking;

  /// No description provided for @helperAccount_progressTrackingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View hiring process status'**
  String get helperAccount_progressTrackingSubtitle;

  /// No description provided for @helperAccount_helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helperAccount_helpSupport;

  /// No description provided for @helperAccount_helpSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FAQs, contact agency'**
  String get helperAccount_helpSupportSubtitle;

  /// No description provided for @helperAccount_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get helperAccount_settings;

  /// No description provided for @helperAccount_settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Manage'**
  String get helperAccount_settingsSubtitle;

  /// No description provided for @helperAccount_logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get helperAccount_logout;

  /// No description provided for @helperAccount_deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get helperAccount_deleteAccount;

  /// No description provided for @helperAccount_deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your account'**
  String get helperAccount_deleteAccountSubtitle;

  /// No description provided for @helperAccount_logoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get helperAccount_logoutDialogTitle;

  /// No description provided for @helperAccount_logoutDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get helperAccount_logoutDialogDesc;

  /// No description provided for @helperAccount_deleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get helperAccount_deleteDialogTitle;

  /// No description provided for @helperAccount_deleteDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get helperAccount_deleteDialogDesc;

  /// No description provided for @helperAccount_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get helperAccount_cancel;

  /// No description provided for @helperAccount_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get helperAccount_delete;

  /// No description provided for @helperAccount_snackLoggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out!'**
  String get helperAccount_snackLoggedOut;

  /// No description provided for @helperAccount_snackAccountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully.'**
  String get helperAccount_snackAccountDeleted;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'my': return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
