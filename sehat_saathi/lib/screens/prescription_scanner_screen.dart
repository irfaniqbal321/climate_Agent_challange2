import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionScannerScreen extends StatefulWidget {
  const PrescriptionScannerScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionScannerScreen> createState() => _PrescriptionScannerScreenState();
}

class _PrescriptionScannerScreenState extends State<PrescriptionScannerScreen> {
  bool _isScanning = false;
  List<String> _extractedMedicines = [];

  Future<void> _scanPrescription() async {
    final picker = ImagePicker();
    // In a real app, this would use camera and then run OCR.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _isScanning = true;
      });

      // Mock OCR delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isScanning = false;
        // Mock extracted medicines
        _extractedMedicines = ['Panadol', 'Augmentin'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Scanner'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.document_scanner, size: 100, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Scan your prescription to automatically extract medicine names.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'اپنا نسخہ اسکین کریں تاکہ ادویات کے نام خود بخود نکالے جا سکیں',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isScanning ? null : _scanPrescription,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Scan Prescription'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 32),
              if (_isScanning)
                const CircularProgressIndicator()
              else if (_extractedMedicines.isNotEmpty) ...[
                const Text('Extracted Medicines:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                ..._extractedMedicines.map((med) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.medication, color: Colors.green),
                    title: Text(med),
                  ),
                )).toList(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
