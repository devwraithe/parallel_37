import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItemModel {
  final String id, name, price;

  const MenuItemModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory MenuItemModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return MenuItemModel(
      id: snapshot.id,
      name: data['name'],
      price: data['price'],
    );
  }
  List<Object?> get props => [id, name, price];
}
