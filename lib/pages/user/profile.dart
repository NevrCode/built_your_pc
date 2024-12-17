import 'package:built_your_pc/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../services/auth_provider.dart';
import 'saved_location.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
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
                                fontFamily: "Gotham-regular",
                                fontSize: 20,
                                color: Color.fromARGB(255, 37, 37, 37),
                              ),
                            ),
                            const Icon(
                              Icons.history,
                              size: 30,
                              color: Color.fromARGB(255, 102, 102, 102),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SaveLocationPage()));
                          },
                          style: ButtonStyle(
                            overlayColor: const WidgetStatePropertyAll(
                                Color.fromARGB(255, 230, 230, 230)),
                            shape: const WidgetStatePropertyAll(LinearBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 92, 92, 92),
                              ),
                              bottom: LinearBorderEdge(),
                            )
                                // RoundedRectangleBorder(
                                //   side:
                                //   const BorderSide(
                                //       color: Color.fromARGB(255, 172, 172, 172)),
                                //   borderRadius: BorderRadius.circular(3),
                                // ),
                                ),
                            // fixedSize: WidgetStateProperty.all(const Size(320, 52)),

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
                                Text(
                                  'Saved Location',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontFamily: 'Gotham-Bold'),
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ElevatedButton(
                          onPressed: () {
                            auth.signOut();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          style: ButtonStyle(
                            surfaceTintColor: const WidgetStatePropertyAll(
                                Color.fromARGB(255, 179, 179, 179)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(7))),
                            // fixedSize: WidgetStateProperty.all(const Size(320, 52)),

                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 255, 245, 245)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontFamily: 'Gotham-Bold'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.logout,
                                    color: Color.fromARGB(255, 54, 54, 54),
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
