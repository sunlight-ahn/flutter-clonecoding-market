import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final EdgeInsets padding;
  final Color color;
  //const Btn({super.key});
  const Btn({
    super.key,
    required this.child,
    required this.onTap,
    this.color = const Color(0xffED7738),
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () {},
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: padding,
          color: color,
          child: child,
        ),
      ),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(7),
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(vertical: 15),
      //     color: const Color(0xffED7738),
      //     child: child,
      //     // child: const AppFont(
      //     //   '시작하기',
      //     //   align: TextAlign.center,
      //     //   size: 18,
      //     //   fontWeight: FontWeight.bold,
      //     // ),
      //   ),
      // ),
    );
  }
}
