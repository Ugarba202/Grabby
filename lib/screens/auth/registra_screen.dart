import 'package:flutter/material.dart';
import 'package:grabby_app/core/constant/app_colors.dart';
import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/core/constant/app_string.dart';
import 'package:grabby_app/core/utils/validator.dart';

import 'package:grabby_app/screens/onboaring/widgets/auth_header.dart';
import 'package:grabby_app/screens/onboaring/widgets/custom_buttom.dart';
import 'package:grabby_app/screens/onboaring/widgets/custom_checkbox.dart';
import 'package:grabby_app/screens/onboaring/widgets/custom_text_field.dart';
import 'package:grabby_app/screens/onboaring/widgets/divider_with_text.dart';
import 'package:grabby_app/screens/onboaring/widgets/phone_number_field.dart';
import 'package:grabby_app/screens/onboaring/widgets/social_login_button.dart';
import 'package:grabby_app/services/auth_services.dart';
import '../../core/constant/app_images.dart';
import '../../features/enable_location_screen.dart';
import '../../services/storage_service.dart';

/// Registration screen for new users
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // State variables
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _acceptNewsletter = false;
  String _selectedCountryCode = '+234';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle registration
  Future<void> _handleRegister() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if terms accepted
    if (!_acceptTerms) {
      _showSnackBar('Please accept Terms & Conditions', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get form data
      final fullName = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = _selectedCountryCode + _phoneController.text.trim();
      final password = _passwordController.text;

      debugPrint('Register attempt:');
      debugPrint('Name: $fullName');
      debugPrint('Email: $email');
      debugPrint('Phone: $phone');

      // Register with Firebase
      final result = await AuthService.instance.registerWithEmailPassword(
        name: fullName,
        email: email,
        password: password,
        phone: phone,
      );

      setState(() => _isLoading = false);

      if (result['success']) {
        // Save user info to local storage
        await StorageService.instance.setUserName(fullName);
        await StorageService.instance.setUserEmail(email);
        await StorageService.instance.setUserPhone(phone);

        // Show success message and instruct user to check email
        _showSucccess(
          'Account created! Please check your email for a verification code.',
        );

        // Navigate to verification screen
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const EnableLocationScreen(),
            ),
          );
        }
      } else {
        // Show error message from Firebase
        _showSnackBar(result['message'], isError: true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        _showSnackBar('Registration failed. Please try again.', isError: true);
      }
      debugPrint('Registration error: $e');
    }
  }

  /// Handle social registration
  Future<void> _handleSocialRegister(String provider) async {
    setState(() => _isLoading = true);

    try {
      Map<String, dynamic>? result;

      switch (provider.toLowerCase()) {
        case 'google':
          result = await AuthService.instance.signInWithGoogle();
          break;

        case 'apple':
          _showSnackBar('Apple Sign-In - Coming Soon!');
          setState(() => _isLoading = false);
          return;

        case 'facebook':
          _showSnackBar('Facebook Sign-In - Coming Soon!');
          setState(() => _isLoading = false);
          return;

        default:
          _showSnackBar('Unknown provider');
          setState(() => _isLoading = false);
          return;
      }

      setState(() => _isLoading = false);

      if (result['success']) {
        // Save user data to local storage
        final user = result['user'];
        await StorageService.instance.setUserName(user.displayName ?? 'User');
        await StorageService.instance.setUserEmail(user.email ?? '');
        await StorageService.instance.setLoggedIn(true);
        await StorageService.instance.setUserId(user.uid);

        // Show success message
        _showSucccess(result['message']);

        // Navigate to main screen
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.main_screen,
            (route) => false,
          );
        }
      } else {
        _showSnackBar(result['message'], isError: true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Sign-in failed. Please try again.', isError: true);
      debugPrint('Social sign-in error: $e');
    }
  }

  /// Navigate to login screen
  void _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  /// Navigate to terms page
  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          // Make content scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Center(
                child: Text(
                  'Welcome to Grabby!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'These terms and conditions outline the rules and regulations for the use of Grabby\'s mobile application.',
              ),
              SizedBox(height: 10),
              Text(
                'By accessing this app, we assume you accept these terms and conditions. Do not continue to use Grabby if you do not agree to take all of the terms and conditions stated on this page.',
              ),
              SizedBox(height: 16),
              Text(
                '1. Accounts',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'When you create an account with us, you must provide us with information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Orders and Payments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'By placing an order through our app, you warrant that you are legally capable of entering into binding contracts. All payments are processed through a secure third-party payment gateway. We do not store your credit card details.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Termination',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Show snackbar message
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSucccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ... Your existing build method stays exactly the same
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 45),

                // Header
                AuthHeader(
                  title: AppStrings.appName,
                  subtitle: AppStrings.signinText,
                ),

                const SizedBox(height: 30),

                // Full Name Field
                CustomTextField(
                  controller: _nameController,
                  label: '',
                  hint: 'FullName',
                  textCapitalization: TextCapitalization.words,
                  validator: Validators.validateName,
                  autocorrect: false,
                  enableSuggestions: false,
                ),

                const SizedBox(height: 5),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  label: '',
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  enableSuggestions: false,
                ),

                const SizedBox(height: 5),

                // Phone Number Field
                PhoneNumberField(
                  controller: _phoneController,
                  label: '',
                  initialCountryCode: _selectedCountryCode,
                  onCountryChanged: (code) {
                    setState(() {
                      _selectedCountryCode = code;
                    });
                  },
                  validator: Validators.validatePhoneNumber,
                ),

                const SizedBox(height: 5),

                // Password Field
                CustomTextField(
                  label: '',
                  controller: _passwordController,
                  hint: 'Password',
                  isPassword: true,
                  validator: Validators.validatePassword,
                  textCapitalization: TextCapitalization.none,
                ),

                const SizedBox(height: 20),

                // Terms & Conditions Checkbox
                CustomCheckbox(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                  label: AppStrings.acceptTerms,
                  trailing: GestureDetector(
                    onTap: _showTermsAndConditions,
                    child: Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.softblue,
                    ),
                  ),
                ),

                // Newsletter Checkbox
                CustomCheckbox(
                  value: _acceptNewsletter,
                  onChanged: (value) {
                    setState(() {
                      _acceptNewsletter = value;
                    });
                  },
                  label: AppStrings.acceptNews,
                ),

                const SizedBox(height: 24),

                // Sign Up Button
                CustomButton(
                  text: AppStrings.signup,
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 25),

                // OR Divider
                DividerWithText(text: 'OR'),

                const SizedBox(height: 25),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      imagePath: AppImages.appleIcon,
                      onTap: () => _handleSocialRegister('Apple'),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(width: 16),
                    SocialLoginButton(
                      imagePath: AppImages.facebookIcon,

                      onTap: () => _handleSocialRegister('Facebook'),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(width: 16),
                    SocialLoginButton(
                      imagePath: AppImages.googleIcon,
                      onTap: () => _handleSocialRegister('Google'),
                      enabled: !_isLoading,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: Text(
                        AppStrings.sigin,
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
