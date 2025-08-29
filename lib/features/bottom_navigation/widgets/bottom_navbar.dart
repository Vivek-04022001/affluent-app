import 'package:affluent/constants/app_colors.dart';
import 'package:affluent/constants/app_images.dart';
import 'package:affluent/features/bottom_navigation/widgets/bottom_dock_painter.dart';
import 'package:affluent/features/bottom_navigation/widgets/dock_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _lastValidIndex = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedIndex = _calculateSelectedIndex(context);
    _lastValidIndex = selectedIndex;

    final icons = [
      [AppImages.homeIcon, 'Home'],
      [AppImages.teamIcon, 'My Team'],
      [AppImages.royaltyIcon, 'Royalty'],
      [AppImages.profileIcon, 'Profile'],
    ];

    final routes = ['/home', '/team', '/royalty', '/profile'];

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      height: 10.h,
      decoration: BoxDecoration(color: Colors.transparent),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final tabWidth = constraints.maxWidth / 5;

          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  AppImages.navbarBg,
                  fit: BoxFit.fill, // stretches edge-to-edge
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: List.generate(5, (i) {
                    if (i == 2) {
                      // Middle slot empty for FAB
                      return SizedBox(width: tabWidth);
                    }
                    final actualIndex = i > 2 ? i - 1 : i;
                    final isSelected = actualIndex == selectedIndex;

                    return SizedBox(
                      width: tabWidth,
                      child: InkWell(
                        onTap: () => context.go(routes[actualIndex]),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow:
                                    isSelected
                                        ? [
                                          BoxShadow(
                                            color: AppColors.yellow.withValues(
                                              alpha: 0.4,
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                        : null,
                              ),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    icons[actualIndex][0],
                                    width: 20.sp,
                                    height: 20.sp,
                                  ),
                                  SizedBox(height: 0.25.h),
                                  Text(
                                    icons[actualIndex][1],
                                    style: textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/home')) return 0;
    if (loc.startsWith('/team')) return 1;
    if (loc.startsWith('/royal')) return 2;
    if (loc.startsWith('/profile')) return 3;
    if (loc.startsWith('/earning')) return 4;
    return _lastValidIndex;
  }
}
