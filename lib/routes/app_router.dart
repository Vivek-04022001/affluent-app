import 'package:affluent/features/bottom_navigation/bottom_nav_shell.dart';
import 'package:affluent/features/earning/ui/earning_screen.dart';
import 'package:affluent/features/home/ui/home_screen.dart';
import 'package:affluent/features/profile/ui/profile_screen.dart';
import 'package:affluent/features/royalty/ui/royalty_screen.dart';
import 'package:affluent/features/team/ui/team_screen.dart';
import 'package:affluent/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: "/home",
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/team',
            builder: (context, state) => const TeamScreen(),
          ),
          GoRoute(
            path: '/earning',
            builder: (context, state) => const EarningScreen(),
          ),
          GoRoute(
            path: '/royalty',
            builder: (context, state) => const RoyaltyScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
