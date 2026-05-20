import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorListScreen extends StatefulWidget {
  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final List doctors = [
    {'name': 'Dr. Ahmed Khan', 'specialty': 'Cardiologist'},
    {'name': 'Dr. Sana Ali', 'specialty': 'Dentist'},
    {'name': 'Dr. Bilal Raza', 'specialty': 'General Physician'},
  ];

  void _showBookingDialog(BuildContext context, Map doctor) {
    DateTime selectedDate = DateTime.now().add(Duration(days: 1));
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Book Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctor['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              Text(doctor['specialty'], style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
              Text('Select Date:'),
              SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                      Icon(Icons.calendar_today, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _bookAppointment(doctor['name'], selectedDate);
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _bookAppointment(String doctorName, DateTime date) async {
    final url = Uri.parse('http://10.0.2.2:3000/bookings');
    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': doctorName,
        'date': date.toIso8601String().split('T')[0],
      }),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment Booked!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(doctors[index]['name']),
              subtitle: Text(doctors[index]['specialty']),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _showBookingDialog(context, doctors[index]),
            ),
          );
        },
      ),
    );
  }
}