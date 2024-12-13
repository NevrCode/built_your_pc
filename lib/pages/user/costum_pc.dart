import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/item_information.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class CostumPcPage extends StatefulWidget {
  const CostumPcPage({super.key});

  @override
  State<CostumPcPage> createState() => _CostumPcPageState();
}

class _CostumPcPageState extends State<CostumPcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: appbarcolor,
        automaticallyImplyLeading: false,
        title: CostumText(
          data: "Let's make your dream PC",
          color: Colors.white,
          size: 14,
        ),
      ),
      body: Column(
        children: [
          ContentContainer(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CostumText(data: "First, pick a case !"),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ItemInformation())),
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
    );
  }
}
