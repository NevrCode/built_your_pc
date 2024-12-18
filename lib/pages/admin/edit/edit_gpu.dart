import 'dart:io';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditGPUPage extends StatefulWidget {
  final GPUModel gm;
  const EditGPUPage({super.key, required this.gm});

  @override
  State<EditGPUPage> createState() => _EditGPUPageState();
}

class _EditGPUPageState extends State<EditGPUPage> {
  File? _file;
  bool isLoading = false;
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

// Ingetin Urutannya -------
  final _chipset = TextEditingController();
  final _color = TextEditingController();
  final _clock = TextEditingController();
  final _boost = TextEditingController();
  final _length = TextEditingController();
  final _memory = TextEditingController();

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
    _memory.clear();
    _price.clear();
    _chipset.clear();
    _clock.clear();
    _length.clear();
    _boost.clear();
    _color.clear();
    _desc.clear();
    _stok.clear();
  }

  Future<void> _addComponents(context) async {
    setState(() {
      isLoading = true;
    });
    final comps = Provider.of<ComponentProvider>(context, listen: false);
    final name = _name.text != "" ? _name.text : widget.gm.name;
    final memory = _memory.text != "" ? "${_memory.text}GB" : widget.gm.memory;
    final price = _price.text != "" ? _price.text : widget.gm.price;
    final chipset = _chipset.text != "" ? _chipset.text : widget.gm.chipset;
    final clock = _clock.text != "" ? "${_clock.text}GHz" : widget.gm.coreClock;
    final length = _length.text != "" ? "${_length.text}mm" : widget.gm.length;
    final boost =
        _boost.text != "" ? "${_boost.text}GHz" : widget.gm.boostClock;
    final color = _color.text != "" ? _color.text : widget.gm.color;
    final description = _desc.text != "" ? _desc.text : widget.gm.description;
    final stock = _stok.text != "" ? _stok.text : widget.gm.stock;
    String url = widget.gm.picUrl;
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
      final id = widget.gm.id;
      final gpu = GPUModel(
        id: id,
        name: name,
        description: description,
        price: int.parse(price.toString()),
        picUrl: url,
        chipset: chipset,
        coreClock: clock,
        boostClock: boost,
        memory: memory,
        color: color,
        length: length,
        stock: int.parse(stock.toString()),
      );
      await comps.updateComponent(gpu);
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
          data: "Edit ${widget.gm.name}",
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
                                    "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${widget.gm.picUrl}",
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
                      controller: _name, radius: 7, labelText: widget.gm.name),
                  CostumTextField(
                      controller: _chipset,
                      radius: 7,
                      labelText: widget.gm.chipset),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: CostumTextField(
                          controller: _boost,
                          radius: 7,
                          labelText: widget.gm.boostClock,
                          suffixText: "boost  ",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                          flex: 5,
                          child: CostumTextField(
                            controller: _length,
                            radius: 7,
                            labelText: widget.gm.length,
                            suffixText: "length  ",
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
                          controller: _clock,
                          radius: 7,
                          labelText: widget.gm.coreClock,
                          suffixText: "core  ",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _color,
                          radius: 7,
                          labelText: widget.gm.color,
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
                          labelText: widget.gm.memory,
                          suffixText: "memory  ",
                          inputType: TextInputType.number,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: CostumTextField(
                          controller: _stok,
                          radius: 7,
                          labelText: widget.gm.stock.toString(),
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
                          labelText: widget.gm.price.toString(),
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
