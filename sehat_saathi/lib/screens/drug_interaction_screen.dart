import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class DrugInteractionScreen extends StatefulWidget {
  const DrugInteractionScreen({Key? key}) : super(key: key);

  @override
  State<DrugInteractionScreen> createState() => _DrugInteractionScreenState();
}

class _DrugInteractionScreenState extends State<DrugInteractionScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final List<String> _selectedMedicines = [];
  Map<String, dynamic>? _interactionWarning;

  void _addMedicine() {
    if (_medicineController.text.isNotEmpty) {
      setState(() {
        _selectedMedicines.add(_medicineController.text);
        _medicineController.clear();
        _checkInteractions();
      });
    }
  }

  void _checkInteractions() {
    _interactionWarning = null;
    if (_selectedMedicines.length < 2) return;

    for (var interaction in DummyData.interactions) {
      final List<String> drugs = List<String>.from(interaction['drugs']);
      
      // Check if all drugs in this interaction rule are present in selected medicines
      bool isMatch = true;
      for (var drug in drugs) {
        bool found = _selectedMedicines.any((m) => m.toLowerCase() == drug.toLowerCase());
        if (!found) {
          isMatch = false;
          break;
        }
      }

      if (isMatch) {
        _interactionWarning = interaction;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drug Interactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add two or more medicines to check for potential interactions.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _medicineController,
                    decoration: const InputDecoration(
                      labelText: 'Medicine Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addMedicine,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _selectedMedicines.map((med) => Chip(
                label: Text(med),
                onDeleted: () {
                  setState(() {
                    _selectedMedicines.remove(med);
                    _checkInteractions();
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: 24),
            if (_interactionWarning != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Interaction Warning!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_interactionWarning!['warning']),
                    const SizedBox(height: 8),
                    Text(_interactionWarning!['urdu_warning'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ] else if (_selectedMedicines.length >= 2) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(child: Text('No known severe interactions found in database. Always consult your doctor.')),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
