class DummyData {
  // --- Hospitals Data ---
  static const List<Map<String, dynamic>> hospitals = [
    {
      'id': '1',
      'name': 'Shaukat Khanum Memorial Cancer Hospital',
      'city': 'Lahore',
      'disease_focus': 'Cancer',
      'sehat_card_covered': true,
      'distance': '5.2 km',
      'wait_time': '30 mins',
    },
    {
      'id': '2',
      'name': 'Aga Khan University Hospital',
      'city': 'Karachi',
      'disease_focus': 'General',
      'sehat_card_covered': false,
      'distance': '12.4 km',
      'wait_time': '45 mins',
    },
    {
      'id': '3',
      'name': 'PIMS Hospital',
      'city': 'Islamabad',
      'disease_focus': 'General',
      'sehat_card_covered': true,
      'distance': '2.1 km',
      'wait_time': '15 mins',
    },
    {
      'id': '4',
      'name': 'Punjab Institute of Cardiology (PIC)',
      'city': 'Lahore',
      'disease_focus': 'Heart',
      'sehat_card_covered': true,
      'distance': '8.0 km',
      'wait_time': '60 mins',
    },
  ];

  // --- Medicines Data ---
  static const List<Map<String, dynamic>> medicines = [
    {
      'id': '1',
      'name': 'Panadol',
      'active_ingredient': 'Paracetamol',
      'price': 'Rs. 20 / strip',
      'sehat_card_covered': true,
      'alternatives': ['Calpol', 'Disprol'],
    },
    {
      'id': '2',
      'name': 'Augmentin',
      'active_ingredient': 'Amoxicillin / Clavulanic acid',
      'price': 'Rs. 150 / strip',
      'sehat_card_covered': true,
      'alternatives': ['Amoxil', 'Moxget'],
    },
    {
      'id': '3',
      'name': 'Brufen',
      'active_ingredient': 'Ibuprofen',
      'price': 'Rs. 45 / strip',
      'sehat_card_covered': false,
      'alternatives': ['Arinac', 'Advil'],
    },
    {
      'id': '4',
      'name': 'Aspirin',
      'active_ingredient': 'Aspirin',
      'price': 'Rs. 30 / strip',
      'sehat_card_covered': true,
      'alternatives': ['Disprin'],
    },
    {
      'id': '5',
      'name': 'Warfarin',
      'active_ingredient': 'Warfarin',
      'price': 'Rs. 200 / strip',
      'sehat_card_covered': true,
      'alternatives': [],
    },
  ];

  // --- Drug Interactions ---
  // If user selects Aspirin and Warfarin, warn them.
  static const List<Map<String, dynamic>> interactions = [
    {
      'drugs': ['Aspirin', 'Warfarin'],
      'warning': 'SEVERE: Increased risk of bleeding. Please consult your doctor immediately before combining these medications.',
      'urdu_warning': 'شدید خطرہ: ان ادویات کو ایک ساتھ استعمال کرنے سے خون بہنے کا خطرہ بڑھ سکتا ہے۔ براہ کرم اپنے ڈاکٹر سے رجوع کریں۔',
    },
    {
      'drugs': ['Brufen', 'Aspirin'],
      'warning': 'MODERATE: May increase the risk of stomach ulcers. Use with caution.',
      'urdu_warning': 'درمیانہ خطرہ: معدے کے السر کا خطرہ بڑھ سکتا ہے۔ احتیاط سے استعمال کریں۔',
    }
  ];

  // --- Chat Bot Responses ---
  static const Map<String, String> chatResponses = {
    'hello': 'Hello! How can Sehat Saathi help you today? (السلام علیکم! صحت ساتھی آج آپ کی کیا مدد کر سکتا ہے؟)',
    'fever': 'For a mild fever, you can take Paracetamol (like Panadol). If it persists for more than 3 days, please consult a doctor. (ہلکے بخار کے لیے آپ پیناڈول لے سکتے ہیں۔ اگر بخار 3 دن سے زیادہ رہے تو ڈاکٹر سے رجوع کریں۔)',
    'sehat card': 'The Sehat Sahulat Program (Sehat Card) provides free indoor healthcare services. You can use this app to find covered hospitals and medicines.',
    'default': 'I am a simple AI assistant. For complex queries, please book an appointment with a doctor through the app. (میں ایک سادہ اے آئی اسسٹنٹ ہوں۔ پیچیدہ مسائل کے لیے براہ کرم ڈاکٹر سے اپائنٹمنٹ بک کریں۔)',
  };
}
