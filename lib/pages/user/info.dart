import 'package:built_your_pc/model/case_model.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/mobo_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoPage extends StatelessWidget {
  final ComponentModel model;
  const InfoPage({
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
                "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${model.picUrl}",
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
                            value: formatCurrency(model.price.toString())),
                      ],
                    ),
                  ),
                  if (model is CPUModel) ...[
                    ContentContainer(
                      child: Column(
                        children: [
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Core clock",
                              value: (model as CPUModel).clock),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Core count",
                              value: (model as CPUModel).count),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Boost Clock",
                              value: (model as CPUModel).boost),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Graphics",
                              value: (model as CPUModel).graphics),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "TDP",
                              value: (model as CPUModel).tdp),
                        ],
                      ),
                    )
                  ],
                  if (model is GPUModel) ...[
                    ContentContainer(
                      child: Column(
                        children: [
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Core clock",
                              value: (model as GPUModel).coreClock),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Chipset",
                              value: (model as GPUModel).chipset),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Boost Clock",
                              value: (model as GPUModel).boostClock),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "length",
                              value: (model as GPUModel).length),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "memory",
                              value: (model as GPUModel).memory),
                        ],
                      ),
                    )
                  ],
                  if (model is SSDModel) ...[
                    ContentContainer(
                      child: Column(
                        children: [
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Capacity",
                              value: (model as SSDModel).capacity),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Form factor",
                              value: (model as SSDModel).formFactor),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Interface",
                              value: (model as SSDModel).interface),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Type",
                              value: (model as SSDModel).type),
                        ],
                      ),
                    )
                  ],
                  if (model is RAMModel) ...[
                    ContentContainer(
                      child: Column(
                        children: [
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Capacity",
                              value: (model as RAMModel).capacity),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Cas Latency",
                              value: (model as RAMModel).casLatency),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "First Word Latency",
                              value: (model as RAMModel).firstWordLatency),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "speed",
                              value: (model as RAMModel).speed),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "color",
                              value: (model as RAMModel).color),
                        ],
                      ),
                    )
                  ],
                  if (model is PSUModel) ...[
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
                    )
                  ],
                  if (model is CaseModel) ...[
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
                    )
                  ],
                  if (model is MoboModel) ...[
                    ContentContainer(
                      child: Column(
                        children: [
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Max memory",
                              value: (model as MoboModel).maxMemory),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Form Factor",
                              value: (model as MoboModel).formFactor),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Socket",
                              value: (model as MoboModel).socket),
                          DetailDescription(
                              padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                              attribute: "Color",
                              value: (model as MoboModel).color),
                        ],
                      ),
                    )
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
