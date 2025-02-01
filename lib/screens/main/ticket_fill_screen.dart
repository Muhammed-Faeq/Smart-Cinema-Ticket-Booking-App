import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketFillScreen extends StatelessWidget {
  const TicketFillScreen({super.key});

  Future<void> deleteTicket(User? user, String ticketId) async {
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(user?.email)
        .collection('UserTickets')
        .doc(ticketId)
        .delete();
  }

  Stream<QuerySnapshot> getData(User? user) {
   return FirebaseFirestore.instance
        .collection('Tickets')
        .doc(user!.email)
        .collection('UserTickets')
        .orderBy('Timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No user logged in.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF090E17),
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Cinema Tickets",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getData(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No tickets found.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final tickets = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              final movieName = ticket['Movie name'];
              final seats =
                  (ticket['seats number'] as List<dynamic>).join(', ');
              final date = (ticket['Date'] as Timestamp).toDate();
              final ticketCount = ticket['Number of Tickets'];

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color(0xFF1E2433),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15.0),
                          ),
                          color: Color.fromARGB(255, 22, 26, 34),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          movieName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "🎟️ Ticket Details",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 10),
                            _ticketInfoRow("Seats", seats),
                            const SizedBox(height: 10),
                            _ticketInfoRow(
                              "Date",
                              DateFormat('dd/MM/yyyy').format(date),
                            ),
                            const SizedBox(height: 10),
                            _ticketInfoRow(
                              "Time",
                              DateFormat('HH:mm').format(date),
                            ),
                            const SizedBox(height: 10),
                            _ticketInfoRow(
                              "Number of tickets",
                              ticketCount.toString(),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                await deleteTicket(user, ticket.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                      'Ticket deleted successfully!',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
}
