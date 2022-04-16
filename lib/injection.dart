import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantapp/data/datasources/db/database_helper.dart';
import 'package:restaurantapp/data/datasources/restaurant_data_source.dart';
import 'package:restaurantapp/data/datasources/restaurant_local_data_source.dart';
import 'package:restaurantapp/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';
import 'package:restaurantapp/domain/usecase/get_favorit_restaurant.dart';
import 'package:restaurantapp/domain/usecase/get_favorit_status.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant_detail.dart';
import 'package:restaurantapp/domain/usecase/remove_favorit.dart';
import 'package:restaurantapp/domain/usecase/save_favorit.dart';
import 'package:restaurantapp/domain/usecase/search_restaurant.dart';
import 'package:restaurantapp/presentation/notif/preference_provider.dart';
import 'package:restaurantapp/presentation/notif/sc_provider.dart';
import 'package:restaurantapp/presentation/provider/favorit_restaurant_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_detail_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_search_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => RestaurantNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RestaurantDetailNotifier(
      getRestaurantDetail: locator(),
      getFavoritStatus: locator(),
      saveFavorit: locator(),
      removeFavorit: locator(),
    ),
  );
  locator.registerFactory(
    () => RestaurantSearchNotifier(
      searchRestaurant: locator(),
    ),
  );
  locator.registerFactory(
    () => FavoritRestaurantNotifier(
      getFavoritRestaurant: locator(),
    ),
  );
  locator.registerFactory(
    () => SchedulingProvider(),
  );
  locator.registerFactory(
    () => PreferencesProvider(
      preferencesHelper: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetRestaurant(locator()));
  locator.registerLazySingleton(() => GetRestaurantDetail(locator()));
  locator.registerLazySingleton(() => SearchRestaurant(locator()));
  locator.registerLazySingleton(() => GetFavoritStatus(locator()));
  locator.registerLazySingleton(() => SaveFavorit(locator()));
  locator.registerLazySingleton(() => RemoveFavorit(locator()));
  locator.registerLazySingleton(() => GetFavoritRestaurant(locator()));

  // repository
  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<RestaurantLocalDataSource>(
      () => RestaurantLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
