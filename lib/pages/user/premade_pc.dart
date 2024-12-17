import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class PremadePCPage extends StatefulWidget {
  const PremadePCPage({super.key});

  @override
  State<PremadePCPage> createState() => _PremadePCPageState();
}

class _PremadePCPageState extends State<PremadePCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: appbarcolor,
        automaticallyImplyLeading: false,
        title: CostumText(
          data: "We made something perfect for you",
          color: Colors.white,
          size: 14,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CostumText(
                    data: "For gaming needs >> ",
                    size: 14,
                  ),
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: 3,
              itemBuilder: (context, index) {
                // return GestureDetector(
                //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => const ItemInformation())),
                //   child: ContentContainer(
                //       child: Padding(
                //     padding: const EdgeInsets.all(40),
                //     child: CostumText(data: "Kontem"),
                //   )),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
