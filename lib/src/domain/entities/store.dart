import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final int? storeId, publisherId;
  final String? name, image, storeType, delivery, rating, pickup, timeRange;
  final List? products;

  const Store({
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

  @override
  List<Object?> get props => [
        storeId,
        publisherId,
        name,
        image,
        storeType,
        delivery,
        rating,
        pickup,
        timeRange,
        products,
      ];
}
