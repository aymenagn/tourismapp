// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart'; // For converting address to coordinates

// class RestaurantsScreennn extends StatefulWidget {
//   const RestaurantsScreennn({super.key});

//   @override
//   State<RestaurantsScreennn> createState() => _RestaurantsScreennnState();
// }

// class _RestaurantsScreennnState extends State<RestaurantsScreennn> {
//   TextEditingController locationController = TextEditingController();
//   String? selectedLocation;
//   List<Restaurant> allRestaurants = [
//     // Replace with your actual restaurant data
//     Restaurant(
//       name: 'Golden Avenue Diner',
//       latitude: 40.7128,
//       longitude: -74.0060,
//       address: '123 Golden Avenue, New York, USA',
//     ),
//     Restaurant(
//       name: 'Golden Avenue Pizza',
//       latitude: 40.7135,
//       longitude: -74.0055,
//       address: '456 Golden Avenue, New York, USA',
//     ),
//     Restaurant(
//       name: 'Another Place',
//       latitude: 36.1700,
//       longitude: 5.7000,
//       address: 'Some Street, El Eulma, Algeria',
//     ),
//     Restaurant(
//       name: 'Local Cuisine',
//       latitude: 36.1650,
//       longitude: 5.7050,
//       address: 'Another Road, El Eulma, Algeria',
//     ),
//     // Add more restaurants with their location data
//   ];
//   List<Restaurant> displayedRestaurants = [];
//   bool isSearching = false;
//   List<String> locationSuggestions =
//       []; // For autocomplete (requires a places API)

//   @override
//   void initState() {
//     super.initState();
//     displayedRestaurants.addAll(
//       allRestaurants,
//     ); // Initially show all restaurants
//   }

//   Future<Position?> _getCurrentLocation(BuildContext context) async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location permissions are denied')),
//         );
//         return null;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Location permissions are permanently denied, we cannot request permissions.',
//           ),
//         ),
//       );
//       return null;
//     }

//     try {
//       Position position = await Geolocator.getCurrentPosition();
//       return position;
//     } catch (e) {
//       print("Error getting location: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to get current location')),
//       );
//       return null;
//     }
//   }

//   void _useCurrentLocation(BuildContext context) async {
//     Position? position = await _getCurrentLocation(context);
//     if (position != null) {
//       try {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );
//         if (placemarks.isNotEmpty) {
//           Placemark place = placemarks.first;
//           String currentLocation =
//               '${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
//           setState(() {
//             locationController.text = currentLocation;
//             selectedLocation = currentLocation;
//             _filterRestaurantsByLocation(currentLocation);
//           });
//         } else {
//           setState(() {
//             locationController.text =
//                 'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
//             selectedLocation =
//                 'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
//             _filterRestaurantsByCoordinates(
//               position.latitude,
//               position.longitude,
//             );
//           });
//         }
//       } catch (e) {
//         print('Error during reverse geocoding: $e');
//         setState(() {
//           locationController.text =
//               'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
//           selectedLocation =
//               'Current Location (Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)})';
//           _filterRestaurantsByCoordinates(
//             position.latitude,
//             position.longitude,
//           );
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Could not determine exact address from current location.',
//             ),
//           ),
//         );
//       }
//     }
//   }

//   void _searchRestaurants(String query) async {
//     setState(() {
//       selectedLocation = query;
//       isSearching = true;
//       displayedRestaurants.clear();
//     });

//     try {
//       List<Location> locations = await locationFromAddress(query.trim());
//       if (locations.isNotEmpty) {
//         Location searchedLocation = locations.first;
//         _filterRestaurantsByCoordinates(
//           searchedLocation.latitude,
//           searchedLocation.longitude,
//         );
//       } else {
//         setState(() {
//           displayedRestaurants.clear();
//           isSearching = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'No location found for "${query.trim()}". Please check the spelling and try again.',
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error during geocoding: $e');
//       setState(() {
//         displayedRestaurants.clear();
//         isSearching = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Error searching for location. Please check your internet connection.',
//           ),
//         ),
//       );
//     } finally {
//       setState(() {
//         isSearching = false;
//       });
//     }
//   }

