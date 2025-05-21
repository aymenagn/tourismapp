import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/restaurants/restaurantsContent.dart';
import 'package:my_app/widgets/mainwidget.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff40354C),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return MainWidget(
            icontop: Icons.arrow_back_ios,
            onprs: () {
              Navigator.pop(context);
            },
            title: 'Restaurants',
            content: restaurantsContent(),
            pad: false,
            contHeigt: _tool_ * 0.7835,
            sizedboxHeigt: _tool_ * 0.0229,
          );
        },
      ),
    );
  }
}
