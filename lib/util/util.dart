import 'package:flutter/material.dart';

class CostumText extends StatelessWidget {
  final String data;
  final Color color;
  final double size;
  final TextAlign? align;

  const CostumText({
    super.key,
    required this.data,
    this.color = Colors.black,
    this.size = 16,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: "Gotham-regular",
        fontSize: size,
        color: color,
        overflow: TextOverflow.clip,
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color overlay;
  final Color color;
  final double radius;
  final double width;
  final double height;
  final double elevation;
  final Widget child;

  const MyButton({
    super.key,
    required this.onTap,
    this.overlay = const Color.fromARGB(73, 255, 235, 59),
    this.color = const Color.fromARGB(255, 102, 102, 102),
    this.height = 100,
    this.width = 100,
    this.radius = 12,
    this.elevation = 3,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(overlay),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius))),
        fixedSize: WidgetStatePropertyAll(Size(width, height)),
        padding: const WidgetStatePropertyAll(EdgeInsets.fromLTRB(0, 0, 0, 0)),
        backgroundColor: WidgetStatePropertyAll(color),
        elevation: WidgetStatePropertyAll(elevation),
      ),
      child: child,
    );
  }
}

class CostumTextField extends StatelessWidget {
  const CostumTextField({
    super.key,
    required this.controller,
    this.borderColor = Colors.white,
    required this.radius,
    this.icon,
    required this.labelText,
    this.padding = const EdgeInsets.fromLTRB(18, 8, 18, 8),
    this.inputType = TextInputType.text,
  });
  final EdgeInsets padding;
  final TextEditingController controller;
  final Color borderColor;
  final double radius;
  final IconData? icon;
  final String labelText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        child: TextField(
          style: const TextStyle(fontFamily: "Gotham-regular"),
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
            prefixIcon: Icon(
              icon,
              color: const Color.fromARGB(255, 20, 20, 20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(radius),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(radius),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            filled: true,
            fillColor: const Color.fromARGB(255, 248, 248, 248),
          ),
        ),
      ),
    );
  }
}
