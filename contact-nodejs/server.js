require('dotenv').config();
const express = require('express');
const cors = require('cors');
const logger = require('./middleware/logger');
const contactRoutes = require('./routes/contact-routes');
const connectDB = require('./config/db');
const http = require('http'); // Import the http module

// khởi tạo app express trước
const app = express();

app.use(logger);
app.use(express.json());
app.use(cors());

// kết nối MongoDB
connectDB();

// routes
app.use('/api/contacts', contactRoutes);

const PORT = process.env.PORT || 5000;

// Create the server using the http module
const server = http.createServer(app);

// Set the timeout duration (e.g., 30 seconds)
server.setTimeout(30000, () => {
    console.log('Request timed out');
});

app.listen(PORT, '0.0.0.0', () => console.log(`Server is running on port ${PORT}`));