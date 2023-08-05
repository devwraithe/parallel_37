class Cart {
  int? id, productId, publisherId;
  String? image, name;
  double? price;
  int? count;

  Cart({
    this.id,
    this.productId,
    this.publisherId,
    this.image,
    this.name,
    this.price,
    this.count,
  });

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"],
        publisherId = data["publisher_id"],
        productId = data["product_id"],
        image = data["image"],
        name = data["name"],
        price = data["price"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "publisher_id": publisherId,
      "product_id": productId,
      "image": image,
      "name": name,
      "price": price,
    };
  }
}
