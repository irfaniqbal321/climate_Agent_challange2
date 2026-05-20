import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class CheckMedicineScreen extends StatefulWidget {
  const CheckMedicineScreen({Key? key}) : super(key: key);

  @override
  State<CheckMedicineScreen> createState() => _CheckMedicineScreenState();
}

class _CheckMedicineScreenState extends State<CheckMedicineScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _searchMedicine(String query) {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    
    setState(() {
      _searchResults = DummyData.medicines.where((med) {
        return med['name'].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Medicine'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchMedicine,
              decoration: InputDecoration(
                labelText: 'Search Medicine (دوا تلاش کریں)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final med = _searchResults[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(med['name'], style: Theme.of(context).textTheme.titleLarge),
                            Text(med['price'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Active Ingredient: ${med['active_ingredient']}'),
                        const SizedBox(height: 12),
                        if (med['sehat_card_covered'])
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '✓ Covered under Sehat Card',
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          )
                        else
                          const Text('❌ Not Covered', style: TextStyle(color: Colors.red)),
                        const SizedBox(height: 12),
                        if (med['alternatives'].isNotEmpty) ...[
                          const Text('Alternatives:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text((med['alternatives'] as List<String>).join(', ')),
                        ],
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
