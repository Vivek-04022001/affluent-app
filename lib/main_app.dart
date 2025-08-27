import 'package:affluent/routes/app_router.dart';
import 'package:affluent/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: darkMode,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
        );
      },
    );
  }
}
