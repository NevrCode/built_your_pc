import 'dart:io';
import 'dart:math';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../util/util.dart';

class EditCPUPage extends StatefulWidget {
  final ComponentModel cm;
  const EditCPUPage({super.key, required this.cm});

  @override
  State<EditCPUPage> createState() => _EditCPUPageState();
}

class _EditCPUPageState extends State<EditCPUPage> {
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
    final item = widget.cm;
    if (item is CPUModel) {
      setState(() {
        isloading = true;
      });
      final comps = Provider.of<ComponentProvider>(context, listen: false);
      final name = _name.text != '' ? _name.text : item.name;
      final tdp = _tdp.text != '' ? _tdp.text : item.tdp;
      final price = _price.text != '' ? _price.text : item.price;
      final graphics = _graphic.text != '' ? _graphic.text : item.graphics;
      final clock = _clock.text != '' ? _clock.text : item.clock;
      final count = _count.text != '' ? _count.text : item.count;
      final boost = _boost.text != '' ? _boost.text : item.boost;
      final description = _desc.text != '' ? _desc.text : item.description;
      final stock = _stok.text != '' ? _stok.text : item.stock;
      String url = item.picUrl;
      try {
        if (_file != null) {
          String fullPath =
              await supabase.storage.from('profile/product').upload(
                    "${DateTime.now().millisecondsSinceEpoch}.jpg",
                    _file!,
                    fileOptions:
                        const FileOptions(cacheControl: '3600', upsert: false),
                  );
          url = fullPath.replaceFirst("profile", "");
        }

        final cpu = CPUModel(
            id: widget.cm.id,
            tdp: "${tdp}W",
            graphics: graphics,
            clock: "${clock}GHz",
            count: count,
            boost: "${boost}GHz",
            stock: int.parse(stock.toString()),
            name: name,
            description: description,
            price: int.parse(price.toString()),
            picUrl: url);
        await comps.updateComponent(cpu);
      } catch (e) {
        _showSnackBar(context, "$e");
      } finally {
        setState(() {
          isloading = false;
          clearAll();
        });
        _showSnackBar(context, "Barang berhasil diperbaharui!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.cm;
    if (item is CPUModel) {
      return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          title: CostumText(
            data: "edit ${item.name}",
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
                        controller: _name, radius: 7, labelText: item.name),
                    CostumTextField(
                      controller: _graphic,
                      radius: 7,
                      labelText: item.graphics,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CostumText(data: "jumlah core"),
                        ),
                        Flexible(
                          flex: 6,
                          child: CostumTextField(
                            controller: _count,
                            radius: 7,
                            labelText: item.count,
                            inputType: TextInputType.number,
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
                            controller: _clock,
                            radius: 7,
                            labelText: item.clock,
                            suffixText: "core ",
                            inputType: TextInputType.number,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: CostumTextField(
                            controller: _tdp,
                            radius: 7,
                            labelText: item.tdp,
                            suffixText: "tdp ",
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
                            labelText: item.boost,
                            suffixText: "boost  ",
                            inputType: TextInputType.number,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: CostumTextField(
                            controller: _stok,
                            radius: 7,
                            labelText: item.stock.toString(),
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
                            labelText: item.price.toString(),
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
    return Scaffold();
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
