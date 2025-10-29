class Product {
  int? id;
  String product_name;
  String product_quantity;
  String product_price;
  String product_quantifier;
  String? product_image;
  String? product_description;

  Product({
    this.id,
    required this.product_name,
    required this.product_quantity,
    required this.product_price,
    required this.product_quantifier,
    this.product_image,
    this.product_description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name': product_name,
      'product_quantity': product_quantity,
      'product_price': product_price,
      'product_quantifier': product_quantifier,
      'product_image': product_image,
      'product_description': product_description,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["id"],
      product_name: map["product_name"] ?? '',
      product_quantity: map["product_quantity"] ?? '0',
      product_price: map["product_price"] ?? '0.0',
      product_quantifier: map["product_quantifier"] ?? '',
      product_image: map["product_image"],
      product_description: map["product_description"],
    );
  }
}
