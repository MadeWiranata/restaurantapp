import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant_detail.dart';

class RestaurantDetailNotifier extends ChangeNotifier {
  final GetRestaurantDetail getRestaurantDetail;

  RestaurantDetailNotifier({
    required this.getRestaurantDetail,
  });

  late RestaurantDetail _restaurant;
  RestaurantDetail get restaurant => _restaurant;

  RequestState _restaurantState = RequestState.Empty;
  RequestState get restaurantState => _restaurantState;

  String _message = '';
  String get message => _message;

  Future<void> fetchRestaurantDetail(String id) async {
    _restaurantState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getRestaurantDetail.execute(id);
    detailResult.fold(
      (failure) {
        _restaurantState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (restaurant) {
        _restaurant = restaurant;
        notifyListeners();
        _restaurantState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
