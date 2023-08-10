import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  final String id, name, type;

  const MenuModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory MenuModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return MenuModel(
      id: snapshot.id,
      name: data['menu_name'],
      type: data['menu_type'],
    );
  }
  List<Object?> get props => [id, name, type];
}
