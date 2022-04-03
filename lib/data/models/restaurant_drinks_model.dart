import 'package:equatable/equatable.dart';
import 'package:restaurantapp/domain/entities/drinks.dart';

class RestaurantDrinksModel extends Equatable {
  const RestaurantDrinksModel({
    required this.name,
  });

  final String name;

  factory RestaurantDrinksModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDrinksModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Drinks toEntity() {
    return Drinks(name: name);
  }

  @override
  List<Object?> get props => [name];
}
