import 'package:built_your_pc/pages/admin/admin.dart';
import 'package:built_your_pc/pages/admin/admin_catalog.dart';
import 'package:built_your_pc/pages/admin/users_table.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';

class AdminIndex extends StatefulWidget {
  const AdminIndex({
    super.key,
  });

  @override
  State<AdminIndex> createState() => _AdminIndexState();
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_rounded),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    activeIcon: Icon(Icons.person),
    label: 'users',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    activeIcon: Icon(Icons.search),
    label: 'Katalog',
  ),
];

class _AdminIndexState extends State<AdminIndex> {
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
                      ? "Admin panel"
                      : _tabIndex == 1
                          ? "Users"
                          : "Katalog",
                  style: const TextStyle(
                      fontFamily: 'Poppins-regular', fontSize: 16, color: text),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  color: Color.fromARGB(255, 209, 209, 209),
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
        children: [
          AdminHomePage(
            pageController: pageController,
          ),
          UsersTablePage(),
          AdminCatalogPage(),
        ],
      ),
    );
  }

  Future<bool?> showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Exit"),
          content: const Text("Are you sure you want to leave this page?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Stay on the page
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Exit the page
              },
              child: const Text("Exit"),
            ),
          ],
        );
      },
    );
  }
}


// Recommended for you


