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
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PcInfo extends StatelessWidget {
  final PCModel model;
  const PcInfo({
    super.key,
    required this.model,
  });
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: CostumText(data: model.name),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff4bb543),
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentPage(pc: model),
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
                      data:
                          formatCurrency((model.totalPrice).toInt().toString()),
                      color: const Color.fromARGB(255, 255, 248, 248),
                    ),
                  ),
                ),
                CostumText(
                  data: "Buy",
                  fontFamily: "Poppins-bold",
                  color: const Color.fromARGB(255, 235, 235, 235),
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              child: Image.network(
                "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${model.pcCase['pic_url']}",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Price",
                            value: formatCurrency(
                                (model.totalPrice).toInt().toString())),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: CostumText(
                      data: "Case",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 265,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Side panel",
                            value: model.pcCase['side_panel']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "External Volume",
                            value: model.pcCase['external_volume']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Type",
                            value: model.pcCase['type']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Color",
                            value: model.pcCase['color']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: CostumText(
                      data: "Motherboard",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 260,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Max memory",
                            value: model.mobo['max_memory']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Form Factor",
                            value: model.mobo['form_factor']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Socket",
                            value: model.mobo['socket']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Color",
                            value: model.mobo['color']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: CostumText(
                      data: "CPU",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 35,
                    endIndent: 275,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Core clock",
                            value: model.cpu['core_clock']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Core count",
                            value: model.cpu['core_count']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Boost Clock",
                            value: model.cpu['boost_clock']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Graphics",
                            value: model.cpu['graphics']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "TDP",
                            value: model.cpu['tdp']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: CostumText(
                      data: "GPU",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 275,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Core clock",
                            value: model.gpu['core_clock']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Chipset",
                            value: model.gpu['chipset']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Boost Clock",
                            value: model.gpu['boost_clock']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "length",
                            value: model.gpu['length']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "memory",
                            value: model.gpu['memory']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: CostumText(
                      data: "SSD",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 275,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Capacity",
                            value: model.ssd['capacity']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Form factor",
                            value: model.ssd['form_factor']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Interface",
                            value: model.ssd['interface']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Type",
                            value: model.ssd['type']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: CostumText(
                      data: "RAM",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 275,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Capacity",
                            value: model.ram['capacity']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Cas Latency",
                            value: model.ram['cas_latency']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "First Word Latency",
                            value: model.ram['first_word_latency']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "speed",
                            value: model.ram['speed']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "color",
                            value: model.ram['color']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: CostumText(
                      data: "PSU",
                      size: 15,
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 275,
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Efficiency",
                            value: model.psu['efficiency']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Modular",
                            value: model.psu['modular']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Wattage",
                            value: model.psu['wattage']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Type",
                            value: model.psu['type']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Color",
                            value: model.psu['color']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
