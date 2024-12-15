// import 'package:flutter/material.dart';
// class SearchBox extends StatefulWidget {
//   const SearchBox({super.key});

//   @override
//   State<SearchBox> createState() => _SearchBoxState();
// }
// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class _SearchBoxState extends State<SearchBox> {
//   const _SearchBoxState({
//     super.key,
//     required this.controller,
//     this.borderColor = const Color.fromARGB(255, 170, 170, 170),
//     required this.radius,
//     this.suffixText,
//     this.icon,
//     required this.labelText,
//     this.padding = const EdgeInsets.fromLTRB(8, 8, 8, 8),
//     this.inputType = TextInputType.text,
//   });
//   final EdgeInsets padding;
//   final String? suffixText;
//   final TextEditingController controller;
//   final Color borderColor;
//   final double radius;
//   final IconData? icon;
//   final String labelText;
//   final TextInputType inputType;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: SizedBox(
//         child: TextField(
//           style: const TextStyle(fontFamily: "Poppins-regular"),
//           controller: controller,
//           keyboardType: inputType,
//           decoration: InputDecoration(
//             labelText: labelText,
//             labelStyle: const TextStyle(
//                 color: Color.fromARGB(255, 75, 75, 75),
//                 fontFamily: 'Poppins-regular',
//                 fontSize: 14),
//             enabledBorder: OutlineInputBorder(
//               borderSide:
//                   const BorderSide(color: Color.fromARGB(255, 179, 177, 177)),
//               borderRadius: BorderRadius.circular(radius),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: borderColor),
//               borderRadius: BorderRadius.circular(radius),
//             ),
//             border: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.white),
//               borderRadius: BorderRadius.circular(radius),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//             suffixIcon: Align(
//               heightFactor: 1,
//               widthFactor: 1,
//               child: CostumText(
//                 data: suffixText ?? "",
//                 size: 15,
//               ),
//             ),
//             // suffixText: suffixText ?? "",
//             filled: true,
//             fillColor: const Color.fromARGB(255, 247, 247, 247),
//           ),
//         ),
//       ),
//     );
//   }
// }
