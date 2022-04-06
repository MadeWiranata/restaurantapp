import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/constants.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';
import 'package:restaurantapp/presentation/provider/restaurant_detail_notifier.dart';

class RestaurantDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail';

  final String id;
  // ignore: use_key_in_widget_constructors
  const RestaurantDetailPage({required this.id});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RestaurantDetailNotifier>(context, listen: false)
          .fetchRestaurantDetail(widget.id);
      Provider.of<RestaurantDetailNotifier>(context, listen: false)
          .loadFavoritStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.restaurantState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.restaurantState == RequestState.Loaded) {
            final restaurant = provider.restaurant;
            return SafeArea(
              child: DetailContent(
                restaurant,
                provider.isAddedToFavorit,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final RestaurantDetail restaurant;
  final bool isAddedFavorit;

  // ignore: use_key_in_widget_constructors
  const DetailContent(this.restaurant, this.isAddedFavorit);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // ignore: avoid_unnecessary_containers
        Container(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: '$BASE_IMAGE_URL${restaurant.pictureId}',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            restaurant.name,
                            style: kHeading5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!isAddedFavorit) {
                                await Provider.of<RestaurantDetailNotifier>(
                                        context,
                                        listen: false)
                                    .addFavorit(restaurant);
                              } else {
                                await Provider.of<RestaurantDetailNotifier>(
                                        context,
                                        listen: false)
                                    .removeFromFavorit(restaurant);
                              }

                              final message =
                                  Provider.of<RestaurantDetailNotifier>(context,
                                          listen: false)
                                      .favoritMessage;

                              if (message ==
                                      RestaurantDetailNotifier
                                          .favoritAddSuccessMessage ||
                                  message ==
                                      RestaurantDetailNotifier
                                          .favoritRemoveSuccessMessage) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    });
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isAddedFavorit
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                                //const Text('Favorit'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            size: 17,
                          ),
                          // ignore: unnecessary_string_interpolations
                          Text('${restaurant.city}')
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 17,
                          ),
                          // ignore: unnecessary_string_interpolations
                          Text('${restaurant.rating}')
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: kHeading6,
                      ),
                      Text(
                        restaurant.description,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Drink',
                        style: kHeading6,
                      ),
                      Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: restaurant.menus.drinks
                                  .map((minuman) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 8),
                                      child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(minuman.name),
                                      ))))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Foods',
                        style: kHeading6,
                      ),
                      Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: restaurant.menus.foods
                                  .map((makanan) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 8),
                                      child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(makanan.name),
                                      ))))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Customer Review',
                        style: kHeading6,
                      ),
                      Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: restaurant.customerReviews
                                  .map(
                                    (review) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 8),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text('Name : '),
                                                  Text(
                                                    review.name,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text('Review : '),
                                                  Text(
                                                    review.review,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text('Date : '),
                                                  Text(
                                                    review.date,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: const Color.fromARGB(255, 162, 103, 97),
                  height: 4,
                  width: 50,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: CircleAvatar(
            backgroundColor: kPrussianBlue,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
