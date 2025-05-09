import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/hotelsContent.dart';
import 'package:my_app/widgets/mainwidget.dart';
//import 'package:ui_5_travel_bag_app/product_detail.dart';

//import 'bagsmodel.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff40354C),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // double screenWidth = constraints.maxWidth;
          // double screenHeight = constraints.maxHeight;

          // //double x1 = screenWidth * 0.35; // 5% from left
          // double y1 = screenHeight * 0.10; // 5% from top

          return MainWidget(
            icontop: Icons.arrow_back_ios,
            title: 'Hotels',
            content: hotelsContent(),
            pad: false,
            contHeigt: 620,
            sizedboxHeigt: 10,
          );
        },
      ),
    );
  }
}
