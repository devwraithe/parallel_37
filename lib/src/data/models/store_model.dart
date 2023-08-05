import 'package:parallel_37/src/domain/entities/store.dart';

class StoreModel {
  final int? storeId, publisherId;
  final String? name, image, storeType, delivery, rating, pickup, timeRange;
  final List? products;

  const StoreModel({
    this.storeId,
    this.publisherId,
    this.name,
    this.image,
    this.storeType,
    this.delivery,
    this.rating,
    this.pickup,
    this.timeRange,
    this.products,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        storeId: json["store_id"],
        publisherId: json["publisher_id"],
        name: json["name"],
        image: json["image"],
        storeType: json["store_type"],
        delivery: json["delivery"],
        rating: json["rating"],
        pickup: json["pickup"],
        timeRange: json["time_range"],
        products: json["products"],
      );

  Store toEntity() => Store(
        storeId: storeId,
        publisherId: publisherId,
        name: name,
        image: image,
        storeType: storeType,
        delivery: delivery,
        rating: rating,
        pickup: pickup,
        timeRange: timeRange,
        products: products,
      );

  List<Object?> get props => [
        storeId,
        publisherId,
        name,
        storeType,
        delivery,
        rating,
        pickup,
        timeRange,
        products,
      ];
}
