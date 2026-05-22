// Load Environment Variables at the absolute top of the file
require('dotenv').config();

const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();

app.use(cors());
app.use(express.json());

// MongoDB connection using irfan_iqbal's database credentials
const mongoURI = 'mongodb+srv://irfan_iqbal:Y02OozqNO7mOtIhx@cluster0.srjsbky.mongodb.net/sehatsaathi?appName=Cluster0';
mongoose.connect(mongoURI)
    .then(() => console.log('MongoDB successfully connected to Cluster0 (sehatsaathi)'))
    .catch(err => console.error('MongoDB Connection Error:', err));

const PORT = 3000;

// Register API Routes
const bookingsRouter = require('./routes/bookings');
const chatRouter = require('./routes/chat');

app.get('/', (req, res) => {
    console.log("Health check route hit");
    res.send('Sehat Saathi Server is running! MongoDB is connected.');
});

app.use('/bookings', bookingsRouter);
app.use('/chat', chatRouter);

console.log("API routes (/bookings, /chat) registered successfully.");

// ===== WhatsApp Web Client Integration =====
const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');

// Using LocalAuth to persist WhatsApp session and prevent constant re-scanning
const client = new Client({
    authStrategy: new LocalAuth()
});

client.on('qr', qr => {
    qrcode.generate(qr, { small: true });
    console.log('\n=========================================');
    console.log('SCAN THIS QR CODE WITH YOUR WHATSAPP APP:');
    console.log('=========================================\n');
});

client.on('ready', () => {
    console.log('WhatsApp Web Client is fully connected and ready!');
});

client.on('message', async msg => {
    if (msg.fromMe) return;
    
    console.log(`Received WhatsApp message from ${msg.from}: ${msg.body}`);
    const { parseIntent } = require('./intentParser');
    const intent = parseIntent(msg.body);
    
    if (intent.intent === 'book_service') {
        try {
            const Booking = require('./models/Booking');
            
            // Map the parsed WhatsApp fields to the new Booking Mongoose model
            const booking = await Booking.create({
                name: intent.service, // Doctor specialty/name
                date: intent.date,
                specialty: intent.service,
                city: intent.location,
                userName: 'WhatsApp Patient',
                userPhone: msg.from
            });
            
            msg.reply(`🩺 *Sehat Saathi Booking Confirmed!*\n\n• *Specialty:* ${booking.specialty}\n• *City:* ${booking.city}\n• *Date:* ${booking.date}\n• *Booking ID:* ${booking._id}\n\nThank you for choosing Sehat Saathi! (صحت ساتھی استعمال کرنے کا شکریہ)`);
            console.log(`Booking successfully created from WhatsApp. ID: ${booking._id}`);
        } catch (err) {
            console.error('Error creating booking from WhatsApp message:', err);
            msg.reply('Sorry, I encountered an error while processing your booking. Please try again. (معذرت، بکنگ میں خرابی پیش آئی ہے)');
        }
    } else {
        // AI Healthcare Assistant Fallback on WhatsApp!
        try {
            const { GoogleGenerativeAI } = require('@google/generative-ai');
            const apiKey = process.env.GEMINI_API_KEY;
            
            if (apiKey) {
                const genAI = new GoogleGenerativeAI(apiKey);
                const model = genAI.getGenerativeModel({
                    model: 'gemini-1.5-flash',
                    systemInstruction: 'You are Sehat Saathi WhatsApp bot. Provide extremely short medical assistance in Roman Urdu/English (max 2 sentences). Always prefix with a warning that you are an AI. If booking is wanted, say "Type Book [Specialty] in [City]".'
                });
                
                const result = await model.generateContent(msg.body);
                msg.reply(result.response.text().trim());
            } else {
                msg.reply('Welcome to Sehat Saathi! 🩺\nTo book an appointment, please send:\n"Book [Specialty] in [City]"\nExample: "Book Cardiologist in Karachi"');
            }
        } catch (err) {
            console.error('WhatsApp Gemini integration error:', err);
            msg.reply('Welcome to Sehat Saathi! 🩺\nTo book an appointment, please send:\n"Book [Specialty] in [City]"');
        }
    }
});

// Initialize WhatsApp Client with recovery catch
client.initialize().catch(err => console.error('Failed to initialize WhatsApp Web Client:', err));

// Start Express Server
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Express server running on port ${PORT}`);
});