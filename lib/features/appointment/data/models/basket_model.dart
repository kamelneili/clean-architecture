import 'package:beautycentre/features/appointment/domain/entities/delivery_time.dart';
import 'package:equatable/equatable.dart';

class BasketModel extends Equatable {
  final DeliveryTime? deliveryTime;
  final DateTime? date;
  BasketModel({
    this.deliveryTime,
    this.date,
  });
  BasketModel copyWith({DeliveryTime? deliveryTime, DateTime? date}) {
    return BasketModel(
      deliveryTime: deliveryTime ?? this.deliveryTime,
      date: date,
    );
  }

  @override
  List<Object?> get props => [deliveryTime];
  Map itemQuantity(items) {
    var quantity = Map();
    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else
        quantity[item] += 1;
    });
    return quantity;
  }
}
