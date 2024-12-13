import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/costum_pc.dart';
import 'package:built_your_pc/pages/user/premade_pc.dart';
import 'package:built_your_pc/pages/user/profile.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/img/octofest.png',
  'assets/img/pc-set.jpg',
  'assets/img/pc-setup.jpg',
  'assets/img/pcsetup2.jpg',
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            viewportFraction: 1.1,
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
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage())),
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
        Flexible(
          flex: 1,
          child: Padding(
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
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PremadePCPage())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CostumText(
                  data: "Recomended for Gaming >>",
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ContentContainer(
              child: Column(
            children: [],
          )),
        )),
      ],
    );
  }
}
