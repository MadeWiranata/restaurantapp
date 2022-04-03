import 'package:equatable/equatable.dart';
import 'package:restaurantapp/domain/entities/foods.dart';

class RestaurantFoodsModel extends Equatable {
  const RestaurantFoodsModel({
    required this.name,
  });

  final String name;

  factory RestaurantFoodsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantFoodsModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Foods toEntity() {
    return Foods(name: name);
  }

  @override
  List<Object?> get props => [name];
}
