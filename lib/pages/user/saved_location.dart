// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/add_location.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/location_provider.dart';
import '../../util/util.dart';

class SaveLocationPage extends StatefulWidget {
  const SaveLocationPage({super.key});

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState extends State<SaveLocationPage> {
  @override
  Widget build(BuildContext context) {
    final alamat =
        Provider.of<LocationProvider>(context, listen: false).locations;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 224, 248),
        title: CostumText(data: "Saved Location"),
      ),
      body: Column(
        children: [
          ContentContainer(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: alamat.length,
              itemBuilder: (context, index) {
                final a = alamat[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: const Color.fromARGB(255, 221, 221, 221),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: CostumText(
                                data: a.locationName!,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                        child: CostumText(
                          data:
                              "jl.${a.streetName} RT ${a.rtNumber}/RW ${a.rwNumber} no.${a.streetNumber}, ${a.kecamatan}, ${a.kabupatenOrKota}",
                          size: 14,
                          color: const Color.fromARGB(255, 151, 151, 151),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 8, 0),
            child: MyButton(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AddLocationPage(),
                  ),
                );
              },
              width: 200,
              height: 40,
              elevation: 0,
              color: primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.add,
                      color: const Color.fromARGB(255, 247, 247, 247),
                    ),
                    CostumText(
                      data: "tambah lokasi",
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
