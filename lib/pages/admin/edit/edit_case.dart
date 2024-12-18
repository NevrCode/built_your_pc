import 'dart:io';
import 'dart:math';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/case_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditCasePage extends StatefulWidget {
  const EditCasePage({super.key, required this.cm});
  final CaseModel cm;

  @override
  State<EditCasePage> createState() => _EditCasePageState();
}

class _EditCasePageState extends State<EditCasePage> {
  File? _file;

  bool isLoading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _type = TextEditingController();
  final _color = TextEditingController();
  final _external = TextEditingController();
  final _side = TextEditingController();

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
    _side.clear();
    _price.clear();
    _color.clear();
    _type.clear();
    _external.clear();
    _desc.clear();
    _stok.clear();
  }

  String generateSKU() {
    final random = Random();
    return "SSD-${_name.text.substring(0, 3)}-${(1000 + random.nextInt(90000)).toString()}";
  }

  Future<void> _addComponents(context) async {
    setState(() {
      isLoading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text != "" ? _name.text : widget.cm.name;
    final type = _type.text != "" ? _type.text : widget.cm.type;
    final price = _price.text != "" ? _price.text : widget.cm.price;
    final color = _color.text != "" ? _color.text : widget.cm.color;
    final external =
        _external.text != "" ? "${_external.text}L" : widget.cm.externalVolume;
    final side = _side.text != "" ? _side.text : widget.cm.sidePanel;
    final description = _desc.text != "" ? _desc.text : widget.cm.description;
    final stock = _stok.text != "" ? _stok.text : widget.cm.stock;
    String url = widget.cm.picUrl;
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
      final cpu = CaseModel(
        id: widget.cm.id,
        name: name,
        description: description,
        picUrl: url,
        price: int.parse(price.toString()),
        stock: int.parse(stock.toString()),
        color: color,
        type: type,
        sidePanel: side,
        externalVolume: external,
      );
      await comps.updateComponent(cpu);
    } finally {
      setState(() {
        isLoading = false;
        clearAll();
        _showSnackBar(context, "Barang berhasil ditambahkan!");
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
          data: "Edit ${widget.cm.name}",
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
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${widget.cm.picUrl}",
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
                      controller: _name, radius: 7, labelText: widget.cm.name),
                  CostumTextField(
                    controller: _external,
                    radius: 7,
                    labelText: widget.cm.externalVolume,
                    suffixText: "Ex-Volume  ",
                    inputType: TextInputType.number,
                  ),
                  CostumTextField(
                    controller: _color,
                    radius: 7,
                    labelText: widget.cm.color,
                  ),
                  CostumTextField(
                    controller: _side,
                    radius: 7,
                    labelText: widget.cm.sidePanel,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _type,
                          radius: 7,
                          labelText: widget.cm.type,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _stok,
                          radius: 7,
                          labelText: widget.cm.stock.toString(),
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
        duration: Duration(seconds: 2),
        backgroundColor: green,
      ),
    );
  }
}
