import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestaurantsScreenn extends StatefulWidget {
  const RestaurantsScreenn({super.key});

  @override
  State<RestaurantsScreenn> createState() => _RestaurantsScreennState();
}

class _RestaurantsScreennState extends State<RestaurantsScreenn> {
  TextEditingController searchController = TextEditingController();
  String? selectedLocation;
  List<Restaurant> allRestaurants = [];
  List<Restaurant> displayedRestaurants = [];
  List<SpecialOffer> specialOffers = [];
  List<Cuisine> cuisines = [];
  int _currentOfferIndex = 0;

  @override
  void initState() {
    super.initState();
    // Placeholder data - replace with your actual data fetching logic
    allRestaurants = [
      Restaurant(
        name: 'Golden Avenue Diner',
        latitude: 40.7128,
        longitude: -74.0060,
        address: '123 Golden Avenue, New York, USA',
        imageUrl: 'https://via.placeholder.com/300/FFC107/000000?Text=Diner',
        rating: 4.2,
        cuisineType: 'American',
      ),
      Restaurant(
        name: 'Golden Avenue Pizza',
        latitude: 40.7135,
        longitude: -74.0055,
        address: '456 Golden Avenue, New York, USA',
        imageUrl: 'https://via.placeholder.com/300/F44336/FFFFFF?Text=Pizza',
        rating: 4.5,
        cuisineType: 'Italian',
      ),
      Restaurant(
        name: 'Spicy Wok',
        latitude: 36.1700,
        longitude: 5.7000,
        address: 'Some Street, El Eulma, Algeria',
        imageUrl: 'https://via.placeholder.com/300/4CAF50/FFFFFF?Text=Chinese',
        rating: 4.8,
        cuisineType: 'Chinese',
      ),
      Restaurant(
        name: 'Tacos El Primo',
        latitude: 36.1650,
        longitude: 5.7050,
        address: 'Another Road, El Eulma, Algeria',
        imageUrl: 'https://via.placeholder.com/300/3F51B5/FFFFFF?Text=Mexican',
        rating: 4.1,
        cuisineType: 'Mexican',
      ),
      // Add more restaurants
    ];
    displayedRestaurants.addAll(allRestaurants);
    specialOffers = [
      SpecialOffer(
        title: '20% Off on All Pizzas',
        description: 'Enjoy a 20% discount on all pizza orders this weekend!',
        imageUrl:
            'https://via.placeholder.com/350/F44336/FFFFFF?Text=Pizza+Offer',
      ),
      SpecialOffer(
        title: 'Free Drink with Burger',
        description: 'Get a free soft drink with every burger you order.',
        imageUrl:
            'https://via.placeholder.com/350/FF9800/FFFFFF?Text=Burger+Offer',
      ),
      // Add more offers
    ];
    cuisines = [
      Cuisine(
        name: 'Italian',
        imageUrl: 'https://via.placeholder.com/80/F44336/FFFFFF?Text=Italian',
      ),
      Cuisine(
        name: 'Mexican',
        imageUrl: 'https://via.placeholder.com/80/3F51B5/FFFFFF?Text=Mexican',
      ),
      Cuisine(
        name: 'Chinese',
        imageUrl: 'https://via.placeholder.com/80/4CAF50/FFFFFF?Text=Chinese',
      ),
      Cuisine(
        name: 'American',
        imageUrl: 'https://via.placeholder.com/80/FFC107/000000?Text=American',
      ),
      // Add more cuisines
    ];
  }

