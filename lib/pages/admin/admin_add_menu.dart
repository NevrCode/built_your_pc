import 'package:built_your_pc/pages/admin/add/add_case.dart';
import 'package:built_your_pc/pages/admin/add/add_cpu.dart';
import 'package:built_your_pc/pages/admin/add/add_gpu.dart';
import 'package:built_your_pc/pages/admin/add/add_mobo.dart';
import 'package:built_your_pc/pages/admin/add/add_psu.dart';
import 'package:built_your_pc/pages/admin/add/add_ram.dart';
import 'package:built_your_pc/pages/admin/add/add_ssd.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class AdminAddMenuPage extends StatefulWidget {
  const AdminAddMenuPage({super.key});

  @override
  State<AdminAddMenuPage> createState() => _AdminAddMenuPageState();
}

class _AdminAddMenuPageState extends State<AdminAddMenuPage> {
  List<String> types = ["cpu", "gpu", "ram", "ssd", "psu", "case", "mobo"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: CostumText(data: "Pilih jenis produk", size: 14),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: types.length,
            itemBuilder: (context, index) {
              final type = types[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => type == "cpu"
                          ? AddCPUPage()
                          : type == "gpu"
                              ? AddGPUPage()
                              : type == "ram"
                                  ? AddRAMPage()
                                  : type == "ssd"
                                      ? AddSSDPage()
                                      : type == "mobo"
                                          ? AddMoboPage()
                                          : type == "case"
                                              ? AddCasePage()
                                              : AddPSUPage(),
                    ),
                  ),
                  child: ContentContainer(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 14, 20, 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CostumText(
                          data: types[index].toUpperCase(),
                          size: 14,
                        ),
                        CostumText(data: ">")
                      ],
                    ),
                  )),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
