import 'package:built_your_pc/pages/login.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../services/auth_provider.dart';
import 'saved_location.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/img/hq720.jpg"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: ,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hello, ${supabase.auth.currentSession!.user.userMetadata!['displayName']}",
                              style: const TextStyle(
                                fontFamily: "Poppins-regular",
                                fontSize: 16,
                                color: Color.fromARGB(255, 27, 27, 27),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: MyButton(
                          width: 400,
                          height: 30,
                          color: Colors.white,
                          elevation: 0,
                          onTap: () => widget.pageController.jumpToPage(1),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CostumText(
                                  data: 'History',
                                  size: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.history,
                                    color: Color.fromARGB(255, 54, 54, 54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SaveLocationPage()));
                          },
                          style: ButtonStyle(
                            overlayColor: const WidgetStatePropertyAll(
                                Color.fromARGB(255, 230, 230, 230)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 255, 255, 255)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CostumText(
                                  data: 'Saved Location',
                                  size: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.pin_drop_rounded,
                                    color: Color.fromARGB(255, 54, 54, 54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: MyButton(
                          width: 400,
                          height: 30,
                          color: Colors.white,
                          elevation: 0,
                          onTap: () {
                            auth.signOut();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CostumText(
                                  data: 'Log Out',
                                  color: Color.fromARGB(255, 238, 36, 36),
                                  size: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: Color.fromARGB(255, 238, 36, 36),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
