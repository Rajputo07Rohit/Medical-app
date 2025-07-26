class Product {
  String name;
  String img;
  String description;
  int price;
  String productId;
  final quantity;
  Product({
    required this.name,
    required this.description,
    required this.img,
    required this.price,
    required this.productId,
    this.quantity,
  });
}
