import 'package:equatable/equatable.dart';

class NestedRestaurant extends Equatable {
  final String id;
  final String name;
  final String photo;

  const NestedRestaurant({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory NestedRestaurant.fromJson(Map<String, dynamic> json) {
    return NestedRestaurant(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, photo];
}
