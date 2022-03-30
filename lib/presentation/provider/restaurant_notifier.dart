import 'package:flutter/foundation.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant.dart';

class RestaurantNotifier extends ChangeNotifier {
  final GetRestaurant getRestaurant;

  RestaurantNotifier(this.getRestaurant);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Restaurant> _restaurant = [];
  List<Restaurant> get restaurant => _restaurant;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurant() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getRestaurant.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (restaurantData) {
        _restaurant = restaurantData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
