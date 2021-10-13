import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String id;
  final String restaurantPhoto;

  const Reservation({
    required this.id,
    required this.restaurantPhoto,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'] ?? '',
      restaurantPhoto: json['restaurant']['photo'],
    );
  }

  @override
  List<Object?> get props => [id, restaurantPhoto];
}
