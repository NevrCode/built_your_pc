import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';

class DetailDescription extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String attribute;
  final String value;
  final double size;
  const DetailDescription({
    super.key,
    required this.attribute,
    required this.value,
    this.padding,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CostumText(
              data: attribute,
              size: size,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Flexible(
            child: CostumText(
              data: value,
              size: size,
              color: const Color.fromARGB(255, 0, 0, 0),
              align: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class CostumText extends StatelessWidget {
  final String data;
  final Color color;
  final double size;
  final TextAlign? align;
  final String? fontFamily;

  const CostumText({
    super.key,
    required this.data,
    this.color = const Color.fromARGB(255, 36, 36, 36),
    this.size = 16,
    this.align,
    this.fontFamily = "Poppins-regular",
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: fontFamily,
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
    this.overlay = const Color.fromARGB(72, 106, 158, 218),
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
    this.borderColor = const Color.fromARGB(255, 170, 170, 170),
    required this.radius,
    this.suffixText,
    this.icon,
    required this.labelText,
    this.padding = const EdgeInsets.fromLTRB(8, 8, 8, 8),
    this.inputType = TextInputType.text,
  });

  final EdgeInsets padding;
  final String? suffixText;
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
          style: const TextStyle(fontFamily: "Poppins-regular"),
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 75, 75, 75),
              fontFamily: 'Poppins-regular',
              fontSize: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 179, 177, 177)),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Align(
              heightFactor: 1,
              widthFactor: 1,
              child: CostumText(
                data: suffixText ?? "",
                size: 15,
              ),
            ),
            // suffixText: suffixText ?? "",
            filled: true,
            fillColor: const Color.fromARGB(255, 247, 247, 247),
          ),
        ),
      ),
    );
  }
}
