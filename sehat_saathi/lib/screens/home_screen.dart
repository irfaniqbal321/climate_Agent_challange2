import 'package:flutter/material.dart';
import 'doctor_list_screen.dart';
import 'my_bookings_screen.dart';
import 'chat_screen.dart';
import 'check_medicine_screen.dart';
import 'drug_interaction_screen.dart';
import 'find_hospital_screen.dart';
import 'prescription_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  final String city;

  const HomeScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    // Determine climate health warning based on the selected city
    Map<String, String> climateWarning = _getClimateWarning(city);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F4), // Premium light grey-green background
      appBar: AppBar(
        title: Text('Sehat Saathi - $city'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () => Navigator.pop(context), // Go back to city screen
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Greeting Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, Ahmad!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004D00),
                          ),
                        ),
                        Text(
                          'Your Personalized Health Partner',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF006600),
                      child: Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Climate Health Alert Banner (Challenge Alignment!)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getAlertColor(city).withOpacity(0.9),
                        _getAlertColor(city),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _getAlertColor(city).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            climateWarning['icon'] == 'smog'
                                ? Icons.cloud_queue
                                : climateWarning['icon'] == 'heat'
                                    ? Icons.wb_sunny
                                    : Icons.park,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            climateWarning['title'] ?? 'Climate Health Info',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        climateWarning['desc'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Main Features Title
                const Text(
                  'Health Orchestration Suite',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D00),
                  ),
                ),
                const SizedBox(height: 12),

                // Grid View of All Premium Services
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.15,
                  children: [
                    _buildFeatureCard(
                      context,
                      title: 'Ask Sehat AI',
                      subtitle: 'AI Health Companion',
                      icon: Icons.chat_bubble_rounded,
                      iconColor: const Color(0xFF006600),
                      bgColor: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChatScreen()),
                      ),
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'Book Doctor',
                      subtitle: 'In-clinic / Video',
                      icon: Icons.medical_services,
                      iconColor: const Color(0xFF006600),
                      bgColor: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DoctorListScreen()),
                      ),
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'Check Medicines',
                      subtitle: 'Prices & Sehat Card',
                      icon: Icons.medication,
                      iconColor: const Color(0xFF006600),
                      bgColor: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CheckMedicineScreen()),
                      ),
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'Interactions',
                      subtitle: 'Drug-to-Drug Safety',
                      icon: Icons.warning_amber_rounded,
                      iconColor: const Color(0xFFC62828),
                      bgColor: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DrugInteractionScreen()),
                      ),
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'Find Hospital',
                      subtitle: 'Locate & Wait Times',
                      icon: Icons.local_hospital,
                      iconColor: const Color(0xFF006600),
                      bgColor: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FindHospitalScreen()),
                      ),
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'Prescription Scan',
                      subtitle: 'Smart OCR Reader',
                      icon: Icons.qr_code_scanner,
                      iconColor: const Color(0xFF006600),
                      bgColor: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PrescriptionScannerScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // My Bookings Quick Navigation Card
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(Icons.bookmark, color: Color(0xFF006600)),
                    ),
                    title: const Text(
                      'View My Bookings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Check dates, doctors & schedules'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyBookingsScreen()),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: iconColor),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> _getClimateWarning(String city) {
    switch (city.toLowerCase()) {
      case 'lahore':
        return {
          'title': '🌬️ Smog Alert: Moderate PM2.5',
          'desc': 'Air quality is poor today. We recommend wearing an N95 mask outdoors to protect your respiratory health from fine soot particles.',
          'icon': 'smog',
        };
      case 'karachi':
        return {
          'title': '☀️ Extreme Heat advisory',
          'desc': 'High humidity and temperatures are forecast today. Stay hydrated, seek shade, and avoid direct sunlight between 11:00 AM and 4:00 PM.',
          'icon': 'heat',
        };
      case 'islamabad':
        return {
          'title': '🌾 Active Pollen Season',
          'desc': 'High pollen count detected. Keep your windows closed and inhaler at hand if you suffer from asthma or seasonal allergies.',
          'icon': 'pollen',
        };
      default:
        return {
          'title': '🌱 Balanced Climate Day',
          'desc': 'Weather is normal and stable. Good day for a brisk walk! Remember to drink at least 8-10 glasses of water daily.',
          'icon': 'pollen',
        };
    }
  }

  Color _getAlertColor(String city) {
    switch (city.toLowerCase()) {
      case 'lahore':
        return const Color(0xFFD84315); // Dark Orange for Smog
      case 'karachi':
        return const Color(0xFFC62828); // Red for Heatwave
      case 'islamabad':
        return const Color(0xFFF57F17); // Amber for Pollen
      default:
        return const Color(0xFF006600); // Sehat Green for stable
    }
  }
}