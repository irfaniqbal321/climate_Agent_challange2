import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class FindHospitalScreen extends StatefulWidget {
  const FindHospitalScreen({Key? key}) : super(key: key);

  @override
  State<FindHospitalScreen> createState() => _FindHospitalScreenState();
}

class _FindHospitalScreenState extends State<FindHospitalScreen> {
  String? _selectedCity;
  String? _selectedDisease;

  final List<String> cities = ['Lahore', 'Karachi', 'Islamabad'];
  final List<String> diseases = ['General', 'Cancer', 'Heart'];

  List<Map<String, dynamic>> _filteredHospitals = [];

  void _searchHospitals() {
    setState(() {
      _filteredHospitals = DummyData.hospitals.where((hospital) {
        final cityMatch = _selectedCity == null || hospital['city'] == _selectedCity;
        final diseaseMatch = _selectedDisease == null || hospital['disease_focus'] == _selectedDisease;
        return cityMatch && diseaseMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Hospital'),
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select City (شہر منتخب کریں)'),
                  value: _selectedCity,
                  items: cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                  onChanged: (val) => setState(() => _selectedCity = val),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Disease (بیماری منتخب کریں)'),
                  value: _selectedDisease,
                  items: diseases.map((disease) => DropdownMenuItem(value: disease, child: Text(disease))).toList(),
                  onChanged: (val) => setState(() => _selectedDisease = val),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _searchHospitals,
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          
          // Results Section
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredHospitals.length,
              itemBuilder: (context, index) {
                final hospital = _filteredHospitals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hospital['name'], style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${hospital['city']} • ${hospital['distance']}'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('Wait Time: ${hospital['wait_time']}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (hospital['sehat_card_covered'])
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Sehat Card Covered ✓',
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Appointment Booking Requested!')),
                              );
                            },
                            child: const Text('Book Appointment'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
