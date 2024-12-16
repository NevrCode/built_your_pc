import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditRAMPage extends StatefulWidget {
  final RAMModel rm;
  const EditRAMPage({super.key, required this.rm});

  @override
  State<EditRAMPage> createState() => _EditRAMPageState();
}

class _EditRAMPageState extends State<EditRAMPage> {
  File? _file;
  bool isLoading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _capacity = TextEditingController();
  final _speed = TextEditingController();
  final _fwL = TextEditingController();
  final _cas = TextEditingController();
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
    _name.clear();
    _capacity.clear();
    _price.clear();
    _color.clear();
    _cas.clear();
    _fwL.clear();
    _speed.clear();
    _desc.clear();
    _stok.clear();
  }

  String generateSKU() {
    final random = Random();
    return "RAM-${_name.text.substring(0, 3)}-${(1000 + random.nextInt(90000)).toString()}";
  }

  Future<void> _addComponents(context) async {
    setState(() {
      isLoading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text != "" ? _name.text : widget.rm.name;
    final capacity =
        _capacity.text != "" ? "${_capacity.text}GB" : widget.rm.capacity;
    final price = _price.text != "" ? _price.text : widget.rm.price;
    final cas = _cas.text != "" ? "${_cas.text}ns" : widget.rm.casLatency;
    final color = _color.text != "" ? _color.text : widget.rm.color;
    final fwL = _fwL.text != "" ? "${_fwL.text}ns" : widget.rm.firstWordLatency;
    final speed = _speed.text != "" ? "${_speed.text}GHz" : widget.rm.speed;
    final description = _desc.text != "" ? _desc.text : widget.rm.description;
    final stock = _stok.text != "" ? _stok.text : widget.rm.stock;
    String url = widget.rm.picUrl;
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
      final cpu = RAMModel(
        id: widget.rm.id,
        name: name,
        description: description,
        picUrl: url,
        price: int.parse(price.toString()),
        stock: int.parse(stock.toString()),
        capacity: capacity,
        speed: speed,
        color: color,
        casLatency: cas,
        firstWordLatency: fwL,
      );
      await comps.updateComponent(cpu);
    } finally {
      setState(() {
        isLoading = false;
        clearAll();
        _showSnackBar(context, "Barang berhasil diperbaharui!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: CostumText(
          data: "Edit ${widget.rm.name}",
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
                                  child: Image.network(
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${widget.rm.picUrl}",
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  CostumTextField(
                      controller: _name, radius: 7, labelText: widget.rm.name),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _capacity,
                          radius: 7,
                          labelText: widget.rm.capacity,
                          suffixText: "cap",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                          flex: 5,
                          child: CostumTextField(
                            controller: _cas,
                            radius: 7,
                            labelText: widget.rm.casLatency,
                            suffixText: "cas  ",
                            inputType: TextInputType.number,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _speed,
                          radius: 7,
                          labelText: widget.rm.speed,
                          suffixText: "speed  ",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _color,
                          radius: 7,
                          labelText: widget.rm.color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _fwL,
                          radius: 7,
                          labelText: widget.rm.firstWordLatency,
                          suffixText: "FWL",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _stok,
                          radius: 7,
                          labelText: widget.rm.stock.toString(),
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
                          labelText: widget.rm.price.toString(),
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
          if (isLoading)
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
