import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/data/restaurants.dart';
// import 'package:my_app/screens/restaurants/restaurantdetail_screen.dart';

class restaurantsContentt extends StatefulWidget {
  const restaurantsContentt({super.key});

  @override
  _restaurantsContenttState createState() => _restaurantsContenttState();
}

class _restaurantsContenttState extends State<restaurantsContentt> {
  List<RestaurantItems> displayedRestaurants = [];
  String selectedLocation = 'El Eulma'; // Default location
  late LocationPermission _locationPermission;
  bool _isLocationEnabled = false;
  final Map<String, bool> _cuisineFilters = {
    // Map to hold cuisine filters111
    'All': true,
    'Italian': false,
    'Mexican': false,
    'Chinese': false,
  };

  @override
  void initState() {
    super.initState();
    _checkLocationServicesAndPermissions();
    _filterAndDisplayRestaurants(); // Initial filtering 111
  }

  Future<void> _checkLocationServicesAndPermissions() async {
    // Check if location services are enabled.
    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
      _showLocationDisabledDialog();
      return; // Return early if location services are disabled.
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              content: Text('Your location Enabled $_locationUser '),
            ),
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

  void _filterRestaurantsByProximity(
    double userLatitude,
    double userLongitude,
  ) {
    // In a real app, you'd use the Haversine formula or a dedicated library
    // to calculate the distance between the user's location and each restaurant.
    // This is a simplified example that sorts by a rough approximation of distance.

    //  Approximation (Not accurate for large distances or near the poles):
    List<RestaurantItems> sortedRestaurants = List.from(allRestaurants); //copy
    sortedRestaurants.sort((a, b) {
      final distanceA =
          (a.latitude - userLatitude).abs() +
          (a.longitude - userLongitude).abs();
      final distanceB =
          (b.latitude - userLatitude).abs() +
          (b.longitude - userLongitude).abs();
      return distanceA.compareTo(distanceB);
    });

    setState(() {
      displayedRestaurants = sortedRestaurants;
    });
  }

  void _filterAndDisplayRestaurants() {
    setState(() {
      List<RestaurantItems> filteredList = [];

      if (_cuisineFilters['All'] == true) {
        filteredList = allRestaurants;
      } else {
        _cuisineFilters.forEach((cuisine, isSelected) {
          if (isSelected && cuisine != 'All') {
            filteredList.addAll(
              allRestaurants.where(
                (restaurant) => restaurant.cuisineType == cuisine,
              ),
            );
          }
        });
      }

      displayedRestaurants = filteredList;
    });
  }

  void _filterRestaurantsByRating() {
    setState(() {
      // 1. Filter restaurants with rating >= 4.5
      List<RestaurantItems> filteredList =
          allRestaurants
              .where((restaurant) => restaurant.rating >= 4.5)
              .toList();
      // 2. Sort the filtered list by rating (descending order)
      filteredList.sort(
        (a, b) => b.rating.compareTo(a.rating),
      ); // Sort Descending
      displayedRestaurants = filteredList;
    });
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
                  padding:  EdgeInsets.only(
                    left: _ord_ * 0.0277777777777778,
                    right: _ord_ * 0.0277777777777778,
                  ),
                  alignment: Alignment.center,
                  height: _tool_ * 0.0636942675159236,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    // controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for restaurants or cuisines',
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.my_location),
                        onPressed: () {
                          _checkLocationServicesAndPermissions();
                          // _useCurrentLocation(context);
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      // _searchRestaurants(value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DEF8),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Cancel'),
                                ),
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Reset'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Sort By
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sort By",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: 'Price Lower to Higher',
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items:
                                  [
                                        'Price Lower to Higher',
                                        'Price Higher to Lower',
                                        'Rating Higher to Lower',
                                      ]
                                      .map(
                                        (value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('\$ - \$\$  $value'),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 20),
                            // Ratings
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ratings",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (index) {
                                int rating = index + 1;
                                bool isSelected = rating == 4;
                                return Container(
                                  width: _ord_ * 0.1388888888888889,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Color(0xFF4A235A)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$rating',
                                        style: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color:
                                            isSelected
                                                ? Colors.yellow
                                                : Colors.grey,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),
                            // Price Range
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Price Ranges",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            RangeSlider(
                              values: RangeValues(90, 350),
                              min: 0,
                              max: 500,
                              divisions: 100,
                              activeColor: Color(0xFF4A235A),
                              onChanged: (values) {},
                            ),
                            Text("\$90 - \$350"),
                            SizedBox(height: 20),
                            //Cuisine
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Cuisines",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 8.0, // gap between adjacent chips
                              runSpacing: 4.0, // gap between lines
                              children:
                                  _cuisineFilters.keys.map((String cuisine) {
                                    return FilterChip(
                                      label: Text(cuisine),
                                      selected: _cuisineFilters[cuisine]!,
                                      onSelected: (bool? selected) {
                                        if (selected != null) {
                                          // null check
                                          setState(() {
                                            _cuisineFilters[cuisine] = selected;
                                            if (cuisine == 'All') {
                                              _cuisineFilters.forEach((
                                                key,
                                                value,
                                              ) {
                                                if (key != 'All') {
                                                  _cuisineFilters[key] = false;
                                                }
                                              });
                                              _cuisineFilters['All'] = true;
                                            } else {
                                              _cuisineFilters['All'] = false;
                                            }
                                            _filterAndDisplayRestaurants();
                                          });
                                        }
                                      },
                                      selectedColor: Color(0xFF4A235A),
                                      labelStyle: TextStyle(
                                        color:
                                            _cuisineFilters[cuisine]!
                                                ? Colors.white
                                                : null,
                                      ),
                                    );
                                  }).toList(),
                            ),
                            SizedBox(height: 20),
                            // Apply Button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4A235A),
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text("APPLY"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: _tool_ * 0.0636942675159236,
                  width: _ord_ * 0.1388888888888889,
                  decoration: const BoxDecoration(
                    color: Color(0xff402662),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.tune, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: _tool_ * 0.1910828025477707,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        const Icon(Icons.star, color: Colors.amber, size: 16.0),
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
    );
  }
}
