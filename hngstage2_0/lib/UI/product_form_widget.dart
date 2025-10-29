import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Database/product_database.dart';
import '../Models/product.dart';

class ProductFormWidget extends StatefulWidget {
  final Product? product;
  const ProductFormWidget({super.key, this.product});

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String product_name = "",
      product_quantity = "",
      product_price = "",
      product_quantifier = "",
      product_image = "";

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      product_name = widget.product!.product_name;
      product_quantity = widget.product!.product_quantity;
      product_price = widget.product!.product_price;
      product_quantifier = widget.product!.product_quantifier;
      product_image = widget.product!.product_image!;
    }
  }

  // Method to handle image picking
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        product_image = pickedFile.path;
      });
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (product_image.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image.')),
        );
        return;
      }

      final product = Product(
        id: widget.product?.id,
        product_name: product_name,
        product_quantity: product_quantity,
        product_price: product_price,
        product_quantifier: product_quantifier,
        product_image: product_image,
      );

      if (widget.product == null) {
        await ProductDatabase.addProduct(product);
      } else {
        await ProductDatabase.updateProduct(product);
      }
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: product_image.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(product_image),
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Center(
                      child: Icon(Icons.image,
                          size: 50, color: Colors.grey)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Select Image"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product_name,
              decoration: const InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onSaved: (v) => product_name = v!,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product_quantity,
              decoration: const InputDecoration(
                labelText: "Product Quantity",
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onSaved: (v) => product_quantity = v!,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product_price,
              decoration: const InputDecoration(
                labelText: "Product Price",
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onSaved: (v) => product_price = v!,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product_quantifier,
              decoration: const InputDecoration(
                labelText: "Product Quantifier (e.g., 'bags', 'boxes')",
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onSaved: (v) => product_quantifier = v!,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _save,
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
