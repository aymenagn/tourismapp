import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import for iOS-style widgets

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;
  int _adults = 2;
  int _children = 1;
  int _rooms = 1;

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        // Optional: For theming the date picker
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.deepPurple, // Day text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple, // Button text color
              ),
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
    });
  }

  // Function to display the date range
  String get _dateRange {
    if (_fromDate != null && _toDate != null) {
      // Format the dates as day month
      String fromDay = _fromDate!.day.toString();
      String fromMonth = _getMonthName(_fromDate!.month);
      String toDay = _toDate!.day.toString();
      String toMonth = _getMonthName(_toDate!.month);
      return '$fromDay $fromMonth - $toDay $toMonth';
    } else if (_fromDate != null) {
      String fromDay = _fromDate!.day.toString();
      String fromMonth = _getMonthName(_fromDate!.month);
      return '$fromDay $fromMonth';
    } else {
      return 'Select Dates';
    }
  }

  // Helper function to get month name from month number
  String _getMonthName(int month) {
    switch (month) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Your Stay',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Date Range Selection
            GestureDetector(
              // Use GestureDetector for custom styling and behavior
              onTap: () {
                _showDateSelectionDialog(context); // Show custom dialog
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple.shade50,
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _dateRange,
                      style: TextStyle(
                        color:
                            _fromDate == null
                                ? Colors.grey
                                : Colors.black, //change color
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.deepPurple),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Adults
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Adults (+18yrs)', style: TextStyle(fontSize: 18.0)),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Colors.deepPurple,
                      ), // iOS style
                      onPressed: () => _decrement('adults'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '$_adults',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => _increment('adults'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Children
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Children (-18yrs)',
                  style: TextStyle(fontSize: 18.0),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => _decrement('children'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '$_children',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => _increment('children'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Rooms
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Rooms', style: TextStyle(fontSize: 18.0)),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => _decrement('rooms'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '$_rooms',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.add_circled,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => _increment('rooms'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                //  Implement booking logic here
                _performBooking(context);
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a custom date range selection dialog
  void _showDateSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder to manage state within the dialog.
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
                          ? "${_fromDate!.day}-${_getMonthName(_fromDate!.month)}-${_fromDate!.year}"
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
                  ListTile(
                    title: const Text('To'),
                    subtitle: Text(
                      _toDate != null
                          ? "${_toDate!.day}-${_getMonthName(_toDate!.month)}-${_toDate!.year}"
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
                        // Show an error message if the To date is before the From date.
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

    //  Perform booking logic here (e.g., send data to a server)
    //  For this example, we'll just show a confirmation dialog.
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Booking Confirmation'),
            content: Text(
              'Your booking is confirmed for:\n'
              'Date Range: ${_dateRange}\n'
              'Adults: $_adults\n'
              'Children: $_children\n'
              'Rooms: $_rooms',
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
