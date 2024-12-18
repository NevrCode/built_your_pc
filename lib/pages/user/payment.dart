import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/order_model.dart';
import 'package:built_your_pc/model/pc_model.dart';
import 'package:built_your_pc/pages/user/add_location.dart';
import 'package:built_your_pc/pages/user/success.dart';
import 'package:built_your_pc/services/location_provider.dart';
import 'package:built_your_pc/services/order_provider.dart';
import 'package:built_your_pc/services/stripe_service.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../model/location_model.dart';
import '../components/content_container.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.pc});
  final PCModel pc;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _note = TextEditingController();
  final uid = Uuid();
  bool isLoading = false;
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  LocationModel? selectedLoc;
  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocationProvider>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    loc.fetchData();
    return Scaffold(
      backgroundColor: bg,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff4bb543),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          if (selectedLoc != null) {
            try {
              await StripeService.instance
                  .makePayment(widget.pc.totalPrice.toInt());

              await order.addOrder(
                OrderModel(
                    id: uid.v1(),
                    loc: selectedLoc!,
                    notes: _note.text,
                    pc: widget.pc,
                    userId: supabase.auth.currentUser!.id,
                    status: "Diproses"),
              );
              setState(() {
                isLoading = false;
              });
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => SuccessPage(pc: widget.pc),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            } catch (e) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: CostumText(data: "Payment Failed"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: CostumText(
                          data: "OK",
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            // void _showDeleteConfirmationDialog(

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: CostumText(data: "Location Empty"),
                  content: CostumText(
                    data: "Please provide a location",
                    size: 14,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: CostumText(
                        data: "OK",
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        foregroundColor: const Color.fromARGB(255, 224, 224, 224),
        label: SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CostumText(
                  data: "Buy",
                  fontFamily: "Poppins-bold",
                  color: const Color.fromARGB(255, 235, 235, 235),
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: bg,
        title: CostumText(
          data: "Payment",
          size: 14,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ContentContainer(
              child: Padding(
                padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                child: GestureDetector(
                  onTap: () => _showLocationModal(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: CostumText(
                                data: "Shipping Location",
                                color: const Color.fromARGB(255, 97, 97, 97),
                                fontFamily: 'Poppins-bold',
                                size: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      selectedLoc == null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8),
                              child: GestureDetector(
                                onTap: () => _showLocationModal(context),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 23,
                                      color:
                                          const Color.fromARGB(255, 97, 97, 97),
                                    ),
                                    CostumText(
                                      data: " Choose Location",
                                      size: 14,
                                      color: const Color.fromARGB(
                                          255, 141, 140, 140),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CostumText(
                                    data: "${selectedLoc!.locationName}",
                                    size: 14,
                                  ),
                                  Wrap(
                                    children: [
                                      CostumText(
                                        data:
                                            "Jl.${selectedLoc!.streetName} RT ${selectedLoc!.rtNumber}/RW ${selectedLoc!.rwNumber} no.${selectedLoc!.streetNumber}, ${selectedLoc!.kecamatan}, ${selectedLoc!.kabupatenOrKota}",
                                        size: 12,
                                        color: const Color.fromARGB(
                                            255, 141, 140, 140),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            ContentContainer(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  child: Image.network(
                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${widget.pc.pcCase['pic_url']}",
                    // fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Price",
                            value: formatCurrency(
                                (widget.pc.totalPrice).toInt().toString())),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Case Side Panel",
                            value: widget.pc.pcCase['side_panel']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "Motherboard Socket",
                            value: widget.pc.mobo['socket']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "CPU Graphics",
                            value: widget.pc.cpu['graphics']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "GPU Chipset",
                            value: widget.pc.gpu['chipset']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "SSD Capacity",
                            value: widget.pc.ssd['capacity']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "RAM Capacity",
                            value: widget.pc.ram['capacity']),
                        DetailDescription(
                            padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                            attribute: "PSU Wattage",
                            value: widget.pc.psu['wattage']),
                      ],
                    ),
                  ),
                  ContentContainer(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                      child: GestureDetector(
                        onTap: () => _showLocationModal(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.library_books,
                                      color: const Color.fromARGB(
                                          255, 104, 104, 104),
                                    ),
                                    CostumText(
                                      data: " Notes",
                                      fontFamily: 'Poppins-bold',
                                      color:
                                          const Color.fromARGB(255, 97, 97, 97),
                                      size: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 105,
                              child: TextField(
                                style: const TextStyle(
                                    fontFamily: "Poppins-regular",
                                    fontSize: 13),
                                controller: _note,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  // labelText: "",
                                  hintText: "Dijaga baik baik yaa...",

                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppins-regular',
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 223, 223, 223)),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 75, 75, 75),
                                    fontFamily: 'Poppins-regular',
                                    fontSize: 14,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 182, 153, 153)),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 180, 180, 180)),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),

                                  // suffixText: suffixText ?? "",
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ContentContainer(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(14, 6, 14, 8),
                      child: GestureDetector(
                        onTap: () => _showLocationModal(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 18.0),
                                    child: CostumText(
                                      data: "Payment method",
                                      fontFamily: 'Poppins-bold',
                                      color:
                                          const Color.fromARGB(255, 97, 97, 97),
                                      size: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await StripeService.instance.makePayment(
                                        widget.pc.totalPrice.toInt());
                                  } catch (e) {
                                    Text(e.toString());
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.credit_card,
                                      size: 23,
                                      color: const Color.fromARGB(
                                          255, 141, 140, 140),
                                    ),
                                    CostumText(
                                      data: " Credit Card",
                                      size: 13,
                                      color: const Color.fromARGB(
                                          255, 141, 140, 140),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationModal(BuildContext context) {
    final loc = Provider.of<LocationProvider>(context, listen: false);

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: CostumText(
                      data: "Shipping Address ",
                      size: 14,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: loc.locations.length,
                    itemBuilder: (context, index) {
                      final a = loc.locations[index];
                      final isSelected =
                          selectedLoc?.locationName == a.locationName;

                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedLoc = a;
                          });
                          Navigator.pop(context, a);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withAlpha(60)
                                : Colors.white,
                            border: const Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 221, 221, 221),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        a.locationName!,
                                        style: TextStyle(
                                          fontFamily: 'Poppins-regular',
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(Icons.check,
                                          color: Colors.blue),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 0, 10, 10),
                                child: Text(
                                  "jl.${a.streetName} RT ${a.rtNumber}/RW ${a.rwNumber} no.${a.streetNumber}, ${a.kecamatan}, ${a.kabupatenOrKota}",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins-regular',
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 151, 151, 151),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 18),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddLocationPage(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 400,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 23,
                              color: const Color.fromARGB(255, 141, 140, 140),
                            ),
                            CostumText(
                              data: " New Location",
                              size: 14,
                              color: const Color.fromARGB(255, 141, 140, 140),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((selectedLocation) {
      if (selectedLocation != null && selectedLocation is LocationModel) {
        setState(() {
          selectedLoc = selectedLocation;
        });
      }
    });
  }
}
