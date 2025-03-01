const mongoose = require('mongoose');

const ContactSchema = new mongoose.Schema({
    name: {type: String, require: true},
    phoneNumber: {type: String, require: true},
    email: {type: String},
}, {
    timestamps: true,
});

// xuất model ra nữa chứ quên mất
module.exports = mongoose.model('Contact', ContactSchema);