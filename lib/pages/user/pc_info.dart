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
                children: [
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Price",
                            value: formatCurrency((100000).toString())),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Core clock",
                            value: model.cpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Core count",
                            value: model.cpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Boost Clock",
                            value: model.cpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Graphics",
                            value: model.cpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "TDP",
                            value: model.cpu['']),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Core clock",
                            value: model.gpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Chipset",
                            value: model.gpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Boost Clock",
                            value: model.gpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "length",
                            value: model.gpu['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "memory",
                            value: model.gpu['']),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Capacity",
                            value: model.ssd['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Form factor",
                            value: model.ssd['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Interface",
                            value: model.ssd['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Type",
                            value: model.ssd['']),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Capacity",
                            value: model.ram['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Cas Latency",
                            value: model.ram['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "First Word Latency",
                            value: model.ram['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "speed",
                            value: model.ram['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "color",
                            value: model.ram['']),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Efficiency",
                            value: (model as PSUModel).efficiency),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Modular",
                            value: (model as PSUModel).modular),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Wattage",
                            value: (model as PSUModel).wattage),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Type",
                            value: (model as PSUModel).type),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Color",
                            value: (model as PSUModel).color),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Side panel",
                            value: (model as CaseModel).sidePanel),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "External Volume",
                            value: (model as CaseModel).externalVolume),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Type",
                            value: (model as CaseModel).type),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Color",
                            value: (model as CaseModel).color),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Column(
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Max memory",
                            value: model.mobo['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Form Factor",
                            value: model.mobo['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Socket",
                            value: model.mobo['']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Color",
                            value: model.mobo['']),
                      ],
                    ),
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
