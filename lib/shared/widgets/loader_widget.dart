import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 212, 203, 203).withOpacity(0.5),
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 200.w),
              child: const CircularProgressIndicator(
                strokeWidth: 1,
              )),
        ));
  }
}
