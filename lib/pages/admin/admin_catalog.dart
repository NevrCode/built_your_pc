import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

import '../../util/app_color.dart';

class AdminCatalogPage extends StatefulWidget {
  const AdminCatalogPage({super.key});

  @override
  State<AdminCatalogPage> createState() => _AdminCatalogPageState();
}

class _AdminCatalogPageState extends State<AdminCatalogPage> {
  List<ComponentModel> _filteredItems = [];
  String? query;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _filterItems(String query, ComponentProvider cp) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = cp.components;
      });
    } else {
      setState(() {
        _filteredItems = cp.components
            .where((item) => item.name
                .toLowerCase()
                .contains(query.toLowerCase())) // Case-insensitive search
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ComponentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: const Color.fromARGB(255, 250, 250, 255),
        title: CostumText(
          data: "Admin Katalog",
          size: 15,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: SizedBox(
                    child: TextField(
                      style: const TextStyle(fontFamily: "Poppins-regular"),
                      controller: controller,
                      onChanged: (value) => _filterItems(value, cp),
                      decoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 75, 75, 75),
                            fontFamily: 'Poppins-regular',
                            fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 179, 177, 177)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: bg),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 247, 247, 247),
                      ),
                    ),
                  ),
                ),
                _filteredItems.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = cp.components[index];
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: contentBg,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: ClipRRect(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CostumText(
                                                data: item.id,
                                                size: 12,
                                              ),
                                              CostumText(
                                                data: item.name,
                                                size: 12,
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
                                        color: const Color.fromARGB(
                                            255, 250, 249, 239),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 231, 211, 33)),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Icon(
                                      Icons.edit,
                                      color: const Color.fromARGB(
                                          255, 255, 238, 7),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: InkWell(
                                      onTap: () =>
                                          _showDeleteConfirmationDialog(
                                              context),
                                      child: Container(
                                        width: 70,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 250, 239, 239),
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 226, 15, 0)),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Icon(
                                          Icons.delete,
                                          color: const Color.fromARGB(
                                              255, 255, 7, 7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      )
                    : Center(
                        child: CostumText(data: "Data tidak Ada"),
                      ),
              ],
            ),
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
