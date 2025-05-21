class SpecialOffer {
  final String title;
  String? description;
  String? imageUrl;

  SpecialOffer({required this.title, this.description, this.imageUrl});
}

List<SpecialOffer> specialOffers = [
  SpecialOffer(
    title: '20% Off on All Pizzas',
    description: 'Enjoy a 20% discount on all pizza orders this weekend!',
    imageUrl: 'https://via.placeholder.com/350/F44336/FFFFFF?Text=Pizza+Offer',
  ),
  SpecialOffer(
    title: 'Free Drink with Burger',
    description: 'Get a free soft drink with every burger you order.',
    imageUrl: 'https://via.placeholder.com/350/FF9800/FFFFFF?Text=Burger+Offer',
  ),
  // Add more offers
];
