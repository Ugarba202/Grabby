import 'package:flutter/material.dart';
import 'package:grabby_app/core/constant/app_colors.dart';
import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/core/constant/app_images.dart';
import 'package:grabby_app/core/constant/app_text_style.dart';
import 'package:grabby_app/core/utils/validator.dart';
import 'package:grabby_app/widgets/custom_text_field_login.dart';
import 'package:grabby_app/services/storage_service.dart';
import 'package:grabby_app/services/auth_services.dart';
import '../onboaring/widgets/social_login_button.dart';
import '../../core/constant/app_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // Implement actual login with Firebase
      final result = await AuthService.instance.loginWithEmailPassword(
        email: email,
        password: password,
      );

      if (result['success']) {
        final user = result['user'];
        await StorageService.instance.setLoggedIn(true);
        await StorageService.instance.setUserEmail(user.email ?? '');
        await StorageService.instance.setUserId(user.uid);

        if (mounted) {
          _showSnackBar('Login Successful!', isError: false);
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.main_screen, (route) => false);
        }
      } else {
        _showSnackBar(result['message'], isError: true);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Login Failed. Please try again', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleSocialLogin(String provider) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$provider Sign In - Coming Soon!'),
            backgroundColor: AppColors.info,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? AppColors.error : AppColors.info,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                Text(AppStrings.appName, style: AppTextStyles.headlineLarge),

                const SizedBox(height: 5),

                // Subtitle
                Text(
                  AppStrings.signinText,
                  style: AppTextStyles.headlineMedium,
                ),

                const SizedBox(height: 60),

                // Email field
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 25),

                // Password field
                CustomTextField(
                  controller: _passwordController,

                  isPassword: true,
                  obscureText: _obscurePassword,
                  validator: Validators.validatePassword,
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 22),

                // Forgot password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                    },
                    child: Text(
                      AppStrings.forgotPassword,
                      style: TextStyle(
                        color: AppColors.softblue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Sign in button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.softblue,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.softblue.withOpacity(
                        0.6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            AppStrings.sigin,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 25),

                // OR divider
                Column(
                  children: [
                    Center(
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Social login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      imagePath: AppImages.appleIcon,
                      onTap: () => _handleSocialLogin('Apple'),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(width: 16),
                    SocialLoginButton(
                      imagePath: AppImages.facebookIcon,
                      onTap: () => _handleSocialLogin('Facebook'),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(width: 16),
                    SocialLoginButton(
                      imagePath: AppImages.googleIcon,
                      onTap: () => _handleSocialLogin('Google'),
                      enabled: !_isLoading,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.register);
                      },
                      child: Text(
                        AppStrings.createOne,
                        style: TextStyle(
                          color: AppColors.softblue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
