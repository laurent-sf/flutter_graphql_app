import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String hours;
  final String photo;
  final int version;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.hours,
    required this.photo,
    required this.version,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      hours: json['hours'] ?? '',
      photo: json['photo'] ?? '',
      version: json['version'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, version];
}
