const Contact = require('../models/Contacts');

// // lấy danh sách contacts
// exports.getContacts = async (req, res) => {
//     try {
//         const contacts = await Contact.find(); // find() trong mông để lấy tất cả dữ liệu từ MongoDB (ở đây là lấy all data từ collection contacts)
//         res.json(contacts);
//     } catch (error) {
//         res.status(500).json({message: 'Server Error'});
//     }
// };

// // thêm contact mới
// exports.createNewContact = async (req, res) => {
//     try {
//         const {name, phoneNumber, email} = req.body;
//         const newContact = new Contact({name, phoneNumber, email});
//         await newContact.save(); // để lưu một document mới vào MongoDB bằng Mongoose
//         res.status(201).json(newContact);
//     } catch (error) {
//         res.status(400).json({message: 'Invalid Data'});
//     }
// };

// // sửa contact
// exports.editContact = async (req, res) => {
//     try {
//         const updatedContact = await Contact.findByIdAndUpdate(req.params.id, req.body, {new: true}); // để tìm và cập nhật một document trong MongoDB dựa trên _id | { new: true } → Trả về document đã cập nhật thay vì document cũ
//         res.json(updatedContact);
//     } catch (error) {
//         res.status(400).json({message: 'Update Failed'});
//     }
// };

// // xoá contact
// exports.deleteOneContact = async (req, res) => {
//     try {
//         await Contact.findByIdAndDelete(req.params.id);
//         res.json({message: 'Contact Deleted'});
//     } catch (error) {
//         res.status(400).json({message: 'Delete Failed'});
//     }
// };

// xuất ở trên rồi nên ko cần xuất nữa
// hoặc viết lại như này rồi export:

// lấy danh sách contacts
getContacts = async (req, res) => {
    try {
        const contacts = await Contact.find(); // find() trong mông để lấy tất cả dữ liệu từ MongoDB (ở đây là lấy all data từ collection contacts)
        res.json(contacts);
    } catch (error) {
        res.status(500).json({message: 'Server Error'});
    }
};

// thêm contact mới
createNewContact = async (req, res) => {
    try {
        const {name, phoneNumber, email} = req.body;
        const newContact = new Contact({name, phoneNumber, email});
        await newContact.save(); // để lưu một document mới vào MongoDB bằng Mongoose
        res.status(201).json(newContact);
    } catch (error) {
        res.status(400).json({message: 'Invalid Data'});
    }
};

// sửa contact
editContact = async (req, res) => {
    try {
        const updatedContact = await Contact.findByIdAndUpdate(req.params.id, req.body, {new: true}); // để tìm và cập nhật một document trong MongoDB dựa trên _id | { new: true } → Trả về document đã cập nhật thay vì document cũ
        res.json(updatedContact);
    } catch (error) {
        res.status(400).json({message: 'Update Failed'});
    }
};

// xoá contact
deleteOneContact = async (req, res) => {
    try {
        await Contact.findByIdAndDelete(req.params.id);
        res.json({message: 'Contact Deleted'});
    } catch (error) {
        res.status(400).json({message: 'Delete Failed'});
    }
};

// export ở đây
module.exports = {
    getContacts,
    createNewContact,
    editContact,
    deleteOneContact,
};