function parseIntent(message) {
  const msg = message.toLowerCase();
  
  if (msg.includes('book') || msg.includes('booking') || msg.includes('appointment')) {
    const service = msg.includes('ac')? 'AC Repair' : msg.includes('plumb')? 'Plumbing' : 'Service';
    const location = msg.match(/in\s+(\w+)/)?.[1] || 'Unknown';
    
    return {
      intent: 'book_service',
      service: service,
      location: location,
      userName: 'User',
      userPhone: '03001234567'
    };
  }
  
  return { intent: 'general' };
}

module.exports = { parseIntent };