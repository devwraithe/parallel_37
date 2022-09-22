class Cart {
  int? id;
  String? image, name;
  double? price;

  Cart({
    this.id,
    this.image,
    this.name,
    this.price,
  });

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"],
        image = data["image"],
        name = data["name"],
        price = data["price"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "price": price,
    };
  }
}
