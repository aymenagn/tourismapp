import 'package:flutter/material.dart';

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
    this.icontop,
    this.onprs,
  });

  // final double x1;
  final double sizedboxHeigt;
  final bool pad;
  final double contHeigt;
  final IconData? icontop;
  final VoidCallback? onprs;

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return ListView(
      children: [
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(
                left: _ord_ *0.0277777777777778,
                top: _tool_  * 0.0191082802547771,
              ),
              child: IconButton(
                onPressed: onprs,
                icon: Icon(icontop, color: Colors.white),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
                left: _ord_  * 0.1055555555555556,
                top: _tool_  * 0.0191082802547771,
              ),
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
            Container(
              width: _ord_,
              height: contHeigt,
              padding: EdgeInsets.only(
                top: pad ? 40 : 20,
                left: _ord_ *0.0277777777777778,
                right: _ord_  * 0.0277777777777778,
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
