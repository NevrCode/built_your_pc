import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:built_your_pc/pages/admin/edit/edit_cpu.dart';
import 'package:built_your_pc/pages/admin/edit/edit_gpu.dart';
import 'package:built_your_pc/pages/admin/edit/edit_psu.dart';
import 'package:built_your_pc/pages/admin/edit/edit_ram.dart';
import 'package:built_your_pc/pages/admin/edit/edit_ssd.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/app_color.dart';

class AdminCatalogPage extends StatefulWidget {
  const AdminCatalogPage({super.key});

  @override
  State<AdminCatalogPage> createState() => _AdminCatalogPageState();
}

class _AdminCatalogPageState extends State<AdminCatalogPage> {
  String? query;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ComponentProvider>(context);
    final items = cp.filtered;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(fontFamily: "Poppins-regular"),
                    controller: controller,
                    onChanged: (value) => cp.filterItems(value),
                    decoration: InputDecoration(
                      labelText: "Search",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 75, 75, 75),
                          fontFamily: 'Poppins-regular',
                          fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 117, 117, 117)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 148, 148, 148)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 179, 179, 179)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                ),
              ),
              items.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                          child: Container(
                            width: 360,
                            decoration: BoxDecoration(
                              color: contentBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => item is CPUModel
                                        ? EditCPUPage(cm: item)
                                        : item is GPUModel
                                            ? EditGPUPage(gm: item)
                                            : item is RAMModel
                                                ? EditRAMPage(rm: item)
                                                : item is PSUModel
                                                    ? EditPSUPage(pm: item)
                                                    : EditSSDPage(
                                                        sm: item is SSDModel
                                                            ? item
                                                            : null),
                                  )),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                        child: Image.network(
                                          "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${item.picUrl}",
                                          // width: double.infinity,
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CostumText(
                                              data: item.id,
                                              size: 12,
                                            ),
                                            SizedBox(
                                              width: 174,
                                              child: CostumText(
                                                data: item.name,
                                                size: 12,
                                              ),
                                            ),
                                            CostumText(
                                              data: "Stok : ${item.stock}",
                                              size: 12,
                                              color: item.stock < 10
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                      255, 36, 36, 36),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          _showDeleteConfirmationDialog(
                                              context, item),
                                      child: SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: const Color.fromARGB(
                                                255, 255, 7, 7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, ComponentModel cm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final cp = Provider.of<ComponentProvider>(context, listen: false);
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CostumText(data: "Confirm Delete"),
          content: CostumText(
            data: "Are you sure you want to delete this item?",
            size: 14,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CostumText(data: "Cancel"),
            ),
            TextButton(
              onPressed: () {
                cp.deleteComponent(cm);
                Navigator.of(context).pop(); // Close the dialog
                _showSnackBar(context, "Item deleted successfully.");
              },
              child: CostumText(
                data: "Delete",
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
