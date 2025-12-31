// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'Easy Hire';

  @override
  String get appSubtitle => 'စင်ကာပူရှိ အလုပ်များကို ရှာဖွေလိုက်ပါ';

  @override
  String get welcomeBack => 'ပြန်လည်ကြိုဆိုပါတယ်';

  @override
  String get signInSubtitle => 'သင့်အကောင့်သို့ ဝင်ရောက်ရန် စာရင်းဝင်ပါ';

  @override
  String get phoneNumber => 'ဖုန်းနံပါတ်';

  @override
  String get password => 'စကားဝှက်';

  @override
  String get enterPassword => 'စကားဝှက် ရိုက်ထည့်ပါ';

  @override
  String get noAccount => 'အကောင့်မရှိဘူးလား?';

  @override
  String get signUp => 'စာရင်းသွင်းမည်';

  @override
  String get signUpSubtitle => 'အကောင့်အသစ် ဖန်တီးပြီး စတင်ပါ';

  @override
  String get createAccountTitle => 'အကောင့် ဖန်တီးခြင်း';

  @override
  String get createAccountSubtitle => 'ဖုန်းနံပါတ်ဖြင့် စာရင်းသွင်းပါ';

  @override
  String get fullNameLabel => 'အမည်အပြည့်အစုံ';

  @override
  String get fullNameHint => 'အမည်အပြည့်အစုံ ရိုက်ထည့်ပါ';

  @override
  String get phoneNumberLabel => 'ဖုန်းနံပါတ်';

  @override
  String get passwordLabel => 'စကားဝှက်';

  @override
  String get passwordHint => 'စကားဝှက်ရိုက်ထည့်ပါ';

  @override
  String get employerDashboard_headerTitle => 'The Tan Family';

  @override
  String get employerDashboard_headerSubtitle => 'အလုပ်ခန့်အပ်မှုလုပ်ငန်းစဉ်ကို စီမံခန့်ခွဲပါ';

  @override
  String get employerDashboard_weeklyInterviewQuota => 'အပတ်စဉ် အင်တာဗျူး ကန့်သတ်ချက်';

  @override
  String employerDashboard_interviewsRemainingThisWeek(int count) {
    return 'ဒီအပတ်အတွင်း အင်တာဗျူး $count ခု ကျန်ရှိသေးသည်';
  }

  @override
  String get employerDashboard_quickActions => 'အမြန်လုပ်ဆောင်ချက်များ';

  @override
  String get employerDashboard_browseHelpers => 'Helper များ\nရှာဖွေမည်';

  @override
  String get employerDashboard_viewApplicants => 'လျှောက်ထားသူများ\nကြည့်မည်';

  @override
  String get employerDashboard_editJobPost => 'Job Post\nပြင်မည်';

  @override
  String get employerDashboard_appGuide => 'App လမ်းညွှန်\nကြည့်မည်';

  @override
  String get employerDashboard_upcomingInterview => 'နောက်တစ်ကြိမ် အင်တာဗျူး';

  @override
  String get employerDashboard_confirmed => 'အတည်ပြုပြီး';

  @override
  String get employerDashboard_age => 'အသက်';

  @override
  String get employerDashboard_weight => 'အလေးချိန်';

  @override
  String get employerDashboard_height => 'အရပ်';

  @override
  String get employerDashboard_days => 'နေ့';

  @override
  String get employerDashboard_hours => 'နာရီ';

  @override
  String get employerDashboard_minutes => 'မိနစ်';

  @override
  String get employerDashboard_documentStatus => 'စာရွက်စာတမ်း အခြေအနေ';

  @override
  String get employerDashboard_passport => 'ပတ်စပို့';

  @override
  String get employerDashboard_medical => 'ဆေးစစ်ချက်';

  @override
  String get employerDashboard_training => 'သင်တန်း';

  @override
  String get employerDashboard_verified => 'စစ်ဆေးအတည်ပြုပြီး';

  @override
  String get employerDashboard_pending => 'စစ်ဆေးဆဲ';

  @override
  String get employerDashboard_timeUntilInterview => 'အင်တာဗျူးအတွက် ကျန်ချိန်';

  @override
  String get employerDashboard_viewBiodata => 'Biodata ကြည့်မည်';

  @override
  String get employerDashboard_cancel => 'ပယ်ဖျက်မည်';

  @override
  String get employerDashboard_joinCall => 'Call ဝင်မည်';

  @override
  String get employerDashboard_cancelFailed => 'အင်တာဗျူးကို ပယ်ဖျက်မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String get employerDashboard_cancelSuccess => 'အင်တာဗျူးကို အောင်မြင်စွာ ပယ်ဖျက်ပြီးပါပြီ။';

  @override
  String get employerDashboard_singleHelperPolicyTitle => 'Helper တစ်ယောက်တည်း ခန့်အပ်မှု စည်းမျဉ်း';

  @override
  String get employerDashboard_singleHelperPolicyDesc => 'တစ်ချိန်တည်းမှာ Helper တစ်ယောက်တည်းကိုသာ ခန့်အပ်နိုင်ပါတယ်။ Order ကိုလက်ခံပြီးပါက အခြား Helper Profile များကို ဖျောက်ထားမည်ဖြစ်သည်။';

  @override
  String get employerDashboard_needAssistance => 'အကူအညီလိုပါသလား?';

  @override
  String get employerDashboard_supportSubtitle => 'အလုပ်ခန့်အပ်မှုလုပ်ငန်းစဉ်အတွက် အကူအညီလိုပါက Support ကို ဆက်သွယ်ပါ';

  @override
  String get employerDashboard_contactSupport => 'Support ကို ဆက်သွယ်မည်';

  @override
  String get findHelpers_title => 'Helper များကို ရှာဖွေမည်';

  @override
  String get findHelpers_searchHint => 'အမည်၊ ကျွမ်းကျင်မှု၊ နိုင်ငံသားမှု စသည်ဖြင့် ရှာဖွေပါ...';

  @override
  String get findHelpers_filterSkillsAll => 'ကျွမ်းကျင်မှု: အားလုံး';

  @override
  String get findHelpers_filterLanguageAll => 'ဘာသာစကား: အားလုံး';

  @override
  String get findHelpers_filterCompatiblePersonality => 'ကိုက်ညီသော ကိုယ်ရည်ကိုယ်သွေး';

  @override
  String get findHelpers_noResults => 'ကိုက်ညီသော ရလဒ် မတွေ့ပါ။';

  @override
  String get employerInterview_title => 'အင်တာဗျူးများ';

  @override
  String get employerInterview_subtitle => 'အင်တာဗျူးတောင်းဆိုမှုများကို စီမံခန့်ခွဲပါ';

  @override
  String get employerInterview_tabConfirmed => 'အတည်ပြုပြီး';

  @override
  String get employerInterview_tabPending => 'စောင့်ဆိုင်းဆဲ';

  @override
  String get employerInterview_tabCompleted => 'ပြီးဆုံးပြီး';

  @override
  String get employerInterview_noResults => 'ကိုက်ညီသော ရလဒ် မတွေ့ပါ။';

  @override
  String get messages_title => 'မက်ဆေ့ချ်များ';

  @override
  String get messages_subtitle => 'အင်တာဗျူးပြီးနောက် Helper များနှင့် စကားပြောနိုင်သည်';

  @override
  String get messages_infoTitle => 'အင်တာဗျူးပြီးနောက် စကားပြောခြင်း';

  @override
  String get messages_infoDesc => 'အင်တာဗျူးပြီးဆုံးပြီးနောက် Helper များနှင့် စကားပြောနိုင်ပါတယ်။ Chat ကို Offer ပေးရန် သို့မဟုတ် အင်တာဗျူးထပ်မံ ချိန်းဆိုရန် အသုံးပြုနိုင်ပါတယ်။';

  @override
  String get messages_availableChats => 'စကားပြောရန် ရနိုင်သော Chat များ';

  @override
  String messages_interviewCompletedOn(String date) {
    return '$date တွင် အင်တာဗျူးပြီးဆုံးခဲ့သည်';
  }

  @override
  String get messages_statusAvailable => 'ရရှိနိုင်သည်';

  @override
  String get messages_needHelp => 'အကူအညီလိုပါသလား?';

  @override
  String get messages_supportSubtitle => 'Support အဖွဲ့က သင့်ကို ကူညီပေးရန် အမြဲရှိပါတယ်';

  @override
  String get messages_contactSupport => 'Support ကို ဆက်သွယ်မည်';

  @override
  String get employerAccount_title => 'အလုပ်ရှင် အကောင့်';

  @override
  String get employerAccount_menu_personalInformation => 'ကိုယ်ရေးအချက်အလက်';

  @override
  String get employerAccount_menu_personalityTest => 'ကိုယ်ရည်ကိုယ်သွေး စစ်ဆေးမှု';

  @override
  String get employerAccount_menu_jobDescription => 'အလုပ်ဖော်ပြချက်';

  @override
  String get employerAccount_menu_favoriteHelpers => 'နှစ်သက်သော Helper များ';

  @override
  String get employerAccount_menu_paymentMethod => 'ငွေပေးချေမှု နည်းလမ်း';

  @override
  String get employerAccount_menu_offeredJobs => 'အော်ဖာပေးထားသော အလုပ်များ';

  @override
  String get employerAccount_hiringProgressTitle => 'ခန့်အပ်မှု တိုးတက်မှု';

  @override
  String get employerAccount_progress_profileCreated => 'ပရိုဖိုင် ဖန်တီးပြီး';

  @override
  String get employerAccount_progress_jobPosted => 'အလုပ်တင်ပြီး';

  @override
  String get employerAccount_progress_interviewScheduled => 'အင်တာဗျူး ချိန်းပြီး';

  @override
  String get employerAccount_progress_offerMade => 'အော်ဖာ ပေးပြီး';

  @override
  String get employerAccount_progress_offerMadeSubtitle => 'Helper ရဲ့ ပြန်လည်တုံ့ပြန်မှုကို စောင့်နေသည်';

  @override
  String get employerAccount_progress_inProgress => 'လုပ်ဆောင်နေဆဲ';

  @override
  String get employerAccount_progress_contractSigned => 'စာချုပ် လက်မှတ်ရေးထိုးပြီး';

  @override
  String get employerAccount_progress_contractSignedSubtitle => 'နှစ်ဖက်စလုံး Service Agreement ကို လက်မှတ်ရေးထိုးသည်';

  @override
  String get employerAccount_progress_contractSignedStatus => 'လက်ခံပြီးနောက် ~၂ ရက်ခန့်';

  @override
  String get employerAccount_progress_passportVerification => 'Helper ပတ်စပို့ စစ်ဆေးခြင်း';

  @override
  String get employerAccount_progress_passportVerificationSubtitle => 'မပြီးဆုံးသေးပါက';

  @override
  String get employerAccount_progress_passportVerificationStatus => '~၃-၅ ရက်';

  @override
  String get employerAccount_progress_medicalExam => 'ဆေးစစ်မှု';

  @override
  String get employerAccount_progress_medicalExamSubtitle => 'Helper သည် ဆေးစစ်ခြင်းကို ပြုလုပ်သည်';

  @override
  String get employerAccount_progress_medicalExamStatus => '~၁ ပတ်';

  @override
  String get employerAccount_progress_trainingArrival => 'သင်တန်းစင်တာ ရောက်ရှိခြင်း';

  @override
  String get employerAccount_progress_trainingArrivalSubtitle => 'Helper သည် သင်တန်းစင်တာသို့ ရောက်ရှိသည်';

  @override
  String get employerAccount_progress_trainingArrivalStatus => '~၂ ပတ်';

  @override
  String get employerAccount_progress_ipaApplication => 'IPA လျှောက်ထားခြင်း';

  @override
  String get employerAccount_progress_ipaApplicationSubtitle => 'In-Principle Approval စီမံဆောင်ရွက်ခြင်း';

  @override
  String get employerAccount_progress_ipaApplicationStatus => '~၃-၄ ပတ်';

  @override
  String get employerAccount_progress_insurancePurchase => 'အာမခံ ဝယ်ယူခြင်း';

  @override
  String get employerAccount_progress_insurancePurchaseSubtitle => 'Employer သည် အာမခံပေါ်လစီ ဝယ်ယူသည်';

  @override
  String get employerAccount_progress_insurancePurchaseStatus => 'IPA အတည်ပြုပြီးနောက်';

  @override
  String get employerAccount_progress_airTicketPurchase => 'လေယာဉ်လက်မှတ် ဝယ်ယူခြင်း';

  @override
  String get employerAccount_progress_airTicketPurchaseSubtitle => 'Helper ရဲ့ လေယာဉ်ခရီးစဉ်ကို ဘိုကင်လုပ်သည်';

  @override
  String get employerAccount_progress_airTicketPurchaseStatus => '~၅-၆ ပတ်';

  @override
  String get employerAccount_progress_sipMedicalScheduled => 'SIP နှင့် ဆေးချိန်း စီစဉ်ခြင်း';

  @override
  String get employerAccount_progress_sipMedicalScheduledSubtitle => 'Settling-In Programme နှင့် ဆေးချိန်းများ စီစဉ်ခြင်း';

  @override
  String get employerAccount_progress_sipMedicalScheduledStatus => 'ရောက်မလာမီ';

  @override
  String get employerAccount_progress_handoverDate => 'လွှဲပြောင်းနေ့';

  @override
  String get employerAccount_progress_handoverDateSubtitle => 'Helper ရောက်လာပြီး အလုပ်စတင်သည်';

  @override
  String get employerAccount_progress_handoverDateStatus => 'စုစုပေါင်း ~၆-၈ ပတ်';

  @override
  String get employerAccount_logout => 'ထွက်မည်';

  @override
  String get employerAccount_deleteAccount => 'အကောင့် ဖျက်မည်';

  @override
  String get employerAccount_deleteDialogTitle => 'အကောင့် ဖျက်မည်';

  @override
  String get employerAccount_deleteDialogDesc => 'သင့်အကောင့်ကို ဖျက်ချင်တာ သေချာပါသလား? ဒီလုပ်ဆောင်ချက်ကို ပြန်လည်မလုပ်နိုင်ပါ။';

  @override
  String get employerAccount_cancel => 'မလုပ်တော့ပါ';

  @override
  String get employerAccount_delete => 'ဖျက်မည်';

  @override
  String get jobSearchDashboard_title => 'အလုပ်ရှာဖွေရေး ဒက်ရှ်ဘုတ်';

  @override
  String get jobSearchDashboard_profileCompletionTitle => 'ပရိုဖိုင် ပြည့်စုံအောင် ဖြည့်ပါ';

  @override
  String get jobSearchDashboard_profileCompletionSubtitle => 'အလုပ်ရရှိနိုင်ခြေ ပိုမိုမြင့်မားစေရန် ပရိုဖိုင်ကို ပြည့်စုံအောင် ဖြည့်ပါ';

  @override
  String get jobSearchDashboard_quickActions => 'အမြန်လုပ်ဆောင်ချက်များ';

  @override
  String get jobSearchDashboard_quickActionBrowseJobs => 'အလုပ်များ ရှာဖွေမည်';

  @override
  String get jobSearchDashboard_quickActionSavedJobs => 'သိမ်းထားသော အလုပ်များ';

  @override
  String get jobSearchDashboard_quickActionApplications => 'လျှောက်ထားပြီးသားများ';

  @override
  String get jobSearchDashboard_nextInterview => 'နောက်လာမည့် အင်တာဗျူး';

  @override
  String get jobSearchDashboard_noUpcomingInterview => 'လာမည့် အင်တာဗျူး မရှိသေးပါ';

  @override
  String get jobSearchDashboard_recommendedJobs => 'အကြံပြုထားသော အလုပ်များ';

  @override
  String get jobSearchDashboard_viewAllJobs => 'အလုပ်အားလုံး ကြည့်မည်';

  @override
  String get findJobs_title => 'အလုပ်များ ရှာဖွေမည်';

  @override
  String get findJobs_filterAll => 'အားလုံး';

  @override
  String get findJobs_filterFullTime => 'အချိန်ပြည့်';

  @override
  String get findJobs_filterPartTime => 'အချိန်ပိုင်း';

  @override
  String get findJobs_filterLiveIn => 'နေထိုင်ရမည့် အလုပ်';

  @override
  String get findJobs_filterLiveOut => 'မနေထိုင်ရသော အလုပ်';

  @override
  String get findJobs_searchHint => 'အလုပ်ခေါင်းစဉ်၊ တည်နေရာ၊ ကျွမ်းကျင်မှုဖြင့် ရှာဖွေပါ';

  @override
  String get findJobs_noResults => 'ကိုက်ညီသော ရလဒ် မတွေ့ပါ။';

  @override
  String get helperInterviews_title => 'ကျွန်ုပ်၏ အင်တာဗျူးများ';

  @override
  String get helperInterviews_tabPending => 'စောင့်ဆိုင်းဆဲ';

  @override
  String get helperInterviews_tabAccepted => 'လက်ခံပြီး';

  @override
  String get helperInterviews_tabCompletedCancelled => 'ပြီးဆုံး / ပယ်ဖျက်ပြီး';

  @override
  String get helperInterviews_noPending => 'စောင့်ဆိုင်းဆဲ အင်တာဗျူး မရှိပါ';

  @override
  String get helperInterviews_noAccepted => 'လက်ခံပြီးသော အင်တာဗျူး မရှိပါ';

  @override
  String get helperInterviews_noCompletedCancelled => 'ပြီးဆုံး သို့မဟုတ် ပယ်ဖျက်ပြီးသော အင်တာဗျူး မရှိပါ';

  @override
  String get helperMessages_title => 'မက်ဆေ့ချ်များ';

  @override
  String get helperMessages_timeJustNow => 'ယခုလေးတင်';

  @override
  String helperMessages_timeMinutesAgo(int count) {
    return '$count မိနစ် အကြာ';
  }

  @override
  String helperMessages_timeHoursAgo(int count) {
    return '$count နာရီ အကြာ';
  }

  @override
  String get helperMessages_timeYesterday => 'မနေ့က';

  @override
  String helperMessages_timeDaysAgo(int count) {
    return '$count ရက် အကြာ';
  }

  @override
  String helperMessages_jobOfferExtended(String salary) {
    return '🎉 အလုပ်အော်ဖာ ပေးထားသည် - တစ်လ $salary';
  }

  @override
  String get helperMessages_interviewFollowUp => 'အင်တာဗျူးအတွက် ကျေးဇူးတင်ပါတယ်။ မကြာမီ ပြန်လည် ဆက်သွယ်ပါမည်။';

  @override
  String get helperMessages_workPassApproved => 'သင့်အလုပ်ပါမစ် လျှောက်လွှာကို အတည်ပြုပြီးပါပြီ';

  @override
  String get helperMessages_welcomeSupport => 'Helper App မှ ကြိုဆိုပါတယ်။ ဘာကူညီပေးရမလဲ?';

  @override
  String get helperMessages_emptyTitle => 'မက်ဆေ့ချ် မရှိသေးပါ';

  @override
  String get helperMessages_emptySubtitle => 'Employer များနှင့် စကားပြောသည့် မက်ဆေ့ချ်များကို ဒီမှာ ပြသပါမည်';

  @override
  String get helperAccount_biodata => 'ကိုယ်ရေးအချက်အလက်';

  @override
  String get helperAccount_biodataSubtitle => 'အမည်၊ ဆက်သွယ်ရန်၊ နိုင်ငံသားမှု';

  @override
  String get helperAccount_documents => 'စာရွက်စာတမ်းများ';

  @override
  String get helperAccount_documentsSubtitle => 'ပတ်စပို့၊ လက်မှတ်များ၊ ဆေးစစ်ချက်';

  @override
  String get helperAccount_preferences => 'လိုအပ်ချက်များ';

  @override
  String get helperAccount_preferencesSubtitle => 'လစာ၊ တည်နေရာ၊ တာဝန်များ';

  @override
  String get helperAccount_jobOffers => 'အလုပ်အော်ဖာများ';

  @override
  String get helperAccount_jobOffersSubtitle => 'Employer များမှ ပေးထားသော အော်ဖာများကို ကြည့်မည်';

  @override
  String helperAccount_newCount(int count) {
    return 'အသစ် $count ခု';
  }

  @override
  String get helperAccount_progressTracking => 'တိုးတက်မှု ကြည့်ရှုခြင်း';

  @override
  String get helperAccount_progressTrackingSubtitle => 'ခန့်အပ်မှု လုပ်ငန်းစဉ် အခြေအနေကို ကြည့်မည်';

  @override
  String get helperAccount_helpSupport => 'အကူအညီ & ပံ့ပိုးမှု';

  @override
  String get helperAccount_helpSupportSubtitle => 'မေးလေ့ရှိသည့်မေးခွန်းများ၊ အေဂျင်စီဆက်သွယ်ရန်';

  @override
  String get helperAccount_settings => 'ဆက်တင်များ';

  @override
  String get helperAccount_settingsSubtitle => 'ပရိုဖိုင် စီမံခန့်ခွဲခြင်း';

  @override
  String get helperAccount_logout => 'ထွက်မည်';

  @override
  String get helperAccount_deleteAccount => 'အကောင့် ဖျက်မည်';

  @override
  String get helperAccount_deleteAccountSubtitle => 'အကောင့်ကို အပြီးတိုင် ဖယ်ရှားမည်';

  @override
  String get helperAccount_logoutDialogTitle => 'ထွက်မည်';

  @override
  String get helperAccount_logoutDialogDesc => 'ထွက်ချင်တာ သေချာပါသလား?';

  @override
  String get helperAccount_deleteDialogTitle => 'အကောင့် ဖျက်မည်';

  @override
  String get helperAccount_deleteDialogDesc => 'အကောင့်ကို ဖျက်ချင်တာ သေချာပါသလား? ဒီလုပ်ဆောင်ချက်ကို ပြန်လည်မလုပ်နိုင်ပါ။';

  @override
  String get helperAccount_cancel => 'မလုပ်တော့ပါ';

  @override
  String get helperAccount_delete => 'ဖျက်မည်';

  @override
  String get helperAccount_snackLoggedOut => 'ထွက်ပြီးပါပြီ!';

  @override
  String get helperAccount_snackAccountDeleted => 'အကောင့်ကို အောင်မြင်စွာ ဖျက်ပြီးပါပြီ။';
}
