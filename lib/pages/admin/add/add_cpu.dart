import 'dart:io';
import 'dart:math';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddCPUPage extends StatefulWidget {
  const AddCPUPage({super.key});

  @override
  State<AddCPUPage> createState() => _AddCPUPageState();
}

class _AddCPUPageState extends State<AddCPUPage> {
  File? _file;
  bool isloading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _graphic = TextEditingController();
  final _count = TextEditingController();
  final _clock = TextEditingController();
  final _boost = TextEditingController();
  final _tdp = TextEditingController();

// Ingetin Urutannya -------
  final _stok = TextEditingController();
  Future<void> _pickProductPicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  void clearAll() {
    _file = null;
    _name.clear();
    _tdp.clear();
    _price.clear();
    _graphic.clear();
    _clock.clear();
    _boost.clear();
    _count.clear();
    _desc.clear();
    _stok.clear();
  }

  String generateSKU() {
    final random = Random();
    return "CPU-${_name.text.substring(0, 3)}-${(1000 + random.nextInt(90000)).toString()}";
  }

  Future<void> _addComponents(context) async {
    setState(() {
      isloading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text;
    final tdp = _tdp.text;
    final price = _price.text;
    final graphics = _graphic.text;
    final boost = _boost.text;
    final clock = _clock.text;
    final count = _count.text;
    final description = _desc.text;
    final stock = _stok.text;
    try {
      String fullPath = await supabase.storage.from('profile/product').upload(
            "${DateTime.now().millisecondsSinceEpoch}.jpg",
            _file!,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      final url = fullPath.replaceFirst("profile", "");
      if (_file != null) {
        final id = generateSKU();
        final cpu = CPUModel(
          id: id,
          tdp: "${tdp}W",
          graphics: graphics,
          clock: "${clock}GHz",
          count: count,
          boost: "${boost}GHz",
          stock: int.parse(stock),
          name: name,
          description: description,
          price: int.parse(price),
          picUrl: url,
        );
        await comps.addComponentModel(cpu);
      } else {
        _showSnackBar(context, "Perlu Gambar!");
      }
    } catch (e) {
      _showSnackBar(context, "$e");
    } finally {
      setState(() {
        isloading = false;
        clearAll();
      });
      _showSnackBar(context, "Barang berhasil ditambahkan!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: CostumText(
          data: "Tambah CPU",
          size: 14,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          child: _file != null
                              ? InkWell(
                                  onTap: () => _pickProductPicture(),
                                  child: Image.file(
                                    _file!,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : InkWell(
                                  onTap: () => _pickProductPicture(),
                                  splashFactory: InkSplash.splashFactory,
                                  splashColor: Colors.white,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    color: const Color.fromARGB(
                                        255, 179, 179, 179),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 207, 207, 207),
                                        ),
                                        const CostumText(
                                          data: 'Upload Foto',
                                          size: 12,
                                          color: Color.fromARGB(
                                              255, 219, 218, 218),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  CostumTextField(
                      controller: _name, radius: 7, labelText: "nama CPU"),
                  CostumTextField(
                    controller: _graphic,
                    radius: 7,
                    labelText: "graphics",
                  ),
                  CostumTextField(
                    controller: _count,
                    radius: 7,
                    labelText: "core",
                    inputType: TextInputType.number,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _clock,
                          radius: 7,
                          labelText: "core clock",
                          suffixText: "GHz",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _tdp,
                          radius: 7,
                          labelText: "tdp",
                          suffixText: "W",
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _boost,
                          radius: 7,
                          labelText: "boost clock",
                          suffixText: "GHz",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _stok,
                          radius: 7,
                          labelText: "Stok",
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _price,
                          radius: 7,
                          labelText: "price",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MyButton(
                              elevation: 1,
                              color: green,
                              width: 120,
                              height: 40,
                              onTap: () => _addComponents(context),
                              child: CostumText(
                                data: "Submit",
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isloading)
            Container(
              color: const Color.fromARGB(117, 70, 70, 70),
              child: Center(
                child: CircularProgressIndicator(
                  color: green,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
