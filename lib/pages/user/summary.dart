import 'package:built_your_pc/model/case_model.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/mobo_model.dart';
import 'package:built_your_pc/model/pc_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/payment.dart';
import 'package:built_your_pc/pages/user/transaction.dart';
import 'package:built_your_pc/services/pc_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key, required this.items});
  final Map<Type, ComponentModel> items;
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final uid = Uuid();
  double _total = 0.0;
  final _name = TextEditingController();
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  @override
  void initState() {
    calculateTotal();
    super.initState();
  }

  void calculateTotal() {
    double total = 0.0;
    widget.items.forEach((type, components) {
      total += components.price;
    });
    _total = total;
  }

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PCProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff4bb543),
        onPressed: () async {
          final id = uid.v1();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentPage(
                pc: PCModel.fromMap(
                  {
                    'id': id,
                    'name': _name.text.isEmpty
                        ? widget.items.values.first.name
                        : _name.text,
                    'cpu': widget.items[CPUModel],
                    'gpu': widget.items[GPUModel],
                    'ram': widget.items[RAMModel],
                    'ssd': widget.items[SSDModel],
                    'psu': widget.items[PSUModel],
                    'case': widget.items[CaseModel],
                    'mobo': widget.items[MoboModel],
                  },
                ),
              ),
            ),
          );
          await pp.addPC(
            PCModel.fromMap(
              {
                'id': id,
                'name': _name.text.isEmpty
                    ? widget.items.values.first.name
                    : _name.text,
                'cpu': widget.items[CPUModel]!.toMap(),
                'gpu': widget.items[GPUModel]!.toMap(),
                'ram': widget.items[RAMModel]!.toMap(),
                'ssd': widget.items[SSDModel]!.toMap(),
                'psu': widget.items[PSUModel]!.toMap(),
                'case': widget.items[CaseModel]!.toMap(),
                'mobo': widget.items[MoboModel]!.toMap(),
              },
            ),
          );
        },
        foregroundColor: const Color.fromARGB(255, 224, 224, 224),
        label: SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CostumText(
                      fontFamily: 'Poppins-bold',
                      data: formatCurrency(_total.toInt().toString()),
                      color: const Color.fromARGB(255, 255, 248, 248),
                    ),
                  ),
                ),
                CostumText(
                  data: "Pay",
                  fontFamily: "Poppins-bold",
                  color: const Color.fromARGB(255, 235, 235, 235),
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        centerTitle: true,
        title: CostumText(
          data: "Summary",
          size: 14,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 14, 8, 0),
              child: CostumText(data: "The PC called as: "),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 20.0),
              child: CostumTextField(
                borderColor: const Color.fromARGB(255, 214, 214, 214),
                controller: _name,
                radius: 7,
                labelText: widget.items.values.first.name,
              ),
            ),
            ContentContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.items.entries.map(
                    (e) {
                      final comp = e.value;
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: ClipRRect(
                                  child: Image.network(
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${e.value.picUrl}",
                                    width: 90,
                                    height: 90,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CostumText(
                                        data: e.value.name,
                                        size: 13,
                                      ),
                                      CostumText(
                                        data: comp is CPUModel
                                            ? comp.graphics
                                            : comp is GPUModel
                                                ? comp.chipset
                                                : comp is CaseModel
                                                    ? comp.sidePanel
                                                    : comp is MoboModel
                                                        ? comp.socket
                                                        : comp is RAMModel
                                                            ? comp.speed
                                                            : comp is SSDModel
                                                                ? comp.capacity
                                                                : comp
                                                                        is PSUModel
                                                                    ? comp
                                                                        .wattage
                                                                    : '',
                                        size: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CostumText(
                                            data: formatCurrency(
                                                e.value.price.toString()),
                                            size: 13,
                                            color: const Color.fromARGB(
                                                255, 95, 68, 68),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: const Color.fromARGB(255, 235, 235, 236),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
