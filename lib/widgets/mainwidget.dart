import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    // required this.x1,
    // required this.y1,
    required this.title,
    required this.content,
    required this.pad,
    required this.contHeigt,
    required this.sizedboxHeigt,
    required this.icontop,
  });

  // final double x1;
  final double sizedboxHeigt;
  final bool pad;
  final double contHeigt;
  final IconData icontop;

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15),
              child: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: Icon(icontop, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 38.0, top: 15),
              child: Text(
                title,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE3DFF5),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: sizedboxHeigt),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(height: 8),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: contHeigt,
              padding: EdgeInsets.only(
                top: pad ? 40 : 20,
                left: 10,
                right: 10,
                bottom: 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffE3DFF5), Color(0xff40354C)],
                ),
              ),
              child: content,
            ),
            //),
          ],
        ),
      ],
    );
  }
}
