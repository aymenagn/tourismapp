import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/restaurants/restaurantsContent.dart';
import 'package:my_app/widgets/mainwidget.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff40354C),
      body: LayoutBuilder(
        builder: (context, constraints) {

          return MainWidget(
            icontop: Icons.arrow_back_ios,
            title: 'Restaurants',
            content: restaurantsContent(),
            pad: false,
            contHeigt: 620,
            sizedboxHeigt: 10,
          );
        },
      ),
    );
  }
}
