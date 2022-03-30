import 'package:equatable/equatable.dart';
import 'package:restaurantapp/domain/entities/drinks.dart';
import 'package:restaurantapp/domain/entities/foods.dart';

class Menus extends Equatable {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Foods> foods;
  List<Drinks> drinks;

  @override
  List<Object> get props => [foods, drinks];
}
