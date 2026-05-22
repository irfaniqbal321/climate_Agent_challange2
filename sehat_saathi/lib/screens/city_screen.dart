import 'package:flutter/material.dart';
import 'home_screen.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sehat Saathi'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Your City',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(city: 'Karachi'),
                  ),
                );
              },
              child: Text('Karachi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(city: 'Lahore'),
                  ),
                );
              },
              child: Text('Lahore'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(city: 'Islamabad'),
                  ),
                );
              },
              child: Text('Islamabad'),
            ),
          ],
        ),
      ),
    );
  }
}