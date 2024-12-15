import 'package:built_your_pc/pages/admin/admin_add_menu.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/components/line_chart.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Color> gradientColors = [
    const Color.fromARGB(255, 2, 109, 46),
    const Color.fromARGB(255, 1, 202, 1),
  ];

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CostumText(
          data: "Admin Panel",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/adminKatalog'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 5, 14, 5),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/adminKatalog'),
                    child: CostumText(
                      data: "Katalog Barang >>",
                      size: 14,
                    ),
                  ),
                ),
                ContentContainer(
                  child: Row(
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
                      )
                    ],
                  ),
                ),
                ContentContainer(
                  child: Row(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CostumText(
                              data: "CPU-EVO7-17304",
                              size: 12,
                            ),
                            CostumText(
                              data: "Intel evo Core-i7 12700H",
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
                      )
                    ],
                  ),
                ),
                ContentContainer(
                  child: Row(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CostumText(
                              data: "CPU-EVO5-11404",
                              size: 12,
                            ),
                            CostumText(
                              data: "Intel evo Core-i5 13700H",
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AdminAddMenuPage(),
                    ),
                  ),
                  child: CostumText(
                    data: " + Tambah Produk ",
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 5, 14, 5),
            child: CostumText(
              data: "Laporan Penjualan >> ",
              size: 14,
            ),
          ),
          ContentContainer(
            child: LineChartSample2(),
          ),
        ],
      ),
    );
  }
}
