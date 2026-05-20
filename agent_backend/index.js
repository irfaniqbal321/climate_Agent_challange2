const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb+srv://irfan_iqbal:Y02OozqNO7mOtIhx@cluster0.srjsbky.mongodb.net/sehatsaathi?appName=Cluster0')
    .then(() => console.log('MongoDB connected'))
    .catch(err => console.log('DB error:', err));

const PORT = 3000;

const bookingsRouter = require('./routes/bookings');

app.get('/', (req, res) => {
    console.log("Route hit")
    res.send('Server chal raha hai! MongoDB connected hai.')
})
app.use('/intent', bookingsRouter);

app.use('/bookings', bookingsRouter);
console.log("Intent route registered");


// ===== INTENT ROUTE ADDED HERE =====

// ===================================
const { Client } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');

const client = new Client();

client.on('qr', qr => {
    qrcode.generate(qr, {small: true});
    console.log('Scan this QR with your WhatsApp!');
});

client.on('ready', () => {
    console.log('WhatsApp connected!');
});

client.on('message', async msg => {
    if (msg.fromMe) return;
    const { parseIntent } = require('./intentParser');
    const intent = parseIntent(msg.body);
    
    if(intent.intent === 'book_service') {
        const Booking = require('./models/Booking');
        await Booking.create(intent);
        msg.reply(`Booking confirmed! ${intent.service} in ${intent.location}`);
    } else {
        msg.reply('Send: Book AC repair in Lahore');
    }
});

client.initialize();
app.listen(3000, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT}`);
});