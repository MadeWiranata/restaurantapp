import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/constants.dart';
import 'package:restaurantapp/common/utils.dart';
import 'package:restaurantapp/injection.dart' as di;
import 'package:restaurantapp/presentation/pages/favorit_page.dart';
import 'package:restaurantapp/presentation/pages/home_page.dart';
import 'package:restaurantapp/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurantapp/presentation/pages/search_page.dart';
import 'package:restaurantapp/presentation/provider/favorit_restaurant_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_detail_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_search_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FavoritRestaurantNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kOxfordBlue,
          // ignore: deprecated_member_use
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kOxfordBlue,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case RestaurantDetailPage.ROUTE_NAME:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => RestaurantDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case FavoritPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const FavoritPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
