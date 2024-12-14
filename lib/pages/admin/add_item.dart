import 'dart:io';

import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  File? _file;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  final _tdp = TextEditingController();
  final _graphic = TextEditingController();
  final _clock = TextEditingController();
  final _boost = TextEditingController();
  final _count = TextEditingController();
  final _stok = TextEditingController();
  Future<void> _pickProductPicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  void clearAll() {
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

  Future<void> _addComponents(context) async {
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text;
    final tdp = _tdp.text;
    final price = _price.text;
    final graphics = _graphic.text;
    final clock = _clock.text;
    final boost = _boost.text;
    final count = _count.text;
    final decs = _desc.text;
    final stok = _stok.text;
    if (_file != null) {
      await comps.addComponentModel(
        {},
        "",
        "id",
      );
    } else {
      _showSnackBar(context, "Perlu Gambar!");
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
      body: SingleChildScrollView(
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
                                color: const Color.fromARGB(255, 179, 179, 179),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Color.fromARGB(255, 207, 207, 207),
                                    ),
                                    const CostumText(
                                      data: 'Upload Foto',
                                      size: 12,
                                      color: Color.fromARGB(255, 219, 218, 218),
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
                  controller: _name, radius: 7, labelText: "nama cpu"),
              CostumTextField(
                  controller: _name, radius: 7, labelText: "Graphics"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 9,
                    child: CostumTextField(
                        controller: _count, radius: 7, labelText: "core"),
                  ),
                  Flexible(
                    flex: 10,
                    child: CostumTextField(
                        controller: _clock, radius: 7, labelText: "core clock"),
                  ),
                  Flexible(
                    flex: 10,
                    child: CostumTextField(
                        controller: _boost,
                        radius: 7,
                        labelText: "boost clock"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 6,
                    child: CostumTextField(
                        controller: _name, radius: 7, labelText: "tdp"),
                  ),
                  Flexible(
                    flex: 5,
                    child: CostumTextField(
                        controller: _name, radius: 7, labelText: "Stok"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                        elevation: 1,
                        color: green,
                        width: 100,
                        height: 40,
                        onTap: () => _addComponents(context),
                        child: CostumText(
                          data: "Submit",
                          color: Colors.white,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
