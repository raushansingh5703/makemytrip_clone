import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makemytrip_clone/routes/app_routes.dart';
import 'package:makemytrip_clone/services/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await AuthService.isLoggedIn();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp(isLoggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: isLoggedIn
          ? AppRoutes.dashboard
          : AppRoutes.login,
    );
  }
}
