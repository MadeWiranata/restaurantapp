import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class GetFavoritStatus {
  final RestaurantRepository repository;

  GetFavoritStatus(this.repository);

  Future<bool> execute(String id) async {
    return repository.isAddedToFavorit(id);
  }
}
