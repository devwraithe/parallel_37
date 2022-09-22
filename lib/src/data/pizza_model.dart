class PizzaModel {
  final int? id;
  final String? image, name, duration, tags, weight;
  final double? price;

  const PizzaModel({
    this.id,
    this.image,
    this.name,
    this.duration,
    this.tags,
    this.weight,
    this.price,
  });

  // data for breaking news tab
  static const pizzaList = [
    PizzaModel(
      id: 1,
      image: "assets/images/1.png",
      name: "Pizza Pepperoni",
      duration: "15 to 30",
      tags: "Italian, Pizza",
      weight: "250",
      price: 100.73,
    ),
    PizzaModel(
      id: 2,
      image: "assets/images/2.png",
      name: "Pizza Marinara",
      duration: "20 to 40",
      tags: "American, Pizza",
      weight: "300",
      price: 120.82,
    ),
    PizzaModel(
      id: 3,
      image: "assets/images/3.png",
      name: "Pizza Margherita",
      duration: "10 to 20",
      tags: "American, Pizza",
      weight: "200",
      price: 88.46,
    ),
  ];
}
