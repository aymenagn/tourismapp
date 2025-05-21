import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:my_app/widgets/contents/homeContent.dart';
import 'package:my_app/widgets/mainwidget.dart';
//import 'package:ui_5_travel_bag_app/product_detail.dart';

//import 'bagsmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff40354C), //d-4
      body: LayoutBuilder(
        builder: (context, constraints) {
          // double screenWidth = constraints.maxWidth;
          // double screenHeight = constraints.maxHeight;

          // //double x1 = screenWidth * 0.35; // 5% from left
          // double y1 = screenHeight * 0.10; // 5% from top

          return MainWidget(
            icontop: Icons.menu,
            onprs: () {
              ZoomDrawer.of(context)!.toggle();
            },
            title: 'Home',
            content: homeContent(),
            pad: false,
            contHeigt: _tool_ * 0.66667,
            sizedboxHeigt: _tool_ * 0.1376111111,
          );
        },
      ),
    );
  }
}
