import 'package:equatable/equatable.dart';
import 'package:restaurantapp/domain/entities/categories.dart';

class RestaurantCategoriesModel extends Equatable {
  const RestaurantCategoriesModel({
    required this.name,
  });

  final String name;

  factory RestaurantCategoriesModel.fromJson(Map<String, dynamic> json) =>
      RestaurantCategoriesModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Categories toEntity() {
    return Categories(name: name);
  }

  @override
  List<Object?> get props => [name];
}
