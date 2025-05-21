import 'package:flutter/material.dart';
import 'package:my_app/data/activities.dart';
import 'package:my_app/screens/activities/activitydetail_screen.dart';

class activitiesContent extends StatefulWidget {
  Category itemC;
  activitiesContent(this.itemC, {super.key});

  @override
  _activitiesContentState createState() => _activitiesContentState();
}

class _activitiesContentState extends State<activitiesContent> {
  //  final filteredActivities = allActivities
  //   .where((activity) => activity.categories!.contains(itemC.id))
  //   .toList();

  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "The Activities of ${widget.itemC.title} : ",
                      style: TextStyle(
                        fontSize: 19,
                        color: Color(0xff180226),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _tool_ / 1.422719,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount:
                      allActivities
                          .where(
                            (a) => a.categories!.contains('${widget.itemC.id}'),
                          )
                          .length,
                  itemBuilder: (context, index) {
                    final activity =
                        allActivities
                            .where(
                              (a) =>
                                  a.categories!.contains('${widget.itemC.id}'),
                            )
                            .toList()[index];
                    return cardA(itemA: activity);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class cardA extends StatelessWidget {
  Activity itemA;

  cardA({super.key, required this.itemA});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ActivitydetailScreen(itemA)),
        );
      },
      child: Card(
        color: Color(0xff40354C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 7,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    '${itemA.imageUrl}',
                    height: _tool_ * 0.2547770700636943,
                    width: double.infinity,
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
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: _tool_ * 0.2547770700636943,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.symmetric(
                    vertical: _tool_ * 0.0127388535031847,
                    horizontal: _ord_ * 0.0555555555555556,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: [0.4, 1],
                    ),
                  ),
                  child: Text(
                    '${itemA.title}',
                    style: TextStyle(
                      color: Color(0xFFE8DEF8),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.today, color: Colors.amber),
                      SizedBox(width: 6),
                      Text(
                        '${itemA.duration} Days',
                        style: TextStyle(color: Color(0xFFE8DEF8)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.amber),
                      SizedBox(width: 6),
                      Text(
                        '${itemA.season}',
                        style: TextStyle(color: Color(0xFFE8DEF8)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.family_restroom, color: Colors.amber),
                      SizedBox(width: 6),
                      Text(
                        '${itemA.activityType}',
                        style: TextStyle(color: Color(0xFFE8DEF8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
