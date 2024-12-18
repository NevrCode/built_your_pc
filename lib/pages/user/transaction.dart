import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/order_detail.dart';
import 'package:built_your_pc/services/order_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: order.fetchOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                );
              }
              if (snapshot.hasError) {
                return CostumText(data: "Error");
              }
              final items = order.orders;
              return ListView.builder(
                itemCount: items.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderDetailPage(
                                  model: item.pc,
                                )));
                      },
                      child: Column(
                        children: [
                          ContentContainer(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 15, 15),
                                      child: Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color: item.status == "Diproses"
                                              ? const Color.fromARGB(
                                                  255, 255, 239, 150)
                                              : const Color.fromARGB(
                                                  255, 108, 231, 129),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              14, 8, 14, 8),
                                          child: Center(
                                              child: CostumText(
                                            data: item.status,
                                            color: const Color.fromARGB(
                                                255, 31, 31, 31),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CostumText(
                                            data: item.id.substring(0, 22),
                                            color: const Color.fromARGB(
                                                255, 37, 37, 37),
                                            align: TextAlign.end,
                                            size: 14,
                                          ),
                                          CostumText(
                                            data: item.loc.kabupatenOrKota
                                                .toString(),
                                            color: const Color.fromARGB(
                                                255, 116, 116, 116),
                                            align: TextAlign.end,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "Price",
                                    value: formatCurrency((item.pc.totalPrice)
                                        .toInt()
                                        .toString())),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "Case Side Panel",
                                    value: item.pc.pcCase['side_panel']),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "Motherboard Socket",
                                    value: item.pc.mobo['socket']),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "CPU Graphics",
                                    value: item.pc.cpu['graphics']),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "GPU Chipset",
                                    value: item.pc.gpu['chipset']),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "SSD Capacity",
                                    value: item.pc.ssd['capacity']),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "RAM Capacity",
                                    value: item.pc.ram['capacity']),
                                DetailDescription(
                                    padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                                    attribute: "PSU Wattage",
                                    value: item.pc.psu['wattage']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