  Future<Position?> _getCurrentLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      print("Error getting location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get current location')),
      );
      return null;
    }
  }

  void _useCurrentLocation(BuildContext context) async {
    Position? position = await _getCurrentLocation(context);
    if (position != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          String currentLocation =
              '${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
          setState(() {
            searchController.text = currentLocation;
            selectedLocation = currentLocation;
            _filterRestaurantsByProximity(
              position.latitude,
              position.longitude,
            );
          });
        } else {
          setState(() {
            searchController.text =
                'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
            selectedLocation =
                'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
            _filterRestaurantsByProximity(
              position.latitude,
              position.longitude,
            );
          });
        }
      } catch (e) {
        print('Error during reverse geocoding: $e');
        setState(() {
          searchController.text =
              'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
          selectedLocation =
              'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
          _filterRestaurantsByProximity(position.latitude, position.longitude);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not determine exact address from current location.',
            ),
          ),
        );
      }
    }
  }

  void _searchRestaurants(String query) async {
    setState(() {
      selectedLocation = query;
      displayedRestaurants.clear();
    });

    try {
      List<Location> locations = await locationFromAddress(query.trim());
      if (locations.isNotEmpty) {
        Location searchedLocation = locations.first;
        _filterRestaurantsByProximity(
          searchedLocation.latitude,
          searchedLocation.longitude,
        );
      } else {
        setState(() {
          displayedRestaurants.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No location found for "${query.trim()}". Please check the spelling and try again.',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error during geocoding: $e');
      setState(() {
        displayedRestaurants.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error searching for location. Please check your internet connection.',
          ),
        ),
      );
    }
  }

  void _filterRestaurantsByCuisine(String cuisine) {
    setState(() {
      displayedRestaurants =
          allRestaurants
              .where(
                (r) => r.cuisineType.toLowerCase() == cuisine.toLowerCase(),
              )
              .toList();
    });
  }

  void _filterRestaurantsByProximity(
    double lat,
    double lng, {
    double radius = 10.0,
  }) {
    setState(() {
      displayedRestaurants =
          allRestaurants.where((restaurant) {
            double distanceInMeters = Geolocator.distanceBetween(
              lat,
              lng,
              restaurant.latitude,
              restaurant.longitude,
            );
            return distanceInMeters <= radius * 1000; // Convert km to meters
          }).toList();
    });
  }

  void _filterRestaurantsByRating() {
    setState(() {
      displayedRestaurants =
          allRestaurants.where((r) => r.rating >= 4.5).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Discover Restaurants'),
        backgroundColor: Colors.purple[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for restaurants or cuisines',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onSubmitted: (value) {
                        _searchRestaurants(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () {
                      _useCurrentLocation(context);
                    },
                  ),
                ],
              ),
            ),
            if (specialOffers.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Special Offers',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('See All')),
                  ],
                ),
              ),
              CarouselSlider(
                items:
                    specialOffers.map((offer) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: offer.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    offer.description,
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentOfferIndex = index;
                    });
                  },
                ),
              ),
              if (specialOffers.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: specialOffers.length,
                      // position: _currentOfferIndex,
                      decorator: DotsDecorator(
                        color: Colors.grey,
                        activeColor: Colors.purple,
                        size: const Size.square(8.0),
                        activeSize: const Size(16.0, 8.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
            if (cuisines.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cuisines',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('See All')),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cuisines.length,
                  itemBuilder: (context, index) {
                    final cuisine = cuisines[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: CachedNetworkImageProvider(
                              cuisine.imageUrl,
                            ),
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            cuisine.name,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Restaurants',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('See All')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          displayedRestaurants = allRestaurants;
                        });
                      },
                      child: const Text('All'),
                    ),
                    const SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        _filterRestaurantsByCuisine('Italian');
                      },
                      child: const Text('Italian'),
                    ),
                    const SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        _filterRestaurantsByCuisine('Mexican');
                      },
                      child: const Text('Mexican'),
                    ),
                    const SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        _filterRestaurantsByCuisine('Chinese');
                      },
                      child: const Text('Chinese'),
                    ),
                    const SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        _filterRestaurantsByProximity(
                          36.1700,
                          5.7000,
                        ); // Example for El Eulma
                      },
                      child: const Text('Nearest'),
                    ),
                    const SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        // Implement logic for great offers
                      },
                      child: const Text('Great Offers'),
                    ),
                    const SizedBox(width: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        _filterRestaurantsByRating();
                      },
                      child: const Text('Ratings 4.5+'),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = displayedRestaurants[index];
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: restaurant.imageUrl,
                          height: 150.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${restaurant.rating}',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  '(${restaurant.cuisineType})',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              restaurant.address,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF757575),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (displayedRestaurants.isEmpty && allRestaurants.isNotEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No restaurants found based on your criteria.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            if (allRestaurants.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No restaurants available.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class SpecialOffer {
  final String title;
  final String description;
  final String imageUrl;

  SpecialOffer({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class Cuisine {
  final String name;
  final String imageUrl;

  Cuisine({required this.name, required this.imageUrl});
}

class Restaurant {
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String imageUrl;
  final double rating;
  final String cuisineType;

  Restaurant({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.cuisineType,
  });
}
