require('dotenv').config();
const express = require('express');
const cors = require('cors');
const logger = require('./middleware/logger');
const contactRoutes = require('./routes/contact-routes');
const connectDB = require('./config/db');

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
app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));