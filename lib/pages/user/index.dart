import 'package:built_your_pc/pages/user/home.dart';
import 'package:built_your_pc/pages/user/profile.dart';
import 'package:built_your_pc/pages/user/transaction.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({
    super.key,
  });

  @override
  State<IndexPage> createState() => _IndexPageState();
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_rounded),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.list_alt),
    activeIcon: Icon(Icons.list_alt_outlined),
    label: 'Transactions',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
  ),
];

class _IndexPageState extends State<IndexPage> {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  late PageController pageController;
  set tabIndex(int v) {
    setState(() {
      _tabIndex = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    pageController = PageController(initialPage: 0);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbarcolor,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Center(
            child: Column(
              children: [
                Text(
                  _tabIndex == 0
                      ? "Build Your PC"
                      : _tabIndex == 1
                          ? "Transaction"
                          : "Profile",
                  style: const TextStyle(
                      fontFamily: 'Poppins-bold', fontSize: 16, color: text),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Color.fromARGB(255, 248, 248, 248),
                  height: 0.2,
                  indent: 155,
                  endIndent: 155,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        elevation: 0.2,
        iconSize: 27,
        selectedLabelStyle: const TextStyle(fontFamily: 'poppins-bold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'poppins-regular'),
        backgroundColor: appbarcolor,
        selectedItemColor: text,
        unselectedItemColor: const Color.fromARGB(255, 114, 114, 114),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: _navBarItems,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          setState(() {
            tabIndex = v;
          });
        },
        children: const [
          HomePage(),
          TransactionPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}


// Recommended for you


