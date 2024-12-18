import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/pages/admin/admin_add_menu.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/components/line_chart.dart';
import 'package:built_your_pc/pages/login.dart';
import 'package:built_your_pc/services/component_provider.dart';


import 'package:built_your_pc/services/pref.dart';
import 'package:built_your_pc/util/app_color.dart';

import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  final PageController pageController;
  const AdminHomePage({super.key, required this.pageController});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Color> gradientColors = [
    const Color.fromARGB(255, 2, 109, 46),
    const Color.fromARGB(255, 1, 202, 1),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ComponentProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => widget.pageController.jumpToPage(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 5, 14, 5),
                  child: GestureDetector(
                    onTap: () => widget.pageController.jumpTo(2),
                    child: CostumText(
                      data: "Katalog Barang >>",
                      size: 14,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: pc.fetchComponents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: const Color.fromARGB(255, 90, 122, 226),
                      ));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error loading PCs'));
                    }
                    final items = pc.filtered;
                    items.sort((a, b) => a.stock.compareTo(b.stock));
                    return items.isEmpty
                        ? Center(child: Text('No PCs available'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return ContentContainer(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                        child: Image.network(
                                          "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${item.picUrl}",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                  },
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
          Center(
            child: MyButton(
                elevation: 0,
                color: bg,
                height: 50,
                onTap: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                  await supabase.auth.signOut();
                  await PrefService().clearSession();
                },
                child: CostumText(
                  data: "Log out",
                  color: Colors.red,
                )),
          )
        ],
      ),
    );
  }
}
