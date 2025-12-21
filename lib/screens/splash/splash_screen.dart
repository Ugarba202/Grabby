import 'package:flutter/material.dart';
import 'dart:async';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_routes.dart';
import '../../core/constant/app_string.dart';
import '../../core/constant/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    _navigateToNext();
  }

  void _navigateToNext() {
    // Short splash delay (animation is ~1.5s)
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      // Check onboarding status
      final bool onboardingComplete = StorageService.instance
          .isOnboardingComplete();

      // Check login status (also consider Firebase's currentUser)
      final bool isLoggedIn =
          FirebaseAuth.instance.currentUser != null ||
          StorageService.instance.isLoggedIn();

      // Decide where to navigate next
      if (!onboardingComplete) {
        // First time user → Show onboarding
        Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
      } else if (isLoggedIn) {
        // Returning logged-in user → Go to main/home screen
        Navigator.of(context).pushReplacementNamed(AppRoutes.main_screen);
      } else {
        // Returning user, not logged in → Show login
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 216,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: AssetImage('assets/icons/logo.png'),
                        width: 100,
                      ),
                    ),

                    const SizedBox(height: 15),
                    Text(
                      AppStrings.appTagline,
                      style: AppTextStyles.displaySmall.copyWith(
                        color: AppColors.softblue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
