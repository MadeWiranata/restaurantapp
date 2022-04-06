import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class RemoveFavorit {
  final RestaurantRepository repository;

  RemoveFavorit(this.repository);

  Future<Either<Failure, String>> execute(RestaurantDetail tv) {
    return repository.removeFavorit(tv);
  }
}
