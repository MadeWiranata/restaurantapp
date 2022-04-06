import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class GetFavoritRestaurant {
  final RestaurantRepository _repository;

  GetFavoritRestaurant(this._repository);

  Future<Either<Failure, List<Restaurant>>> execute() {
    return _repository.getFavoritRestaurant();
  }
}
