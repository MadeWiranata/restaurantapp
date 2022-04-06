import 'package:flutter/foundation.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/usecase/get_favorit_restaurant.dart';

class FavoritRestaurantNotifier extends ChangeNotifier {
  var _favoritRestaurant = <Restaurant>[];
  List<Restaurant> get favoritRestaurant => _favoritRestaurant;

  var _favoritState = RequestState.Empty;
  RequestState get favoritState => _favoritState;

  String _message = '';
  String get message => _message;

  FavoritRestaurantNotifier({required this.getFavoritRestaurant});

  final GetFavoritRestaurant getFavoritRestaurant;

  Future<void> fetchFavoritRestaurant() async {
    _favoritState = RequestState.Loading;
    notifyListeners();

    final result = await getFavoritRestaurant.execute();
    result.fold(
      (failure) {
        _favoritState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (restaurantData) {
        _favoritState = RequestState.Loaded;
        _favoritRestaurant = restaurantData;
        notifyListeners();
      },
    );
  }
}
