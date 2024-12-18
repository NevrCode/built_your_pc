import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/pc_info.dart';
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
        centerTitle: true,
        title: CostumText(
          data: "For You Page",
          color: const Color.fromARGB(255, 43, 43, 43),
          size: 16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const PcInfo(model: ,))),
                  child: ContentContainer(
                      child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: CostumText(data: "Kontem"),
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
