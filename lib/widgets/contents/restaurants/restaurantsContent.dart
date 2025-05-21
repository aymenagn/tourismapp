import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/data/restaurants.dart';
import 'package:my_app/screens/restaurants/restaurantdetail_screen.dart';
// import 'package:my_app/screens/restaurants/restaurantdetail_screen.dart';

class restaurantsContent extends StatefulWidget {
  const restaurantsContent({super.key});

  @override
  _restaurantsContentState createState() => _restaurantsContentState();
}

class _restaurantsContentState extends State<restaurantsContent> {
  List<RestaurantItems> displayedRestaurants = [];
  String? selectedLocation = 'Algeria,Setif'; // Default location
  String? selectedName; // Default location
  String? selectedCuisine;
  String? currentSearchQuery;
  late LocationPermission _locationPermission;
  bool _isLocationEnabled = false;
  bool isSearching = false;
  List<String> nameSuggestions = []; // For autocomplete (requires a places API)
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationServicesAndPermissions();
  }

  Future<void> _checkLocationServicesAndPermissions() async {
    // Check if location services are enabled.
    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
      _showLocationDisabledDialog();
      return; // Return early if location services are disabled.
    } else {
      setState(() {
        if (!_isLocationEnabled) {
          displayedRestaurants =
              allRestaurants
                  .where((restaurant) => restaurant.address.contains('addi'))
                  .toList(); // Return early if location services are disabled.
        } else {
          displayedRestaurants =
              allRestaurants
                  .where(
                    (restaurant) =>
                        restaurant.address.contains('$selectedLocation'),
                  )
                  .toList();
        }
      });
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(content: Text('📍 $selectedLocation ')),
      );
    }

    // Check for location permissions.
    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied) {
      // Request permissions if they are denied.
      _locationPermission = await Geolocator.requestPermission();

      if (_locationPermission == LocationPermission.denied) {
        // Handle the case where the user denies permissions.
        _showLocationDeniedDialog();

        return;
      }
    }

    if (_locationPermission == LocationPermission.deniedForever) {
      // Handle the case where permissions are denied forever.
      _showLocationDeniedForeverDialog();
      return;
    }

    // If we get here, we have location services enabled and permissions granted.
    _getLocationAndFilterRestaurants(); //get location and load restaurants
  }

  void _showLocationDisabledDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Location Services Disabled'),
            content: const Text(
              'Please enable location services to use this feature.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  // Open location settings.  This uses a library.
                  Geolocator.openLocationSettings();
                  Navigator.pop(context);
                },
                child: const Text('Settings'),
              ),
            ],
          ),
    );
  }

  void _showLocationDeniedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Location Permission Denied'),
            content: const Text(
              'Permission to access your location was denied.  To use this feature, please allow location access.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
              // Add a button to go to app settings (optional, for more advanced handling)
            ],
          ),
    );
  }

  void _showLocationDeniedForeverDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Location Permission Denied Forever'),
            content: const Text(
              'Location permission is permanently denied.  Please enable it in your device settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  // Open app settings. This uses a library.
                  Geolocator.openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text('Settings'),
              ),
            ],
          ),
    );
  }

  Position? _locationUser;
  Future<void> _getLocationAndFilterRestaurants() async {
    if (!_isLocationEnabled ||
        (_locationPermission != LocationPermission.always &&
            _locationPermission != LocationPermission.whileInUse)) {
      // Handle the case where location is not available or permissions are denied.

      return;
    }

    try {
      // Get the user's current location.
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _locationUser = position;

      // Filter restaurants based on the user's location.
      _filterRestaurantsByProximity(position.latitude, position.longitude);
    } catch (e) {
      // Handle errors, such as location services being disabled.
      print("Error getting location: $e"); // Important: Log the error.
      _showErrorDialog("Error getting your location: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _allSearch() {
    final filteredByName =
        allRestaurants
            .where(
              (restaurant) => restaurant.name.toLowerCase().contains(
                currentSearchQuery!.toLowerCase(),
              ),
            )
            .toList();
    final filteredDispAll =
        filteredByName
            .where(
              (restaurant) => restaurant.address.contains('$selectedLocation'),
            )
            .toList();

    setState(() {
      displayedRestaurants = filteredDispAll;
    });
  }

  void _dispAll() {
    setState(() {
      displayedRestaurants =
          allRestaurants
              .where(
                (restaurant) =>
                    restaurant.address.contains('$selectedLocation'),
              )
              .toList();
    });
  }

  void _filterRestaurantsByCuisine(String cuisine) {
    setState(() {
      displayedRestaurants =
          allRestaurants
              .where((restaurant) => restaurant.cuisineType == cuisine)
              .toList();
      allRestaurants
          .where(
            (restaurant) => restaurant.address.contains('$selectedLocation'),
          )
          .toList();
      allRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
    });
  }

  void _filterNoCuisine() {
    setState(() {
      displayedRestaurants =
          allRestaurants
              .where((restaurant) => restaurant.address.contains('addi'))
              .toList();
    });
  }

  void _filterRestaurantsByProximity(
    double userLatitude,
    double userLongitude,
  ) {
    setState(() {
      displayedRestaurants =
          allRestaurants
              .map(
                (r) => RestaurantItems(
                  name: r.name,
                  latitude: r.latitude,
                  longitude: r.longitude,
                  address: r.address,
                  imageUrl: r.imageUrl,
                  rating: r.rating,
                  cuisineType: r.cuisineType,
                  distance: calculateDistance(
                    userLatitude,
                    userLongitude,
                    r.latitude,
                    r.longitude,
                  ),
                ),
              )
              .toList();

      // Now sort them based on distance (ascending)
      displayedRestaurants.sort((a, b) {
        if (a.distance == null || b.distance == null) return 0;
        return a.distance!.compareTo(b.distance!);
      });
    });
  }

  Future<void> _Proximitysearch(
    double userLatitude,
    double userLongitude,
  ) async {
    List<RestaurantItems> results;
    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
    } else {
      if (currentSearchQuery != null && currentSearchQuery!.isNotEmpty) {
        // Filter by name first
        results =
            allRestaurants
                .where(
                  (restaurant) => restaurant.name.toLowerCase().contains(
                    currentSearchQuery!.toLowerCase(),
                  ),
                )
                .toList();
      } else {
        // No search active, show all restaurants
        results = List.from(allRestaurants);
      }

      // Update each restaurant with its distance from user
      List<RestaurantItems> updatedResults =
          results.map((r) {
            double distance = calculateDistance(
              userLatitude,
              userLongitude,
              r.latitude,
              r.longitude,
            );
            return RestaurantItems(
              name: r.name,
              latitude: r.latitude,
              longitude: r.longitude,
              address: r.address,
              imageUrl: r.imageUrl,
              rating: r.rating,
              cuisineType: r.cuisineType,
              distance: distance, // ✅ Add calculated distance
            );
          }).toList();

      // Sort by distance
      updatedResults.sort((a, b) {
        if (a.distance == null || b.distance == null) return 0;
        return a.distance!.compareTo(b.distance!);
      });

      setState(() {
        displayedRestaurants =
            updatedResults; // ✅ Use updated list with distance
      });
    }
  }
  // void _filterRestaurantsByRating() {
  //   setState(() {
  //     displayedRestaurants =
  //         allRestaurants
  //             .where((restaurant) => restaurant.rating >= 4.5)
  //             .toList();
  //   });
  // }

  Future<void> _searchRestaurants(String query) async {
    setState(() {
      selectedName = query;
      currentSearchQuery = query; // Save it for later filtering
      isSearching = true;
      displayedRestaurants.clear();
    });

    final filteredByName =
        allRestaurants
            .where(
              (restaurant) => restaurant.name.toLowerCase().contains(
                query.trim().toLowerCase(),
              ),
            )
            .toList();

    final filteredByCuisineAndName =
        selectedCuisine != null
            ? filteredByName
                .where((r) => r.cuisineType == selectedCuisine)
                .toList()
            : filteredByName;

    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
    } else {
      if (filteredByCuisineAndName.isNotEmpty) {
        setState(() {
          displayedRestaurants = filteredByCuisineAndName;
          isSearching = false;
        });
      } else {
        setState(() {
          displayedRestaurants.clear();
          isSearching = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('No matches for "$query"')));
      }

      // else {
      //     setState(() {
      //       isSearching = false;
      //     });
      //   }
    }
  }

  void _onLocationChanged(String value) async {
    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
    } else {
      if (value.isNotEmpty) {
        setState(() {
          nameSuggestions =
              allRestaurants
                  .where(
                    (r) => r.name.toLowerCase().contains(
                      value.trim().toLowerCase(),
                    ),
                  )
                  .map((r) => r.name)
                  .toList()
                  .take(5)
                  .toList();
        });
      } else {
        setState(() {
          nameSuggestions.clear();
        });
      }
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // Distance in km
  }

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.only(left: _ord_ *0.0277777777777778, right: 10),
                  alignment: Alignment.center,
                  height: _tool_ * 0.0636942675159236,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(86, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Search :',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          nameController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() async {
                                    nameController.clear();
                                    selectedName = null;
                                    currentSearchQuery =
                                        null; // Clear stored search
                                    displayedRestaurants.clear();

                                    _isLocationEnabled =
                                        await Geolocator.isLocationServiceEnabled();
                                    if (!_isLocationEnabled) {
                                    } else {
                                      _dispAll();
                                    }

                                    nameSuggestions.clear();
                                  });
                                },
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: _onLocationChanged,
                    onSubmitted: (value) async {
                      _isLocationEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!_isLocationEnabled) {
                      } else {
                        _searchRestaurants(value);
                      }
                      setState(() {
                        nameSuggestions.clear();
                      });
                    },
                  ),
                  //  TextField(
                  //   // controller: searchController,
                  //   decoration: InputDecoration(
                  //     hintText: 'Search for restaurants or cuisines',
                  //     prefixIcon: Icon(Icons.search, color: Colors.black),
                  //     border: InputBorder.none,
                  //   ),
                  //   onSubmitted: (value) {
                  //     // _searchRestaurants(value);
                  //   },
                  // ),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                alignment: Alignment.center,
                height: _tool_ * 0.0636942675159236,
                width: _ord_ * 0.1388888888888889,
                decoration: const BoxDecoration(
                  color: Color(0xff402662),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.my_location),
                  color: Colors.white,
                  onPressed: () {
                    _checkLocationServicesAndPermissions();
                    // _useCurrentLocation(context);
                  },
                ),
              ),
            ],
          ),
        ),
        if (nameSuggestions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: nameSuggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(nameSuggestions[index]),
                onTap: () {
                  setState(() {
                    nameController.text = nameSuggestions[index];
                    nameSuggestions.clear();
                  });
                  _searchRestaurants(nameController.text);
                },
              );
            },
          ),
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!nameController.text.isNotEmpty)
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
                        TextButton(
                          onPressed: () {},
                          child: const Text('See All'),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: _ord_ * 0.0444444444444444,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            _isLocationEnabled =
                                await Geolocator.isLocationServiceEnabled();
                            if (!_isLocationEnabled) {
                              _filterNoCuisine();
                              _checkLocationServicesAndPermissions();
                            } else {
                              if (currentSearchQuery != null &&
                                  currentSearchQuery!.isNotEmpty) {
                                _allSearch();
                              } else {
                                // Normal behavior when no search is active
                                _dispAll();
                              }
                            }
                          },
                          child: const Text('All'),
                        ),
                        const SizedBox(width: 8.0),
                        OutlinedButton(
                          onPressed: () {
                            cuisPress('Italian');
                          },
                          child: const Text('Italian'),
                        ),
                        const SizedBox(width: 8.0),
                        OutlinedButton(
                          onPressed: () {
                            cuisPress('Mexican');
                          },
                          child: const Text('Mexican'),
                        ),
                        const SizedBox(width: 8.0),
                        OutlinedButton(
                          onPressed: () {
                            cuisPress('Chinese');
                          },
                          child: const Text('Chinese'),
                        ),
                        const SizedBox(width: 8.0),
                        OutlinedButton(
                          onPressed: () async {
                            _isLocationEnabled =
                                await Geolocator.isLocationServiceEnabled();
                            if (!_isLocationEnabled) {
                              _filterNoCuisine();
                              _checkLocationServicesAndPermissions();
                            } else {
                              if (currentSearchQuery != null &&
                                  currentSearchQuery!.isNotEmpty) {
                                _Proximitysearch(36.1700, 5.70000);
                              } else {
                                _filterRestaurantsByProximity(36.1700, 5.70000);
                              }
                            }
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
                      ],
                    ),
                  ),
                ),
                NewWidget(displayedRestaurants: displayedRestaurants),
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
        ),
      ],
    );
  }

  void cuisPress(String cuis) async {
    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
      _filterNoCuisine();
      _checkLocationServicesAndPermissions();
    } else {
      if (currentSearchQuery != null && currentSearchQuery!.isNotEmpty) {
        // Apply cuisine filter on top of search results
        final filteredByName =
            allRestaurants
                .where(
                  (restaurant) => restaurant.name.toLowerCase().contains(
                    currentSearchQuery!.toLowerCase(),
                  ),
                )
                .toList();

        final filteredByCuisine =
            filteredByName.where((r) => r.cuisineType == cuis).toList();

        setState(() {
          displayedRestaurants = filteredByCuisine;
        });
      } else {
        // Normal behavior when no search is active
        _filterRestaurantsByCuisine(cuis);
      }
    }
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key, required this.displayedRestaurants});

  final List<RestaurantItems> displayedRestaurants;

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayedRestaurants.length,
      itemBuilder: (context, index) {
        final restaurant = displayedRestaurants[index];

        return cardR(context, restaurant);
      },
    );
  }

  GestureDetector cardR(BuildContext context, RestaurantItems restaurant) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RestaurantdetailScreen(restaurant),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xff40354C), // Purple background
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            CachedNetworkImage(
              imageUrl: restaurant.imageUrl,
              height: _tool_ * 0.1910828025477707,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

            // Content Padding
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
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        '${restaurant.rating}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '(${restaurant.cuisineType})',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          color: Color(0xFF5D4CFF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white70,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (restaurant.distance != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.greenAccent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${restaurant.distance!.toStringAsFixed(2)} km',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // Example Data (In a real app, this would come from an API or database)
  // final List<RestaurantItems> allRestaurants = [
  //   Restaurant(
  //     name: 'Pizza Palace',
  //     latitude: 36.1720,
  //     longitude: 5.7020,
  //     address: '123 Main St, El Eulma',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     rating: 4.5,
  //     cuisineType: 'Italian',
  //   ),
  //   Restaurant(
  //     name: 'Tacos Place',
  //     latitude: 36.1740,
  //     longitude: 5.7040,
  //     address: '456 Taco Ave, El Eulma',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     rating: 4.2,
  //     cuisineType: 'Mexican',
  //   ),
  //   Restaurant(
  //     name: 'Burger Joint',
  //     latitude: 36.1680,
  //     longitude: 5.6980,
  //     address: '789 Burger Blvd, El Eulma',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     rating: 4.7,
  //     cuisineType: 'American',
  //   ),
  //   Restaurant(
  //     name: 'Pasta Paradise',
  //     latitude: 36.1710,
  //     longitude: 5.7010,
  //     address: '321 Pasta St, El Eulma',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     rating: 4.6,
  //     cuisineType: 'Italian',
  //   ),
  //   Restaurant(
  //     name: 'Tacos El Rey',
  //     latitude: 36.1755,
  //     longitude: 5.7055,
  //     address: '987 Fiesta Rd, El Eulma',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     rating: 4.4,
  //     cuisineType: 'Mexican',
  //   ),
  //   Restaurant(
  //     name: 'Chinese Wok',
  //     latitude: 36.1695,
  //     longitude: 5.6995,
  //     address: '654 Dragon Ln, El Eulma',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     rating: 4.3,
  //     cuisineType: 'Chinese',
  //   ),
  // ];

// class SpecialOffer {
//   final String title;
//   final String description;
//   final String imageUrl;

//   SpecialOffer({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//   });
// }

// class Cuisine {
//   final String name;
//   final String imageUrl;

//   Cuisine({required this.name, required this.imageUrl});
// }

// class Restaurant {
//   final String name;
//   final double latitude;
//   final double longitude;
//   final String address;
//   final String imageUrl;
//   final double rating;
//   final String cuisineType;

//   Restaurant({
//     required this.name,
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//     required this.imageUrl,
//     required this.rating,
//     required this.cuisineType,
//   });
// }

