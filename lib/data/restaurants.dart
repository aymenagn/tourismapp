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

class RestaurantItems {
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String imageUrl;
  final double rating;
  final String cuisineType;
  final double? distance;
  String? description;
  String? numbre;
  String? fb;
  String? ig;

  RestaurantItems({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.cuisineType,
    this.distance, // This is now optional
    this.description,
    this.numbre,
    this.fb,
    this.ig,
  });
}

final List<RestaurantItems> allRestaurants = [
  RestaurantItems(
    name: 'Pizza Palace',
    latitude: 36.1720,
    longitude: 5.7020,
    address: '750,Algeria,Setif',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    rating: 4.5,
    cuisineType: 'Italian',
    description:
        "Disc........................................................................................................................................................................................................................................................................................................................................................................................................................",
    numbre: '29999909',
    fb: 'Yacine Blh',
    ig: 'ur_.aymen',
  ),
  RestaurantItems(
    name: 'Tacos Place',
    latitude: 36.1740,
    longitude: 5.7040,
    address: '456 Taco Ave, Algeria,Setif',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    rating: 4.2,
    cuisineType: 'Mexican',
    description:
        "Disc........................................................................................................................................................................................................................................................................................................................................................................................................................",
    numbre: '29999909',
    fb: 'Yacine Blh',
    ig: 'ur_.aymen',
  ),
  RestaurantItems(
    name: 'Burger Joint',
    latitude: 36.1680,
    longitude: 5.6980,
    address: '789 Burger Blvd, Algeria,Setif',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    rating: 4.7,
    cuisineType: 'American',
    description:
        "Disc........................................................................................................................................................................................................................................................................................................................................................................................................................",
    numbre: '29999909',
    fb: 'Yacine Blh',
    ig: 'ur_.aymen',
  ),
  RestaurantItems(
    name: 'Pasta Paradise',
    latitude: 36.1710,
    longitude: 5.7010,
    address: '321 Pasta St, Algeria,Setif',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    rating: 4.6,
    cuisineType: 'Italian',
    description:
        "Disc........................................................................................................................................................................................................................................................................................................................................................................................................................",
    numbre: '29999909',
    fb: 'Yacine Blh',
    ig: 'ur_.aymen',
  ),
  RestaurantItems(
    name: 'Tacos El Rey',
    latitude: 36.1755,
    longitude: 5.7055,
    address: '987 Fiesta Rd, Algeria,Setif',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    rating: 4.4,
    cuisineType: 'Mexican',
    description:
        "Disc........................................................................................................................................................................................................................................................................................................................................................................................................................",
    numbre: '29999909',
    fb: 'Yacine Blh',
    ig: 'ur_.aymen',
  ),
  RestaurantItems(
    name: 'Chinese Wok',
    latitude: 36.1695,
    longitude: 5.6995,
    address: '654 Dragon Ln, Algeria,Setif',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    rating: 4.3,
    cuisineType: 'Chinese',
    description:
        "Disc........................................................................................................................................................................................................................................................................................................................................................................................................................",
    numbre: '29999909',
    fb: 'Yacine Blh',
    ig: 'ur_.aymen',
  ),
];
