import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class SearchRestaurant {
  final RestaurantRepository repository;

  SearchRestaurant(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute(String query) {
    return repository.searchRestaurant(query);
  }
}
