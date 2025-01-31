import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curve_navbar/mainScreen_Navbar/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/seat_status.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, required this.movieTitle});
  final String movieTitle;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  Future addTicketDetails(String movieName, List<String> selectedSeats,
      DateTime date, int numberOfTickets) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Save data to Firestore in a subcollection under the user's email
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(user.email) // Document for the user
          .collection('UserTickets') // Subcollection for tickets
          .add(
        {
          'Movie name': movieName,
          'seats number': selectedSeats,
          'Date': date,
          'Number of Tickets': numberOfTickets,
          'Timestamp': FieldValue.serverTimestamp(), // For sorting
        },
      );
    }
  }

  final List<DateTime> dates =
      List.generate(15, (index) => DateTime.now().add(Duration(days: index)));
  DateTime selectedDate = DateTime.now();
  List<String> numRow = ['A', 'B', 'C', 'D', 'E', 'F'];
  List<String> selectedSeats = [];
  List<String> reservedSeats = [
    'A3',
    'B7',
    'C2',
    'C3',
    'E2',
    'E3',
    'E6',
    'E7',
    'E8',
    'F4'
  ];
  List<String> availableTime = [
    '10:00',
    '12:30',
    '14:30',
    '15:30',
    '16:30',
    '19:00',
    '21:30'
  ]; // Placeholder times

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c1c27),
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Select Seats",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Welcome Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: welcomeBorder(context),
          ),

          const SizedBox(height: 20),

          // Seat Selection
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(numRow.length, (colIndex) {
                    int numCol =
                        (colIndex == 0 || colIndex == numRow.length - 1)
                            ? 6
                            : 8;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(numCol, (rowIndex) {
                          String seatNum = '${numRow[colIndex]}${rowIndex + 1}';
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedSeats.contains(seatNum)) {
                                  selectedSeats.remove(seatNum);
                                } else if (!reservedSeats.contains(seatNum)) {
                                  selectedSeats.add(seatNum);
                                }
                              });
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              margin: EdgeInsets.only(
                                right:
                                    (rowIndex == (numCol ~/ 2) - 1) ? 30 : 10,
                              ),
                              decoration: BoxDecoration(
                                color: reservedSeats.contains(seatNum)
                                    ? Colors.white
                                    : selectedSeats.contains(seatNum)
                                        ? const Color(0xFFffb43b)
                                        : const Color(0xFF373741),
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                              child: Center(
                                  child: Text(
                                seatNum,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: reservedSeats.contains(seatNum)
                                      ? Colors.black
                                      : selectedSeats.contains(seatNum)
                                          ? Colors.black
                                          : Colors.white,
                                ),
                              )),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),

                  // Seat Legend
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SeatStatus(color: Color(0xFF373741), status: 'Available'),
                      SizedBox(width: 10),
                      SeatStatus(color: Color(0xFFffb43b), status: 'Selected'),
                      SizedBox(width: 10),
                      SeatStatus(color: Colors.white, status: 'Reserved'),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Date and Time Selection
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Select Date and Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // Date Selection
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: dates.map((date) {
                      bool isSelected = DateFormat('d/M/y').format(date) ==
                          DateFormat('d/M/y').format(selectedDate);
                      return GestureDetector(
                        onTap: () => setState(() => selectedDate = date),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFffb43b)
                                : const Color(0xFF373741),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('MMM').format(date),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('dd').format(date),
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF1c1c27)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 15),

                // Time Selection
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: availableTime.map((time) {
                      bool isSelected =
                          DateFormat('HH:mm').format(selectedDate) == time;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            int hour = int.parse(time.split(':')[0]);
                            int minute = int.parse(time.split(':')[1]);
                            selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              hour,
                              minute,
                            );
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFffb43b)
                                : const Color(0xFF373741),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFffb43b)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 15),

                // Total Price and Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '\$${selectedSeats.length * 20}.00',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFffb43b),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 30,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xFF1c1c27),
                                title: const Text(
                                  "Ticket Information",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _ticketInfoRow(
                                        "Seats", selectedSeats.join(', ')),
                                    const SizedBox(height: 10),
                                    _ticketInfoRow(
                                      "Date",
                                      DateFormat('dd/MM/yyyy')
                                          .format(selectedDate),
                                    ),
                                    _ticketInfoRow(
                                      "Time",
                                      DateFormat('HH:mm').format(selectedDate),
                                    ),
                                    const SizedBox(height: 10),
                                    _ticketInfoRow(
                                      "Number of Tickets",
                                      selectedSeats.length.toString(),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      addTicketDetails(
                                        widget.movieTitle,
                                        selectedSeats,
                                        selectedDate,
                                        selectedSeats.length,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 1),
                                          backgroundColor: Colors.greenAccent,
                                          content: Text(
                                            'Taking tickets successfully!',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                      Get.offAll(() => const MainScreen());
                                    },
                                    child: const Text("Confirm",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ticketInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget welcomeBorder(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFffb43b).withOpacity(0.3),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          "Welcome to Seat Reservation!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
