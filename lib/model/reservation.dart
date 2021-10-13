import 'package:equatable/equatable.dart';
import 'package:flutter_graphql_app/model/nested_restaurant.dart';

class Reservation extends Equatable {
  final String id;
  final NestedRestaurant restaurant;

  const Reservation({
    required this.id,
    required this.restaurant,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'] ?? '',
      restaurant: NestedRestaurant.fromJson(json['restaurant']),
    );
  }

  @override
  List<Object?> get props => [id, restaurant];
}
