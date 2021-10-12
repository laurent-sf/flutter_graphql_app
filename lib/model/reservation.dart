import 'package:equatable/equatable.dart';
import 'package:flutter_graphql_app/model/model.dart';

class Reservation extends Equatable {
  final String id;
  final Restaurant restaurant;

  const Reservation({
    required this.id,
    required this.restaurant,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'] ?? '',
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }

  @override
  List<Object?> get props => [id, restaurant];
}
