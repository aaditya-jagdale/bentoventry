import 'package:flutter/material.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool enabled;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChanged;
  
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.title,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.enabled = true,
    this.errorText,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.currentTheme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            onTap: onTap,
            onChanged: onChanged,
            enabled: enabled,
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            validator: validator,
            style: TextStyle(
              color: AppTheme.currentTheme.colorScheme.primary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              errorText: errorText,
              hintText: hint,
              hintStyle: TextStyle(
                color: AppTheme.currentTheme.colorScheme.primary.withOpacity(
                  0.5,
                ),
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: AppTheme.currentTheme.colorScheme.primary.withOpacity(
                0.2,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.currentTheme.colorScheme.tertiary,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.all(16),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: AppTheme.currentTheme.colorScheme.tertiary,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
