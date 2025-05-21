import 'package:flutter/material.dart';

class ConfirmationbookingScreen extends StatefulWidget {
  final String bookingDate;
  final String checkInDate;
  final String checkOutDate;
  final int adults;
  final int children;
  final int rooms;
  final double totalPrice;

  const ConfirmationbookingScreen({
    super.key,
    required this.bookingDate,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.rooms,
    required this.totalPrice,
  });
  @override
  _ConfirmationbookingScreenState createState() => _ConfirmationbookingScreenState();
}

class _ConfirmationbookingScreenState extends State<ConfirmationbookingScreen> {
  

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Scaffold(
      backgroundColor: Color(0xFFE3DFF5),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Color(0xFFE3DFF5),
        title: Text(
          'Booking Confirmation',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: _ord_ * 0.2777777777777778,
                  height: _tool_ * 0.1019108280254777,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/hotel_1.png',
                      ), // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'AYANA Resort',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bali, Indonesia',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\$350 USD /night',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: _ord_ * 0.0555555555555556,
              ), // You can adjust the value
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Booking Date', widget.bookingDate),
                  _buildInfoRow('Check-in', widget.checkInDate),
                  _buildInfoRow('Check-out', widget.checkOutDate),
                  _buildInfoRow('Adults', '${widget.adults}'),
                  _buildInfoRow('Children', '${widget.children}'),
                  _buildInfoRow('Room(s)', '${widget.rooms}'),
                ],
              ),
            ),

            const SizedBox(height: 24.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: _ord_ * 0.0555555555555556,
              ), // You can adjust the value
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAmountRow('Amount', '\$350 x 2'),
                  _buildAmountRow('Tax', '\$30'),
                  _buildTotalRow('Total', '\$730'),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue to payment logic
                  print('Continue to Payment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:  EdgeInsets.symmetric(
                    vertical: _tool_ * 0.0203821656050955,
                  ),
                  textStyle: const TextStyle(fontSize: 16.0),
                ),
                child: const Text(
                  'CONTINUE TO PAYMENT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: _tool_ * 0.0103821656050955,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(label), Text(value)],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: _tool_ * 0.0103821656050955,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
