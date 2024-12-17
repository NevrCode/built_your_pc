import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/info.dart';
import 'package:built_your_pc/pages/user/summary.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CostumPcPage extends StatefulWidget {
  const CostumPcPage({super.key});

  @override
  State<CostumPcPage> createState() => _CostumPcPageState();
}

class _CostumPcPageState extends State<CostumPcPage> {
  final List<Type> componentTypes = [
    CPUModel,
    GPUModel,
    RAMModel,
    PSUModel,
    SSDModel,
  ];
  int currentTypeIndex = 0;
  final Map<Type, ComponentModel> selectedComponents = {};
  double _total = 0;
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  void calculateTotal() {
    _total = 0;
    double total = 0.0;
    selectedComponents.forEach((type, components) {
      total += components.price;
    });
    _total = total;
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<ComponentProvider>(context, listen: false);

    final currentType = componentTypes[currentTypeIndex];
    final filteredItems = cp.components
        .whereType<ComponentModel>()
        .where((e) => e.runtimeType == currentType)
        .toList();

    return Scaffold(
      backgroundColor: bg,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        onPressed: () {
          setState(() {
            currentTypeIndex = (currentTypeIndex + 1) % componentTypes.length;
          });
        },
        foregroundColor: Colors.white,
        label: SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showSelectionsBottomSheet(context),
                  child: SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CostumText(
                        data: formatCurrency(_total.toInt().toString()),
                        color: const Color.fromARGB(255, 104, 104, 104),
                      ),
                    ),
                  ),
                ),
                CostumText(
                  data: "Next >",
                  color: const Color.fromARGB(255, 18, 201, 18),
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title: CostumText(
          data: "Let's make your dream PC",
          color: const Color.fromARGB(255, 75, 75, 75),
          size: 14,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContentContainer(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CostumText(
                  data:
                      "Pick a ${currentType.toString().replaceAll('Model', '').toUpperCase()}!",
                ),
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final isSelected = selectedComponents[currentType] == item;

                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InfoPage(model: item))),
                  onDoubleTap: () {
                    setState(() {
                      selectedComponents[currentType] = item;
                      calculateTotal();
                    });
                  },
                  child: ContentContainer(
                    color: isSelected
                        ? const Color.fromARGB(255, 44, 207, 44)
                        : contentBg,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                child: ClipRRect(
                                  child: Image.network(
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${item.picUrl}",
                                    height: 140,
                                    width: 140,
                                  ),
                                ),
                              ),
                              CostumText(
                                data: item.name,
                                size: 14,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CostumText(
                                  data: formatCurrency(item.price.toString()),
                                  size: 14,
                                  color:
                                      const Color.fromARGB(255, 163, 163, 163),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }

  void showSelectionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return selectedComponents.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    color: bg, borderRadius: BorderRadius.circular(12)),
                height: 500,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const CostumText(
                            data: "Cart",
                            size: 18,
                            color: Color.fromARGB(255, 49, 49, 49),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...selectedComponents.entries.map((entry) {
                          final typeName =
                              entry.key.toString().replaceAll('Model', '');
                          final item = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CostumText(
                                data: "$typeName : ${item.name}",
                                color: const Color.fromARGB(255, 41, 41, 43),
                              ),
                              CostumText(
                                  data: formatCurrency(item.price.toString())),
                              Divider()
                            ],
                          );
                        }),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              height: 40,
                              elevation: 0,
                              color: bg,
                              onTap: () {
                                Navigator.of(context)
                                    .pop(); // Close the bottom sheet
                              },
                              child: const CostumText(data: "Close"),
                            ),
                            MyButton(
                              height: 50,
                              width: 230,
                              elevation: 0,
                              color: const Color.fromARGB(255, 28, 224, 10),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SummaryPage())); // Close the bottom sheet
                              },
                              child: const CostumText(
                                data: "Summary",
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              )
            : Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const CostumText(
                        data: "No selections made yet.",
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
