import 'package:flutter/material.dart';
import 'package:my_app/data/activities.dart';
import 'package:my_app/screens/activities/activities_screen.dart';

class categoriesActivitiesContent extends StatefulWidget {
  categoriesActivitiesContent({super.key});

  @override
  _categoriesActivitiesContentState createState() =>
      _categoriesActivitiesContentState();
}

class _categoriesActivitiesContentState
    extends State<categoriesActivitiesContent> {
  List<Category> displayCategory = [];

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 7 / 8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final cate = allCategories[index];
          return cardC(itemC: cate);
        },

        // return category=
        //     category
        //         .map(
        //           (categoryData) => Category(
        //             categoryData.id,
        //             categoryData.title,
        //             categoryData.imageUrl,
        //           ),
        //         )
        //         .toList(),
      ),
    );
  }
}

class cardC extends StatelessWidget {
  Category itemC;
  //  Activity itemA;
  cardC({super.key, required this.itemC});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => activitiesScreen(itemC)),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              '${itemC.imageUrl}',
              height: _tool_ * 0.3185,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error, color: Colors.red, size: 40),
                      SizedBox(height: 8),
                      Text(
                        'Image not available',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '${itemC.title}',
              style: TextStyle(fontSize: 20, color: Color(0xFFE3DFF5)),
            ),
          ),
        ],
      ),
    );
  }
}
