const express = require('express');
const router = express.Router();
const Booking = require('../models/Booking');
const { parseIntent } = require('../intentParser');

// 1. Direct Flutter bookings endpoint (POST /bookings)
router.post('/', async (req, res) => {
  try {
    console.log('Direct booking request received:', req.body);
    const booking = new Booking(req.body);
    await booking.save();
    console.log('Direct booking saved with ID:', booking._id);
    res.status(201).json({ ok: true, bookingId: booking._id });
  } catch (err) {
    console.error('Error in direct booking:', err);
    res.status(500).json({ error: err.message });
  }
});

// 2. Intent-based bookings endpoint (POST /bookings/book)
router.post('/book', async (req, res) => {
  try {
    const msg = req.body?.message || "";
    console.log('Intent booking request received for message:', msg);
    const bookingIntent = parseIntent(msg);
    
    const booking = new Booking({ ...bookingIntent, ...req.body });
    await booking.save();
    console.log('Intent booking saved with ID:', booking._id);
    res.json({ ok: true, bookingId: booking._id });
  } catch (err) {
    console.error('Error in intent booking:', err);
    res.status(500).json({ error: err.message });
  }
});

// 3. GET all bookings (GET /bookings)
router.get('/', async (req, res) => {
  try {
    const bookings = await Booking.find().sort({ createdAt: -1 });
    // Return pure JSON to prevent FormatException crash in Flutter's jsonDecode
    res.json(bookings);
  } catch (error) {
    console.error('Error fetching bookings:', error);
    res.status(500).json({ error: 'Failed to retrieve bookings' });
  }
});

module.exports = router;