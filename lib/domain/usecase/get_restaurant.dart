import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class GetRestaurant {
  final RestaurantRepository repository;

  GetRestaurant(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute() {
    return repository.getRestaurant();
  }
}
