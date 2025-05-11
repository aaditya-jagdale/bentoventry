import 'package:flutter/material.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool errorText;
  final Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    this.hint,
    required this.controller,
    this.prefixIcon,
    this.errorText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          focusColor: AppTheme.currentTheme.colorScheme.secondary.withOpacity(
            0.2,
          ),
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hint,
            filled: true,
            fillColor: AppTheme.currentTheme.colorScheme.secondary.withOpacity(
              0.2,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            hintStyle: TextStyle(
              color:
                  errorText
                      ? AppTheme.currentTheme.colorScheme.error
                      : AppTheme.currentTheme.colorScheme.tertiary,
              fontWeight: FontWeight.normal,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color:
                    errorText
                        ? AppTheme.currentTheme.colorScheme.error
                        : AppTheme.currentTheme.colorScheme.primary,
              ),
            ),
          ),
          dropdownColor: AppTheme.currentTheme.colorScheme.primary,

          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item.toLowerCase(),
                  child: Text(item),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
