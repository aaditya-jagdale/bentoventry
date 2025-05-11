import 'package:flutter/material.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color color;
  const CustomProgressIndicator({super.key, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: color,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