//   void _filterRestaurantsByLocation(String location) {
//     setState(() {
//       displayedRestaurants =
//           allRestaurants
//               .where(
//                 (restaurant) => restaurant.address.toLowerCase().contains(
//                   location.toLowerCase(),
//                 ),
//               )
//               .toList();
//     });
//   }

//   // More advanced filtering by proximity (you'll need to define a radius)
//   void _filterRestaurantsByCoordinates(double lat, double lng) {
//     const double searchRadius = 20.0; // Example radius in kilometers

//     setState(() {
//       displayedRestaurants =
//           allRestaurants.where((restaurant) {
//             double distanceInMeters = Geolocator.distanceBetween(
//               lat,
//               lng,
//               restaurant.latitude,
//               restaurant.longitude,
//             );
//             return distanceInMeters <=
//                 searchRadius * 1000; // Convert km to meters
//           }).toList();
//     });
//   }

//   // Example of a basic (non-functional without a places API) autocomplete implementation
//   void _onLocationChanged(String value) async {
//     // In a real app, you would call a places API here based on the 'value'
//     // and update the 'locationSuggestions' list.
//     // For this example, we'll just add a placeholder.
//     if (value.isNotEmpty) {
//       setState(() {
//         locationSuggestions =
//             allRestaurants
//                 .where(
//                   (r) => r.address.toLowerCase().contains(value.toLowerCase()),
//                 )
//                 .map((r) => r.address)
//                 .toList()
//                 .take(5)
//                 .toList();
//       });
//     } else {
//       setState(() {
//         locationSuggestions.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Find Restaurants')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: locationController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter Location',
//                       prefixIcon: const Icon(Icons.search),
//                       suffixIcon:
//                           locationController.text.isNotEmpty
//                               ? IconButton(
//                                 icon: const Icon(Icons.clear),
//                                 onPressed: () {
//                                   setState(() {
//                                     locationController.clear();
//                                     selectedLocation = null;
//                                     displayedRestaurants.clear();
//                                     displayedRestaurants.addAll(allRestaurants);
//                                     locationSuggestions.clear();
//                                   });
//                                 },
//                               )
//                               : null,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                     onChanged: _onLocationChanged,
//                     onSubmitted: (value) {
//                       _searchRestaurants(value);
//                       setState(() {
//                         locationSuggestions.clear();
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 10.0),
//                 IconButton(
//                   icon: const Icon(Icons.my_location),
//                   onPressed: () {
//                     _useCurrentLocation(context);
//                   },
//                 ),
//               ],
//             ),
//             if (locationSuggestions.isNotEmpty)
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: locationSuggestions.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(locationSuggestions[index]),
//                     onTap: () {
//                       setState(() {
//                         locationController.text = locationSuggestions[index];
//                         locationSuggestions.clear();
//                       });
//                       _searchRestaurants(locationController.text);
//                     },
//                   );
//                 },
//               ),
//             const SizedBox(height: 20.0),
//             if (selectedLocation != null)
//               Text(
//                 isSearching
//                     ? 'Searching restaurants in: $selectedLocation...'
//                     : 'Restaurants in: $selectedLocation',
//                 style: const TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             const SizedBox(height: 10.0),
//             if (displayedRestaurants.isNotEmpty)
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: displayedRestaurants.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Text(
//                         displayedRestaurants[index].name,
//                         style: const TextStyle(fontSize: 16.0),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             else if (selectedLocation != null && !isSearching)
//               const Text('No restaurants found in this location.'),
//             if (displayedRestaurants.isEmpty &&
//                 allRestaurants.isNotEmpty &&
//                 selectedLocation == null)
//               const Text('Showing all restaurants.'),
//             if (allRestaurants.isEmpty) const Text('No restaurants available.'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Restaurant {
//   final String name;
//   final double latitude;
//   final double longitude;
//   final String address;

//   Restaurant({
//     required this.name,
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//   });
// }
