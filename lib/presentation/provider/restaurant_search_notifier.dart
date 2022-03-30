import 'package:flutter/foundation.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/usecase/search_restaurant.dart';

class RestaurantSearchNotifier extends ChangeNotifier {
  final SearchRestaurant searchRestaurant;

  RestaurantSearchNotifier({required this.searchRestaurant});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Restaurant> _searchResult = [];
  List<Restaurant> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchRestaurant.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
