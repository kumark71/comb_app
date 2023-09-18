import 'package:get/get.dart';
import 'package:hemoqr/bindings/account_status_binding.dart';
import 'package:hemoqr/bindings/addblood_binding.dart';
import 'package:hemoqr/bindings/login_binding.dart';
import 'package:hemoqr/bindings/patient_binding.dart';
import 'package:hemoqr/bindings/professional_account_binding.dart';
import 'package:hemoqr/bindings/purpose_binding.dart';
import 'package:hemoqr/bindings/qr_scanner_binding.dart';
import 'package:hemoqr/bindings/reports_binding.dart';
import 'package:hemoqr/bindings/support_binding.dart';
import 'package:hemoqr/bindings/timer_binding.dart';
import 'package:hemoqr/ui/pages/accounts/account_status.dart';
import 'package:hemoqr/ui/pages/accounts/personal_account.dart';
import 'package:hemoqr/ui/pages/accounts/professional_account.dart';
import 'package:hemoqr/ui/pages/application_use/learn_more.dart';
import 'package:hemoqr/ui/pages/home/home_screen.dart';
import 'package:hemoqr/ui/pages/learn_more/learnmore_1.dart';
import 'package:hemoqr/ui/pages/learn_more/learnmore_2.dart';
import 'package:hemoqr/ui/pages/learn_more/learnmore_3.dart';
import 'package:hemoqr/ui/pages/learn_more/learnmore_4.dart';
import 'package:hemoqr/ui/pages/learn_more/learnmore_5.dart';
import 'package:hemoqr/ui/pages/login/login_screen_personal.dart';
import 'package:hemoqr/ui/pages/login/login_screen_professional.dart';
import 'package:hemoqr/ui/pages/onboarding/onboarding_1.dart';
import 'package:hemoqr/ui/pages/profile/profile_page.dart';
import 'package:hemoqr/ui/pages/profile/support.dart';
import 'package:hemoqr/ui/pages/purpose/purpose_screen.dart';
import 'package:hemoqr/ui/pages/scanner_video_screen/addblood.dart';
import 'package:hemoqr/ui/pages/scanner_video_screen/processing_screen.dart';
import 'package:hemoqr/ui/pages/scanner_video_screen/qr_scanner.dart';
import 'package:hemoqr/ui/pages/scanner_video_screen/result.dart';
import 'package:hemoqr/ui/pages/scanner_video_screen/timer.dart';
import '../bindings/faq_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/personal_account_binding.dart';
import '../bindings/profile_binding.dart';
import '../ui/home1/home_screen1.dart';
import '../ui/pages/application_use/htu_1.dart';
import '../ui/pages/patient_details/patient_details.dart';
import '../ui/pages/profile/edit_profile.dart';
import '../ui/pages/profile/faq_screen.dart';
import '../ui/pages/reports/report.dart';
import '../ui/pages/scanner_video_screen/qr_scanner_old.dart';
import '../ui/pages/splash_screen.dart/splash.dart';

var routes = [
  GetPage(name: "/", page: () => const SplashScreen()),
  GetPage(
      name: "/loginPersonal",
      page: () => const LoginPersonal(),
      binding: LoginBinding(),
      transition: Transition.downToUp),
  GetPage(
      name: "/loginProfessional",
      page: () => const LoginProfessional(),
      binding: LoginBinding(),
      transition: Transition.downToUp),
  GetPage(
    name: "/onboard",
    page: () => const OnboardingOne(),
  ),
  GetPage(
      name: "/purpose",
      page: () => const PurposeScreen(),
      binding: PurposeBinding()),
  GetPage(
    name: '/personalAccount',
    page: () => const PersonalAccount(),
    binding: PersonalAccountBinding(),
  ),
  GetPage(
    name: '/professionalAccount',
    page: () => const ProfessionalAccount(),
    binding: ProfessionalAccountBinding(),
  ),
  GetPage(
    name: '/home',
    page: () => const Home(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/home1',
    page: () => const Home1(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/reports',
    page: () => const ScreeningReport(),
    binding: ReportsBinding(),
  ),
  GetPage(
    name: '/howtouse',
    page: () => const HowToUseS1(),
  ),
  GetPage(
    name: '/profile',
    page: () => const ProfilePage(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: '/faq',
    page: () => const FaqScreen(),
    binding: FaqBinding(),
  ),
  GetPage(
    name: '/patientdetails',
    page: () => const PatientDetails(),
    binding: PatientBinding(),
  ),
  GetPage(
    name: '/qrscanner',
    page: () => QRScanner(),
    binding: QRScannerBinding(),
  ),
  GetPage(
    name: '/learnmore',
    page: () => const LearnMore(),
  ),
  GetPage(
    name: '/processing',
    page: () => const ProcessingPage(),
    binding: QRScannerBinding(),
  ),
  GetPage(
    name: '/result',
    page: () => ResultPage(),
    binding: QRScannerBinding(),
  ),
  GetPage(
    name: '/editprofile',
    page: () => EditProfile(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: '/AddBlood',
    page: () => AddBlood(),
    binding: AddBloodBinding(),
  ),
  GetPage(
    name: "/ReactionTimer",
    page: () => ReactionTimer(),
    binding: TimerBinding(),
  ),
  GetPage(
    name: '/support',
    page: () => const SupportPage(),
    binding: SupportBinding(),
  ),
  GetPage(
    name: '/lm1',
    page: () => const LM1(),
  ),
  GetPage(
    name: '/lm2',
    page: () => const LM2(),
  ),
  GetPage(
    name: '/lm3',
    page: () => const LM3(),
  ),
  GetPage(
    name: '/lm4',
    page: () => const LM4(),
  ),
  GetPage(
    name: '/lm5',
    page: () => const LM5(),
  ),
  GetPage(
      name: '/accountStatus',
      page: () => const AccountStatus(),
      binding: AccountStatusBinding())
];
