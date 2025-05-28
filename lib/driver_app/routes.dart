import 'package:go_router/go_router.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
// import 'pages/status_onoff_page.dart';
// import 'pages/status_full_page.dart';
// import 'pages/profile_page.dart';
import 'pages/welcome_page.dart';

////////// Daftar ruoute app nya
final List<GoRoute> routes = [
  
  GoRoute(
    path: '/',
    name: 'splash',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(path: '/welcome', name: 'welcome', builder: (_,__) => const WelcomePage()
  ),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/register',
    name: 'register',
    builder: (context, state) => const RegisterPage(),
  ),
  GoRoute(
    path: '/home',
    name: 'home',
    builder: (context, state) => const DriverHomePage(),
  ),
  // GoRoute(
  //   path: '/statusOnOff',
  //   name: 'statusOnOff',
  //   builder: (context, state) => const StatusOnOffPage(),
  // ),
  // GoRoute(
  //   path: '/statusFull',
  //   name: 'statusFull',
  //   builder: (context, state) => const StatusFullPage(),
  // ),
  // GoRoute(
  //   path: '/profile',
  //   name: 'profile',
  //   builder: (context, state) => const ProfilePage(),
  // ),
];
