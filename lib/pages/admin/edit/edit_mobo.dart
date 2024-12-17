import 'dart:io';
import 'dart:math';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/mobo_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditMoboPage extends StatefulWidget {
  const EditMoboPage({super.key, required this.mm});
  final MoboModel mm;
  @override
  State<EditMoboPage> createState() => _EditMoboPageState();
}

class _EditMoboPageState extends State<EditMoboPage> {
  File? _file;
  bool isloading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _socket = TextEditingController();
  final _memory = TextEditingController();
  final _maxMemory = TextEditingController();
  final _form = TextEditingController();
  final _color = TextEditingController();

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
    _color.clear();
    _price.clear();
    _socket.clear();
    _maxMemory.clear();
    _memory.clear();
    _form.clear();
    _desc.clear();
    _stok.clear();
  }

  Future<void> _addComponents(context) async {
    final item = widget.mm;
    setState(() {
      isloading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text != "" ? _name.text : item.name;
    final memory = _memory.text != "" ? _memory.text : item.memory;
    final price = _price.text != "" ? _price.text : item.price;
    final maxMemory = _maxMemory.text != "" ? _maxMemory.text : item.maxMemory;
    final form = _form.text != "" ? _form.text : item.formFactor;
    final color = _color.text != "" ? _color.text : item.color;
    final socket = _socket.text != "" ? _socket.text : item.socket;
    final description = _desc.text != "" ? _name.text : item.description;
    final stock = _stok.text != "" ? _name.text : item.stock;
    String url = widget.mm.picUrl;
    try {
      if (_file != null) {
        String fullPath = await supabase.storage.from('profile/product').upload(
              "${DateTime.now().millisecondsSinceEpoch}.jpg",
              _file!,
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: false),
            );
        url = fullPath.replaceFirst("profile", "");
      }
      final cpu = MoboModel(
        id: widget.mm.id,
        maxMemory: maxMemory,
        memory: memory,
        color: color,
        formFactor: form,
        socket: socket,
        stock: int.parse(stock.toString()),
        name: name,
        description: description,
        price: int.parse(price.toString()),
        picUrl: url,
      );
      await comps.addComponentModel(cpu);
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
          data: "Tambah MOBO",
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
                      controller: _name, radius: 7, labelText: "nama Mobo"),
                  CostumTextField(
                    controller: _socket,
                    radius: 7,
                    labelText: "Socket",
                  ),
                  CostumTextField(
                    controller: _form,
                    radius: 7,
                    labelText: "Form",
                    inputType: TextInputType.number,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _maxMemory,
                          radius: 7,
                          labelText: "Max memory",
                          suffixText: "GHz",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _color,
                          radius: 7,
                          labelText: "Color",
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
                          controller: _memory,
                          radius: 7,
                          labelText: "Memory slot",
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
                          labelText: "Price",
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
