import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

import '../../util/app_color.dart';

class AdminCatalogPage extends StatefulWidget {
  const AdminCatalogPage({super.key});

  @override
  State<AdminCatalogPage> createState() => _AdminCatalogPageState();
}

class _AdminCatalogPageState extends State<AdminCatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CostumText(
          data: "Admin Katalog",
          size: 15,
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: contentBg,
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12)),
                          child: Image.asset(
                            "assets/img/logo_app.png",
                            // width: double.infinity,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CostumText(
                                data: "CPU-AMD5-17404",
                                size: 12,
                              ),
                              CostumText(
                                data: "AMD Ryzen 5 5600G",
                                size: 12,
                              ),
                              CostumText(
                                data: "Stok : 10",
                                size: 12,
                                color: 3 < 10
                                    ? Colors.red
                                    : const Color.fromARGB(255, 36, 36, 36),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 249, 239),
                        border: Border.all(
                            color: const Color.fromARGB(255, 231, 211, 33)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 255, 238, 7),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: InkWell(
                      onTap: () => _showDeleteConfirmationDialog(context),
                      child: Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 239, 239),
                            border: Border.all(
                                color: const Color.fromARGB(255, 226, 15, 0)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(
                          Icons.delete,
                          color: const Color.fromARGB(255, 255, 7, 7),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CostumText(data: "Confirm Delete"),
          content: CostumText(
            data: "Are you sure you want to delete this item?",
            size: 14,
          ),
          actions: [
            TextButton(
              // style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(bg)),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: CostumText(data: "Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform delete action here
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
