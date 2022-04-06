import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/common/utils.dart';
import 'package:restaurantapp/presentation/provider/favorit_restaurant_notifier.dart';
import 'package:restaurantapp/presentation/widgets/restaurant_card_list.dart';

class FavoritPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/favorite';

  const FavoritPage({Key? key}) : super(key: key);

  @override
  _FavoritPageState createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<FavoritRestaurantNotifier>(context, listen: false)
            .fetchFavoritRestaurant());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<FavoritRestaurantNotifier>(context, listen: false)
        .fetchFavoritRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<FavoritRestaurantNotifier>(
          builder: (context, data, child) {
            if (data.favoritState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.favoritState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.favoritRestaurant[index];
                  return RestaurantCard(tv);
                },
                itemCount: data.favoritRestaurant.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
