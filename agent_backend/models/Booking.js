const mongoose = require('mongoose');

const bookingSchema = new mongoose.Schema({
  providerId: { type: mongoose.Schema.Types.ObjectId, ref: 'Provider' },
  service: String,
  location: String,
  userName: String,
  userPhone: String,
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Booking', bookingSchema);