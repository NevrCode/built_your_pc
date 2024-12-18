import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const ContentContainer(
      {super.key, required this.child, this.color = contentBg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: contentBg,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
