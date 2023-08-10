import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String id;

  const StoreModel({
    required this.id,
  });

  factory StoreModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return StoreModel(
      id: snapshot.id,
    );
  }
  List<Object?> get props => [id];
}
