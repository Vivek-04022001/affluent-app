import 'package:affluent/constants/app_colors.dart';
import 'package:affluent/constants/app_images.dart';
import 'package:affluent/features/bottom_navigation/widgets/bottom_navbar.dart';
import 'package:affluent/features/bottom_navigation/widgets/dock_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class BottomNavShell extends StatefulWidget {
  final Widget child;
  const BottomNavShell({super.key, required this.child});

  @override
  State<BottomNavShell> createState() => BottomNavShellState();
}

class BottomNavShellState extends State<BottomNavShell> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(children: [widget.child]),
      floatingActionButton: InkWell(
        onTap: () {
          context.go('/earning');
        },
        child: Container(
          width: 75,
          height: 75,
          margin: EdgeInsets.only(left: 4.w),

          child: CircleAvatar(
            radius: 75,
            backgroundColor: AppColors.purple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.earningIcon,
                  width: 22.sp,
                  height: 22.sp,
                ),
                SizedBox(height: 0.25.h),
                Text(
                  'Earnings',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ).animate().moveY(
          begin: 1000,
          end: 0,
          duration: 700.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
          delay: 600.ms,
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      // bottomNavigationBar: MyBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
