import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class ItemInformation extends StatelessWidget {
  const ItemInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        automaticallyImplyLeading: false,
        title: CostumText(data: "Detail Case"),
      ),
      body: Column(
        children: [
          ClipRRect(
            child: Image.asset(
              "assets/img/logo_app.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ContentContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CostumText(data: "Casing Mantap Poll"),
                  ),
                ),
                ContentContainer(
                    child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "attribute",
                            value: "value");
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
