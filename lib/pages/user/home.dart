import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/costum_pc.dart';
import 'package:built_your_pc/pages/user/premade_pc.dart';
import 'package:built_your_pc/pages/user/profile.dart';
import 'package:built_your_pc/services/pc_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<String> imgList = [
  'assets/img/octofest.png',
  'assets/img/2.png',
  'assets/img/3.png',
  'assets/img/10per.png',
];
final List<Widget> imageSliders = imgList
    .map((item) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
          ],
        )))
    .toList();

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<PCProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              aspectRatio: 1.5,
              enlargeCenterPage: true,
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: contentBg,
                      border: Border.all(color: homeBorder),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                          child: CostumText(
                            data:
                                "Welcome back, ${supabase.auth.currentUser!.userMetadata!['displayName']}",
                            color: const Color.fromARGB(255, 65, 65, 65),
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 16, 8),
                  child: GestureDetector(
                    onTap: () => widget.pageController.jumpToPage(2),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: contentBg,
                        border: Border.all(color: homeBorder),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                        child: Icon(
                          Icons.person,
                          color: const Color.fromARGB(255, 22, 22, 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CostumPcPage())),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 251, 252, 255),
                          border: Border.all(color: buttonColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                "assets/img/costum.png",
                                width: double.infinity,
                                color: const Color.fromARGB(255, 51, 139, 221),
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: CostumText(
                                data: "Make Custom",
                                color: Color.fromARGB(255, 51, 139, 221),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PremadePCPage())),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: contentBg,
                          border: Border.all(color: green),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                "assets/img/premade.png",
                                width: double.infinity,
                                color: green,
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: CostumText(
                                data: "Get Pre-made",
                                color: green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PremadePCPage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CostumText(
                    data: "Recomended for Gaming ",
                    size: 14,
                  ),
                  CostumText(
                    data: "More >>",
                    size: 12,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PremadePCPage())),
              child: FutureBuilder(
                future: pc.fetchPC(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 53, 48, 48),
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error loading PCs'));
                  }
                  final item = pc.pcList;
                  return item.isEmpty
                      ? Center(child: Text('No PCs available'))
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final i = item[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: contentBg,
                                  border: Border.all(color: bg),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        child: Image.network(
                                          "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${i.pcCase['pic_url']}",
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Divider(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14, 4, 14, 5),
                                      child: CostumText(
                                        data: i.name,
                                        size: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
