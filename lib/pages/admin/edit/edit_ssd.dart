import 'dart:io';
import 'dart:math';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditSSDPage extends StatefulWidget {
  final SSDModel? sm;
  const EditSSDPage({super.key, required this.sm});

  @override
  State<EditSSDPage> createState() => _EditSSDPageState();
}

class _EditSSDPageState extends State<EditSSDPage> {
  File? _file;

  bool isLoading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _capacity = TextEditingController();
  final _type = TextEditingController();
  final _form = TextEditingController();
  final _inter = TextEditingController();

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
    _capacity.clear();
    _price.clear();
    _inter.clear();
    _type.clear();
    _form.clear();
    _desc.clear();
    _stok.clear();
  }

  Future<void> _addComponents(context) async {
    setState(() {
      isLoading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text != "" ? _name.text : widget.sm!.name;
    final type = _type.text != "" ? _type.text : widget.sm!.type;
    final price = _price.text != "" ? _price.text : widget.sm!.price;
    final inter = _inter.text != "" ? _inter.text : widget.sm!.interface;
    final form = _form.text != "" ? _form.text : widget.sm!.formFactor;
    final capacity =
        _capacity.text != "" ? "${_capacity.text}GB" : widget.sm!.capacity;
    final description = _desc.text != "" ? _desc.text : widget.sm!.description;
    final stock = _stok.text != "" ? _stok.text : widget.sm!.stock;
    String url = widget.sm!.picUrl;
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
      final id = widget.sm!.id;
      final cpu = SSDModel(
        id: id,
        name: name,
        description: description,
        picUrl: url,
        price: int.parse(price.toString()),
        stock: int.parse(stock.toString()),
        capacity: capacity,
        type: type,
        formFactor: form,
        interface: inter,
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
          data: "Edit ${widget.sm!.name}",
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
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${widget.sm!.picUrl}",
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
                      controller: _name, radius: 7, labelText: widget.sm!.name),
                  CostumTextField(
                    controller: _capacity,
                    radius: 7,
                    labelText: widget.sm!.capacity,
                    suffixText: "cap",
                    inputType: TextInputType.number,
                  ),
                  CostumTextField(
                    controller: _inter,
                    radius: 7,
                    labelText: widget.sm!.interface,
                  ),
                  CostumTextField(
                    controller: _form,
                    radius: 7,
                    labelText: widget.sm!.formFactor,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _type,
                          radius: 7,
                          labelText: widget.sm!.type,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _stok,
                          radius: 7,
                          labelText: widget.sm!.stock.toString(),
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
                          labelText: widget.sm!.price.toString(),
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
