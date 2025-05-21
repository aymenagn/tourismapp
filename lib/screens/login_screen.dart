import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/loginContent.dart';
import 'package:my_app/widgets/mainwidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff40354C),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // double screenWidth = constraints.maxWidth;
            // double screenHeight = constraints.maxHeight;
            // return MainWidget(title: 'title', content: Text('data'));
            return MainWidget(
              // icontop:,
              title: 'Log In',
              content: loginContent(),
              pad: true,
              contHeigt: _tool_ * 0.75010001,
              sizedboxHeigt: _tool_ * 0.1376000001,
            );
          },
        ),
      ),
    );
  }
}

// class StickyHeaderExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('444444')),
//       body: CustomScrollView(
//         slivers: [
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) => ListTile(title: Text('Item $index')),
//               childCount: 10,
//             ),
//           ),
//           // // AppBar
//           // SliverAppBar(
//           //   pinned: true,
//           //   expandedHeight: 100,
//           //   flexibleSpace: FlexibleSpaceBar(title: Text('Sticky Header')),
//           // ),

//           // Sticky Row (Pinned Header)
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: _StickyHeaderDelegate(
//               child: Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 8),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.generate(
//                       5,
//                       (index) => Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 4),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1974&auto=format&fit=crop',
//                             width: _ord_  * 0.1944444444444444,
//                             height: 70,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               height: 80,
//             ),
//           ),

//           // Scrollable body below the sticky header
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) => ListTile(title: Text('Item $index')),
//               childCount: 30,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // SliverPersistentHeaderDelegate to control the sticky widget
// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;

//   _StickyHeaderDelegate({required this.child, required this.height});

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return child;
//   }

//   @override
//   double get maxExtent => height;

//   @override
//   double get minExtent => height;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       true;
// }
