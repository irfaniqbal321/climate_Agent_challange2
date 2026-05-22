function parseIntent(message) {
  const msg = message.toLowerCase();
  
  const isBooking = msg.includes('book') || 
                    msg.includes('booking') || 
                    msg.includes('appointment') || 
                    msg.includes('apointment') ||
                    msg.includes('appointment book') ||
                    msg.includes('dikhana hai') ||
                    msg.includes('appointment chahiye');

  if (isBooking) {
    // Extract Specialty / Service
    let specialty = 'General Physician';
    if (msg.includes('cardio') || msg.includes('heart') || msg.includes('dil')) {
      specialty = 'Cardiologist';
    } else if (msg.includes('dentist') || msg.includes('dant') || msg.includes('teeth')) {
      specialty = 'Dentist';
    } else if (msg.includes('skin') || msg.includes('derma')) {
      specialty = 'Dermatologist';
    } else if (msg.includes('child') || msg.includes('pedia') || msg.includes('bacha')) {
      specialty = 'Pediatrician';
    } else if (msg.includes('eye') || msg.includes('ophthal')) {
      specialty = 'Ophthalmologist';
    }

    // Extract Location (City in Pakistan)
    let location = 'Lahore'; // default city
    if (msg.includes('karachi')) {
      location = 'Karachi';
    } else if (msg.includes('islamabad')) {
      location = 'Islamabad';
    } else if (msg.includes('rawalpindi')) {
      location = 'Rawalpindi';
    } else {
      const match = msg.match(/in\s+(\w+)/);
      if (match && match[1]) {
        // Capitalize city name
        location = match[1].charAt(0).toUpperCase() + match[1].slice(1);
      }
    }

    // Extract date if specified, e.g. "tomorrow" or "on 2026-05-22"
    let date = new Date().toISOString().split('T')[0];
    if (msg.includes('tomorrow')) {
      const tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      date = tomorrow.toISOString().split('T')[0];
    } else {
      const dateMatch = msg.match(/(\d{4}-\d{2}-\d{2})/);
      if (dateMatch) {
        date = dateMatch[1];
      }
    }
    
    return {
      intent: 'book_service',
      service: specialty,
      location: location,
      userName: 'WhatsApp Patient',
      userPhone: '03001234567',
      date: date
    };
  }
  
  return { intent: 'general' };
}

module.exports = { parseIntent };