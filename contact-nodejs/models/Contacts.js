const mongoose = require('mongoose');

const PhoneNumberSchema = new mongoose.Schema({
    number: {
        type: String,
    },
    label: {
        type: String,
        enum: ['Home', 'Work', 'Mobile', 'Other'],
        default: 'Mobile',
    },
});

const EmailSchema = new mongoose.Schema({
    email: {
        type: String,
    },
    label: {
        type: String,
        enum: ['Personal', 'Work', 'Study', 'Other'],
        default: 'Personal',
    },
});

const SocialNetworkSchema = new mongoose.Schema({
    socialNetwork: {
        type: String,
    },
    label: {
        type: String,
        enum: ['Facebook', 'X', 'Instagram', 'LinkedIn', 'Snapchat', 'TikTok', 'Pinterest', 'Reddit', 'YouTube', 'WhatsApp', 'WeChat', 'Zalo', 'Other'],
        default: 'Other',
    },
});

const HomeAddressSchema = new mongoose.Schema({
    address: {
        type: String,
    },
    label: {
        type: String,
        enum: ['Home', 'Family home', 'Rental', 'Other'],
        default: 'Home',
    },
});

const ContactSchema = new mongoose.Schema({
    name: { type: String, required: true },
    avatar: {type: String},
    description: {type: String},
    phoneNumbers: [PhoneNumberSchema],
    emails: [EmailSchema],
    birthday: { type: Date },
    socialNetworks: [SocialNetworkSchema],
    homeAddresses: [HomeAddressSchema],
    labels: {
        type: [String],
        enum: ['Family', 'Friend', 'Neighborhood', 'Work', 'Other'],
        default: [],
    },
    tags: [String],
    isFavorite: {type: Boolean, default: false},
}, {
    timestamps: true,
});

// xuất model ra nữa chứ quên mất
module.exports = mongoose.model('Contact', ContactSchema);