import 'package:built_your_pc/model/pc_model.dart';
import 'package:built_your_pc/pages/user/index.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.pc});
  final PCModel pc;
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 255, 252),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const IndexPage()));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/success.gif',
                height: 200,
                width: 200,
              ),
              const Text(
                'Payment Successfully',
                style: TextStyle(fontFamily: "Poppins-regular", fontSize: 26),
              ),
              const Text(
                'Thank you for purchasing<3',
                style: TextStyle(fontFamily: "Poppins-regular", fontSize: 17),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 251, 255, 252),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, left: 14, bottom: 8, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CostumText(
                              data: 'ID Transaksi ',
                              size: 14,
                            ),
                            CostumText(
                              data: pc.id.substring(0, 13),
                              size: 13,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, left: 14, bottom: 8, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tanggal Transaksi',
                            ),
                            Text(
                              formattedDate,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, left: 14, bottom: 8, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                            ),
                            Text(
                              (formatCurrency(
                                  (pc.totalPrice).toInt().toString())),
                              style: TextStyle(
                                fontFamily: 'Poppins-bold',
                                fontSize: 14,
                                color: Color.fromARGB(255, 44, 44, 44),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Text(
                  'tap anything to exit',
                  style: TextStyle(
                    color: Color.fromARGB(255, 212, 212, 212),
                    fontFamily: 'Poppins-regular',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
