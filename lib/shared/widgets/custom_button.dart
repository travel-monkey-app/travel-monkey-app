import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.buttonStyle,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 70.w),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: Text(text ?? '', style: textStyle),
      ),
    );
  }
}
