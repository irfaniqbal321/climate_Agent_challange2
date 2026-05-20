const express = require('express');
const router = express.Router();
const Booking = require('../models/Booking');
const { extractBookingIntent } = require('../intentParser');

router.post('/book', async (req, res) => {
  try {
    const msg = req.body?.message || "";
    const bookingIntent = await extractBookingIntent(msg);
    const booking = new Booking({ ...bookingIntent, ...req.body });
    await booking.save();
    console.log('Booking created for provider', booking.providerId);
    res.json({ ok: true, bookingId: booking._id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});
router.get('/', async (req, res) => {
    try {
        const bookings = await Booking.find(); // agar database use kar rahe ho to yahan DB call likho
        res.send(`<pre style="font-size:20px; color:black">${JSON.stringify(bookings, null, 2)}</pre>`);
    } catch (error) {
        res.status(500).send('Error');
    }
});

module.exports = router;