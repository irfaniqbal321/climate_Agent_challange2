const express = require('express');
const router = express.Router();
const { GoogleGenerativeAI } = require('@google/generative-ai');

// System prompt to give Sehat Saathi AI a compasssionate, locally relevant Pakistani persona
const SYSTEM_INSTRUCTION = `You are Sehat Saathi AI (صحت ساتھی), an empathetic, state-of-the-art healthcare orchestrator for Pakistan.
Your goal is to help patients with inquiries about local health concerns, mild symptoms, medicine alternatives, and Sehat Sahulat Card coverage.

Guidelines:
1. Always start or include a brief disclaimer that you are an AI, not a doctor, and severe symptoms require professional medical advice.
2. Communicate warmly in a mixture of English and Urdu (or Roman Urdu if the user writes in Roman Urdu).
3. Provide culturally relevant advice. For example, mention local Pakistan standard home remedies (like Joshanda, honey and ginger, ORS for hydration in heatwaves) and mention covered hospitals under the Sehat Sahulat Program where appropriate.
4. Integrate climate-sensitive advice where possible (e.g. heatstroke prevention in Karachi's hot seasons, smog protection masks in Lahore, pollen allergy precautions in Islamabad).
5. Keep your responses concise (2-4 sentences max per paragraph), clear, and easy to read using bullet points if listing items.
6. Under no circumstances prescribe heavy antibiotics or dangerous prescription drugs. If they ask for alternatives to mild over-the-counter drugs, you can suggest them (e.g., paracetamol brands like Calpol/Panadol, ibuprofen brands like Brufen).`;

router.post('/', async (req, res) => {
  const userMessage = req.body?.message;
  
  if (!userMessage) {
    return res.status(400).json({ error: 'Message body is required' });
  }

  try {
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      console.warn('GEMINI_API_KEY is not defined in the environment. Falling back to local responses.');
      return res.status(500).json({ error: 'Gemini API key is not configured' });
    }

    const genAI = new GoogleGenerativeAI(apiKey);
    // Using gemini-1.5-flash which is fast, robust, and cost-effective
    const model = genAI.getGenerativeModel({
      model: 'gemini-1.5-flash',
      systemInstruction: SYSTEM_INSTRUCTION,
    });

    const result = await model.generateContent(userMessage);
    const responseText = result.response.text().trim();

    console.log('Gemini response successfully generated.');
    res.json({ response: responseText });
  } catch (error) {
    console.error('Error generating AI response:', error);
    res.status(500).json({ error: 'Failed to generate response from Gemini API' });
  }
});

module.exports = router;
