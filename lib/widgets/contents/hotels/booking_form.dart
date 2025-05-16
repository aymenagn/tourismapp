import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import for iOS-style widgets
import 'package:intl/intl.dart';
// Import the intl package

// Extract the BookingForm widget
class BookingForm extends StatefulWidget {
  const BookingForm({super.key,});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  DateTime? _fromDate = DateTime.now();
  DateTime? _toDate = DateTime.now().add(Duration(days: 1));
  int _adults = 1;
  int _children = 0;
  int _rooms = 1;

  double _totalPrice = 0; //jdid

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              onSurface: Colors.deepPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = pickedDate;
        } else {
          _toDate = pickedDate;
        }

        _calculateTotalPrice(); //jdid
      });
    }
  }

  // Function to increment counters
  void _increment(String type) {
    setState(() {
      switch (type) {
        case 'adults':
          _adults++;
          break;
        case 'children':
          _children++;
          break;
        case 'rooms':
          _rooms++;
          break;
      }

      _calculateTotalPrice(); //jdid
    });
  }

  // Function to decrement counters
  void _decrement(String type) {
    setState(() {
      switch (type) {
        case 'adults':
          if (_adults > 1) _adults--;
          break;
        case 'children':
          if (_children > 0) _children--;
          break;
        case 'rooms':
          if (_rooms > 1) _rooms--;
          break;
      }

      _calculateTotalPrice(); //jdid
    });
  }

  // Function to display the date range
  Widget get _dateRange {
    if (_fromDate != null && _toDate != null) {
      // Format the dates as day month
      String fromDay = _fromDate!.day.toString();

      String fromMonth = DateFormat('MMM').format(_fromDate!); //jdid
      // String fromMonth = _getMonthName(_fromDate!.month);
      String toDay = _toDate!.day.toString();

      String toMonth = DateFormat('MMM').format(_fromDate!); //jdid
      // String toMonth = _getMonthName(_toDate!.month);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              _showDateSelectionDialog_From(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'From',
                      style: TextStyle(color: Color(0xff000000), fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '$fromDay ',
                      style: TextStyle(
                        color: Color(0xff402662),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$fromMonth ',
                      style: TextStyle(color: Color(0xff000000), fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward),
          GestureDetector(
            onTap: () {
              _showDateSelectionDialog_To(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To',
                      style: TextStyle(color: Color(0xff000000), fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '$toDay ',
                      style: TextStyle(
                        color: Color(0xff402662),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$toMonth ',
                      style: TextStyle(color: Color(0xff000000), fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_fromDate != null) {
      String fromDay = _fromDate!.day.toString();

      String fromMonth = DateFormat('MMM').format(_fromDate!); //jdid
      // String fromMonth = _getMonthName(_fromDate!.month);
      return Text('$fromDay $fromMonth');
    } else {
      return Text('$_fromDate');
    }
  }

  // Helper function to get month name from month number
  String _getMonthName(int month) {
    return DateFormat(
      'MMM',
    ).format(DateTime(2025, month)); // Use intl to get month name//jdid
    /*switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }*/
  }

  // Function to calculate total price//jdid
  void _calculateTotalPrice() {
    //jdid
    const double basePricePerNight = 100.0; // Base price per night//jdid
    final int numberOfDays =
        _toDate != null &&
                _fromDate !=
                    null //jdid
            ? _toDate!
                .difference(_fromDate!)
                .inDays //jdid
            : 0; //jdid
    final double roomCost = _rooms * basePricePerNight * numberOfDays; //jdid
    final double adultCost =
        _adults * 20.0 * numberOfDays; // Example adult price//jdid
    final double childrenCost =
        _children * 10.0 * numberOfDays; // Example child price//jdid
    setState(() {
      //jdid
      _totalPrice = roomCost + adultCost + childrenCost; //jdid
      if (_totalPrice < 0) {
        //jdid
        _totalPrice = 0; //jdid
      } //jdid
    }); //jdid
  } //jdid

  @override //jdid
  void initState() {
    //jdid
    super.initState(); //jdid
    _calculateTotalPrice(); // Initial price calculation//jdid
  } //jdid

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 471,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Date Range Selection
            SizedBox(height: 30),
            Container(
              height: 91,
              width: 257,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Colors.black),
              ),
              child: _dateRange,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     _dateRange,
              //     // Text(
              //     //   _dateRange,
              //     //   style: TextStyle(
              //     //     color: _fromDate == null ? Colors.grey : Colors.black,
              //     //     fontSize: 16,
              //     //   ),
              //     // ),
              //     // const Icon(Icons.calendar_today, color: Colors.deepPurple),
              //   ],
              // ),
            ),
            const SizedBox(height: 20),
            // Adults
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '$_adults',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'Adults   (+18yrs)',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Color(0xff402662),
                      ),
                      onPressed: () => _decrement('adults'),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        color: Color(0xff402662),
                      ),
                      onPressed: () => _increment('adults'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Children
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '$_children',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'Children (-18yrs)',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Color(0xff402662),
                      ),
                      onPressed: () => _decrement('children'),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        color: Color(0xff402662),
                      ),
                      onPressed: () => _increment('children'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Rooms
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '$_rooms',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'Rooms                ',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Color(0xff402662),
                      ),
                      onPressed: () => _decrement('rooms'),
                    ),

                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        color: Color(0xff402662),
                      ),
                      onPressed: () => _increment('rooms'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30), //jdid
            // Total Price Display//jdid
            Row(
              //jdid
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //jdid
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //jdid
                Container(
                  //jdid
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 16,
                  ), //jdid
                  decoration: BoxDecoration(
                    //jdid
                    color: Colors.transparent, // Light gray background//jdid
                  ), //jdid
                  child: Column(
                    //jdid
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, //jdid
                    children: <Widget>[
                      //jdid
                      const Text(
                        //jdid
                        'Total:', //jdid
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ), //jdid
                      ), //jdid
                      Text(
                        //jdid
                        '\$${_totalPrice.toStringAsFixed(2)} USD', // Format to 2 decimal places//jdid
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color(0xff007EF2),
                        ), // Or any other color//jdid
                      ), //jdid
                    ], //jdid
                  ), //jdid
                ),
                // Book Now Button
                ElevatedButton(
                  onPressed: () {
                    _performBooking(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                      0xff402662,
                    ), // Button background color
                    foregroundColor: Color(0xffE3DFF5), // Text/icon color
                    minimumSize: const Size(120, 46), // Width, Height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Rounded corners
                    ),
                  ),

                  child: const Text('APPLY', style: TextStyle(fontSize: 15)),
                ),
              ], //jdid
            ), //jdid
          ],
        ),
      ),
    );
  }

  // Function to show a custom date range selection dialog
  void _showDateSelectionDialog_From(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Date Range'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('From'),
                    subtitle: Text(
                      _fromDate != null
                          ? "${_fromDate!.day}-${DateFormat('MMM').format(_fromDate!)}-${_fromDate!.year}" //jdid
                          //? "${_fromDate!.day}-${_getMonthName(_fromDate!.month)}-${_fromDate!.year}"
                          : 'Select From Date',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _fromDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (picked != null) {
                          setState(() {
                            _fromDate = picked;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_fromDate != null && _toDate != null) {
                      if (_toDate!.isAfter(_fromDate!)) {
                        Navigator.of(context).pop();
                      } else {
                        _showErrorDialog(
                          context,
                          "Please select a valid date range.",
                        );
                      }
                    } else if (_fromDate != null) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDateSelectionDialog_To(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Date Range'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('To'),
                    subtitle: Text(
                      _toDate != null
                          ? "${_toDate!.day}-${DateFormat('MMM').format(_toDate!)}-${_toDate!.year}" //jdid
                          // ? "${_toDate!.day}-${_getMonthName(_toDate!.month)}-${_toDate!.year}"
                          : 'Select To Date',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _toDate ?? _fromDate ?? DateTime.now(),
                          firstDate: _fromDate ?? DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (picked != null) {
                          setState(() {
                            _toDate = picked;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_fromDate != null && _toDate != null) {
                      if (_toDate!.isAfter(_fromDate!)) {
                        Navigator.of(context).pop();
                      } else {
                        _showErrorDialog(
                          context,
                          "Please select a valid date range.",
                        );
                      }
                    } else if (_fromDate != null) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to show an error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  // Function to perform booking and show confirmation
  void _performBooking(BuildContext context) {
    if (_fromDate == null || _toDate == null) {
      _showErrorDialog(context, "Please select a valid date range.");
      return;
    }
    if (_toDate!.isBefore(_fromDate!)) {
      _showErrorDialog(context, "Please select a valid date range.");
      return;
    }
    String dateRangeText = '';
    if (_fromDate != null && _toDate != null) {
      String fromDay = _fromDate!.day.toString();
      String fromMonth = DateFormat('MMM').format(_fromDate!);
      String toDay = _toDate!.day.toString();
      String toMonth = DateFormat('MMM').format(_toDate!);
      dateRangeText = '$fromDay $fromMonth - $toDay $toMonth';
    } else if (_fromDate != null) {
      String fromDay = _fromDate!.day.toString();
      String fromMonth = DateFormat('MMM').format(_fromDate!);
      dateRangeText = '$fromDay $fromMonth';
    } else {
      dateRangeText =
          'Not selected'; // Or handle the case where no date is selected
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ConfirmationbookingScreen(
    //         dateRange: dateRangeText,
    //         adults: _adults,
    //         children: _children,
    //         rooms: _rooms,
    //         totalPrice: _totalPrice,
    //       ),
    //     ),
    //   );
    
  // Format the dates for display
  String checkInDate = DateFormat('EEE, MMM d, y').format(_fromDate!);
  String checkOutDate = DateFormat('EEE, MMM d, y').format(_toDate!);
  String bookingDate = DateFormat('EEE, MMM d, y').format(DateTime.now());

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Booking Confirmation'),
            content: Text(
              'Your booking is confirmed for:\n'
              'Booking Date: $bookingDate\n' // Display the booking date
              'Check-in Date: $checkInDate\n' // Display the check-in date
              'Check-out Date: $checkOutDate\n' // Display the check-out date
              'Adults: $_adults\n'
              'Children: $_children\n'
              'Rooms: $_rooms\n'
              'Total Price: \$${_totalPrice.toStringAsFixed(2)} USD',

              semanticsLabel:
                  'Total Price: \$${_totalPrice.toStringAsFixed(2)} USD', //jdid
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
