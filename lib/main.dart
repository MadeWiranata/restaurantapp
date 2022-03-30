import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/constants.dart';
import 'package:restaurantapp/common/utils.dart';
import 'package:restaurantapp/injection.dart' as di;
import 'package:restaurantapp/presentation/pages/home_page.dart';
import 'package:restaurantapp/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurantapp/presentation/pages/search_page.dart';
import 'package:restaurantapp/presentation/provider/restaurant_detail_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_search_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case RestaurantDetailPage.ROUTE_NAME:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => RestaurantDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
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
