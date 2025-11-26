import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grabby_app/core/constant/app_colors.dart';

/// Custom text field widget that follows app design system
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// Controls password visibility
  bool _obscureText = true;

  /// Build suffix icon based on field type
  Widget? _buildSuffixIcon() {
    // If it's a password field, show visibility toggle
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textSecondary,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    // Otherwise, show custom suffix icon if provided
    return widget.suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        // Text Field
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          textCapitalization: widget.textCapitalization,
          autocorrect: widget.autocorrect,
          enableSuggestions: widget.enableSuggestions,

          // Text style with proper height
          style: TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
            height: 1.2,
          ),

          // Cursor properties
          cursorHeight: 20,
          cursorColor: AppColors.primary,

          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
              height: 1.2,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffixIcon(), // ← FIXED: Uses method now
            filled: true,
            fillColor: Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textWhite, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
            isDense: true,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
