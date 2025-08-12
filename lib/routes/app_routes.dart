import 'package:flutter/material.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_sinup_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginSignupScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    dashboard: (context) => const DashboardScreen(),
  };
}