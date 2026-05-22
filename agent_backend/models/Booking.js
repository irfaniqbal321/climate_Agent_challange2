const mongoose = require('mongoose');

const bookingSchema = new mongoose.Schema({
  // Direct Flutter Bookings
  name: { type: String, required: false }, // Doctor's name or Provider's name
  date: { type: String, required: false }, // Appointment Date (YYYY-MM-DD)
  specialty: { type: String, required: false }, // Specialty (e.g. Cardiologist)
  city: { type: String, required: false }, // Selected city

  // WhatsApp / Intent Bookings fallback
  providerId: { type: mongoose.Schema.Types.ObjectId, ref: 'Provider', required: false },
  service: { type: String, required: false },
  location: { type: String, required: false },
  userName: { type: String, default: 'User' },
  userPhone: { type: String, default: '03001234567' },

  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Booking', bookingSchema);