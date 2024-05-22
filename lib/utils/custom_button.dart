import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final double height;
  final double width;
  final double cornerRadius;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    required this.cornerRadius,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
