import 'package:equatable/equatable.dart';
import 'package:restaurantapp/data/models/restauran_foods_model.dart';
import 'package:restaurantapp/data/models/restaurant_drinks_model.dart';
import 'package:restaurantapp/domain/entities/menus.dart';

class RestaurantMenusModel extends Equatable {
  const RestaurantMenusModel({
    required this.foods,
    required this.drinks,
  });

  final List<RestaurantFoodsModel> foods;
  final List<RestaurantDrinksModel> drinks;

  factory RestaurantMenusModel.fromJson(Map<String, dynamic> json) =>
      RestaurantMenusModel(
        foods: List<RestaurantFoodsModel>.from(
            json["foods"].map((x) => RestaurantFoodsModel.fromJson(x))),
        drinks: List<RestaurantDrinksModel>.from(
            json["drinks"].map((x) => RestaurantDrinksModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(drinks.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(foods.map((x) => x.toJson())),
      };

  Menus toEntity() {
    return Menus(
      foods: this.foods.map((Foods) => Foods.toEntity()).toList(),
      drinks: this.drinks.map((Drinks) => Drinks.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        foods,
        drinks,
      ];
}
