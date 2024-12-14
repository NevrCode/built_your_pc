import 'dart:io';

import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  }

  Future<void> _addProduct() async {
    final name = _name.text;
    final tdp = _tdp.text;
    final price = _price.text;
    final graphics = _graphic.text;
    final clock = _clock.text;
    final boost = _boost.text;
    final count = _count.text;
    final decs = _desc.text;
    if (_file != null) {
      await _productService.addProduct(
          name, price, tdp, _productPic!.path, type, 5);
    } else {
      _showSnackBar(context, "Perlu Gambar!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CostumText(
          data: "Tambah Produk",
          size: 14,
        ),
      ),
      body: Column(
        children: [
          CostumTextField(controller: _name, radius: 12, labelText: "Nama")
        ],
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
