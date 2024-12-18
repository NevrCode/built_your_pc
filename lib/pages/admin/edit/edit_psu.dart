import 'dart:io';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPSUPage extends StatefulWidget {
  final PSUModel pm;
  const EditPSUPage({super.key, required this.pm});

  @override
  State<EditPSUPage> createState() => _EditPSUPageState();
}

class _EditPSUPageState extends State<EditPSUPage> {
  File? _file;
  bool isLoading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _type = TextEditingController();
  final _eff = TextEditingController();
  final _watt = TextEditingController();
  final _mod = TextEditingController();
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
    _color.clear();
    _price.clear();
    _watt.clear();
    _eff.clear();
    _mod.clear();
    _type.clear();
    _desc.clear();
    _stok.clear();
  }

  Future<void> _addComponents(context) async {
    setState(() {
      isLoading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text != "" ? _name.text : widget.pm.name;
    final color = _color.text != "" ? _color.text : widget.pm.color;
    final price = _price.text != "" ? _price.text : widget.pm.price;
    final watt = _watt.text != "" ? "${_watt.text}W" : widget.pm.wattage;
    final eff = _eff.text != "" ? _eff.text : widget.pm.efficiency;
    final type = _type.text != "" ? _type.text : widget.pm.type;
    final mod = _mod.text != "" ? _mod.text : widget.pm.modular;
    final description = _desc.text != "" ? _desc.text : widget.pm.description;
    final stock = _stok.text != "" ? _stok.text : widget.pm.stock;
    String url = widget.pm.picUrl;
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
      final id = widget.pm.id;
      final cpu = PSUModel(
        id: id,
        name: name,
        picUrl: url,
        description: description,
        price: int.parse(price.toString()),
        type: type,
        efficiency: eff,
        wattage: watt,
        modular: mod,
        color: color,
        stock: int.parse(stock.toString()),
      );
      await comps.updateComponent(cpu);
    } catch (e) {
      _showSnackBar(context, "$e");
    } finally {
      setState(() {
        isLoading = false;
        clearAll();
        _showSnackBar(context, "Barang berhasil Diperbaharui!");
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
          data: "Tambah PSU",
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
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${widget.pm.picUrl}",
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
                      controller: _name, radius: 7, labelText: widget.pm.name),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _mod,
                          radius: 7,
                          labelText: widget.pm.modular,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _type,
                          radius: 7,
                          labelText: widget.pm.type,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _eff,
                          radius: 7,
                          labelText: widget.pm.efficiency,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _color,
                          radius: 7,
                          labelText: widget.pm.color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _watt,
                          radius: 7,
                          labelText: widget.pm.wattage,
                          suffixText: "watt",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _stok,
                          radius: 7,
                          labelText: widget.pm.stock.toString(),
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
                          labelText: widget.pm.price.toString(),
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
