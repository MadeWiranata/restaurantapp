import 'package:equatable/equatable.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';

class RestaurantTable extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;

  const RestaurantTable({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
  });

  factory RestaurantTable.fromEntity(RestaurantDetail restaurant) =>
      RestaurantTable(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
      );

  factory RestaurantTable.fromMap(Map<String, dynamic> map) => RestaurantTable(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        pictureId: map['pictureId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
      };

  Restaurant toEntity() => Restaurant.watchlist(
        id: id,
        name: name,
        pictureId: pictureId,
        description: description,
      );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object?> get props => [id, name, description, pictureId];
}
