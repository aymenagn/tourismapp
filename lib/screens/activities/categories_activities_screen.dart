import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/activities/categories_activitiesContent.dart';
import 'package:my_app/widgets/contents/hotels/hotelsContent.dart';
import 'package:my_app/widgets/mainwidget.dart';
//import 'package:ui_5_travel_bag_app/product_detail.dart';

//import 'bagsmodel.dart';

class categoriesActivitiesScreen extends StatelessWidget {
  const categoriesActivitiesScreen({super.key});

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
            title: 'Activities',
            content: categoriesActivitiesContent(),
            pad: false,
            contHeigt: _tool_ * 0.7835,
            sizedboxHeigt: _tool_ * 0.0229,
          );
        },
      ),
    );
  }
}
