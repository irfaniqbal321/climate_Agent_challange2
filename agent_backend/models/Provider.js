const mongoose = require('mongoose');

const providerSchema = new mongoose.Schema({
  name: String,
  service: String,
  location: String,
  price: Number,
  rating: Number
});

module.exports = mongoose.model('Provider', providerSchema);