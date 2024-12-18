import 'package:built_your_pc/pages/user/saved_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../../services/location_provider.dart';
import '../../util/util.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  var uuid = const Uuid();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _rt = TextEditingController();
  final TextEditingController _rw = TextEditingController();
  final TextEditingController _no = TextEditingController();
  final TextEditingController _kota = TextEditingController();
  final TextEditingController _camat = TextEditingController();
  final TextEditingController _addressName = TextEditingController();

  void addLocation(BuildContext ctx) async {
    Provider.of<LocationProvider>(ctx, listen: false).addData({
      'location_id': uuid.v1(),
      'location_name': _addressName.text,
      'street_name': _street.text,
      'rt_number': _rt.text,
      'rw_number': _rw.text,
      'street_number': _no.text,
      'kecamatan': _camat.text,
      'kabupaten_or_kota': _kota.text,
      'user_id': supabase.auth.currentUser!.id,
    });
  }

  void clear() {
    _street.clear();
    _addressName.clear();
    _rt.clear();
    _rw.clear();
    _no.clear();
    _camat.clear();
    _kota.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CostumText(data: "Tambah lokasi baru"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  // Tombol Upload Foto
                  CostumTextField(
                      controller: _addressName,
                      radius: 7,
                      icon: Icons.person_pin_circle_rounded,
                      labelText: "Address name"),
                  CostumTextField(
                      controller: _street,
                      radius: 7,
                      icon: Icons.streetview,
                      labelText: "Street name"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                        child: Center(child: const CostumText(data: "RT/RW")),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: CostumTextField(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                              controller: _rt,
                              radius: 7,
                              labelText: "",
                              inputType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 130,
                            child: CostumTextField(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                                controller: _rw,
                                radius: 7,
                                inputType: TextInputType.number,
                                labelText: ""),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CostumTextField(
                    controller: _no,
                    radius: 7,
                    icon: Icons.numbers,
                    labelText: "No.",
                    inputType: TextInputType.number,
                  ),
                  CostumTextField(
                      controller: _camat, radius: 7, labelText: "kecamatan"),
                  CostumTextField(
                      controller: _kota, radius: 7, labelText: "Kota"),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(const Size(150, 42)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 252, 252, 252)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SaveLocationPage()));
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15,
                              color: Color.fromARGB(255, 32, 32, 32),
                            ),
                          ),
                        ),
                        MyButton(
                          color: const Color.fromARGB(255, 78, 132, 233),
                          height: 50,
                          width: 200,
                          onTap: () {
                            addLocation(context);
                            clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor:
                                    Color.fromARGB(255, 108, 221, 42),
                                content: CostumText(
                                    color: Color.fromARGB(255, 252, 252, 252),
                                    data: 'Berhasil Menambahkan Alamat'),
                              ),
                            );
                          },
                          child: const Text(
                            'Tambah ',
                            style: TextStyle(
                                fontFamily: 'Poppins-regular',
                                fontSize: 15,
                                color: Color.fromARGB(255, 235, 234, 234)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
