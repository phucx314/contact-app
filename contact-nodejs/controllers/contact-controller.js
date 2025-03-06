const Contacts = require('../models/Contacts');

// // lấy danh sách contacts
// exports.getContacts = async (req, res) => {
//     try {
//         const contacts = await Contacts.find(); // find() trong mông để lấy tất cả dữ liệu từ MongoDB (ở đây là lấy all data từ collection contacts)
//         res.json(contacts);
//     } catch (error) {
//         res.status(500).json({message: 'Server Error'});
//     }
// };

// // thêm contact mới
// exports.createNewContact = async (req, res) => {
//     try {
//         const {name, phoneNumber, email} = req.body;
//         const newContact = new Contacts({name, phoneNumber, email});
//         await newContact.save(); // để lưu một document mới vào MongoDB bằng Mongoose
//         res.status(201).json(newContact);
//     } catch (error) {
//         res.status(400).json({message: 'Invalid Data'});
//     }
// };

// // sửa contact
// exports.editContact = async (req, res) => {
//     try {
//         const updatedContact = await Contacts.findByIdAndUpdate(req.params.id, req.body, {new: true}); // để tìm và cập nhật một document trong MongoDB dựa trên _id | { new: true } → Trả về document đã cập nhật thay vì document cũ
//         res.json(updatedContact);
//     } catch (error) {
//         res.status(400).json({message: 'Update Failed'});
//     }
// };

// // xoá contact
// exports.deleteOneContact = async (req, res) => {
//     try {
//         await Contacts.findByIdAndDelete(req.params.id);
//         res.json({message: 'Contact Deleted'});
//     } catch (error) {
//         res.status(400).json({message: 'Delete Failed'});
//     }
// };

// xuất ở trên rồi nên ko cần xuất nữa
// hoặc viết lại như này rồi export:

// GET: lấy danh sách contacts
getContacts = async (req, res) => {
    try {
        const contacts = await Contacts.find(); // find() trong mông để lấy tất cả dữ liệu từ MongoDB (ở đây là lấy all data từ collection contacts)
        const response = contacts.map(contact => ({
            id: contact._id,
            avatar: contact.avatar,
            name: contact.name,
            labels: contact.labels,
            description: contact.description,
            // phoneNumbers: contact.phoneNumbers,
            isFavorite: contact.isFavorite,
        }));
        res.json(response);
    } catch (error) {
        res.status(500).json({message: 'Server Error'});
    }
};

// GET: tổng contacts
getNumberOfContacts = async (req, res) => {
    try {
        const contactsCount = await Contacts.countDocuments();
        const response = {
            data: contactsCount,
        }

        res.json(response);
    } catch (error) {
        res.status(500).json({error: "Internal Server Error"});
    }
}

// GET: lấy dsach contacts group theo chữ cái đầu
getContactsGroupedByFirstLetter = async (req, res) => {
    try {
        const contacts = await Contacts.find().sort({name: 1}); // name: 1 (1 ở đây là sort asc, -1 là desc)

        const response = contacts.map(contact => ({
            id: contact._id,
            avatar: contact.avatar,
            name: contact.name,
            labels: contact.labels,
            description: contact.description,
            // phoneNumbers: contact.phoneNumbers,
            isFavorite: contact.isFavorite,
        }));

        const groupedContacts = {};
        response.forEach(contact => {
            const firstLetter = contact.name[0].toUpperCase(); // lấy letter đầu ở dạng viết hoa
            if (!groupedContacts[firstLetter]) {
                groupedContacts[firstLetter] = []; // nếu chưa có letter đó trong grouped contacts thì tạo 1 mảng contact mới để lưu contacts có first letter đó
            }
            groupedContacts[firstLetter].push(contact); // đưa contact có chung first letter vào mảng
        });
        
        res.json(groupedContacts);
    } catch (error) {
        res.status(500).json({error: 'Internal Server Error'});
    }
};

// GET: lấy dsach contacts group theo chữ cái đầu (có pagination)
getContactsGroupedByFirstLetterPaginated = async (req, res) => {
    try {
        let {page = 1, limit = 50} = req.query; // 50 contacts mỗi page
        page = parseInt(page);
        limit = parseInt(limit);

        const totalContacts = await Contacts.countDocuments();
        const totalPages = Math.ceil(totalContacts/limit); // ceil: làm tròn số

        const contacts = await Contacts.find()
            .sort({name: 1}) // sắp xếp theo tên asc
            .skip((page - 1) * limit) // bỏ qua (ko find) contacts của trang trc
            .limit(limit); // lấy contacts của page hiện tại
        
        const response = contacts.map(contact => ({
            id: contact._id,
            avatar: contact.avatar,
            name: contact.name,
            labels: contact.labels,
            description: contact.description,
            isFavorite: contact.isFavorite,
        }));

        const groupedContacts = {};
        response.forEach(contact => {
            const firstLetter = contact.name[0].toUpperCase();

            if (!groupedContacts[firstLetter]) {
                groupedContacts[firstLetter] = [];
            }

            groupedContacts[firstLetter].push(contact);
        });

        res.json({
            totalContacts: totalContacts,
            totalPages: totalPages,
            currentPage: page,
            contacts: groupedContacts
        });
    } catch (error) {
        res.status(500).json({error: 'Internal Server Error' + error})
    }
}

// GET: lấy dsach contacts có cùng năm sinh
getContactsByYearOfBirth = async (req, res) => {
    try {
        const year = parseInt(req.params.year);

        if (isNaN(year)) {
            return res.status(404).json({error: 'Invalid Year Parameter'});
        }

        const startOfYear = new Date(Date.UTC(year, 0, 1)); // 1 tháng 1 năm year
        const endOfYear = new Date(Date.UTC(year + 1, 0, 1)); // 1 tháng 1 năm sau (vì nó sẽ lấy đến 00h ngày 1/1)

        const contacts = await Contacts.find({
            birthday: {
                $gte: startOfYear, // gte = greater than or equal to
                $lt: endOfYear, // lý do dùng 1/1 năm sau (lt = less than => lấy đến hết 31/12)
            }
        });

        const response = contacts.map(contact => ({
            id: contact._id,
            avatar: contact.avatar,
            name: contact.name,
            labels: contact.labels,
            description: contact.description,
            // phoneNumbers: contact.phoneNumbers,
            isFavorite: contact.isFavorite,
            description: contact.birthday ? contact.birthday.toISOString().split('T')[0] : null, // format yyyy-mm-dd
        }));

        res.json(response);
    } catch (error) {
        res.status(500).json({error: 'Internal Server Error'});
    }
};

// GET: lấy dsach contacts có cùng tháng sinh
getContactsByMonthOfBirth = async (req, res) => {
    try {
        const month = parseInt(req.params.month);

        if(isNaN(month) || month < 1 || month > 12) {
            return res.status(404).json({error: 'Invalid Month Parameter'});
        }

        const contacts = await Contacts.find({
            birthday: {
                $exists: true, // đảm bảo birthday tồn tại
                $ne: null, // và đảm bảo birthday ko null (ne = not equal)
            }
        });

        const filteredContacts = contacts.filter(contact => {
            const contactMonth = contact.birthday.getUTCMonth() + 1; // getUTCMonth() trả về 0-11 => phải cộng thêm 1 cho đúng số tháng
            return contactMonth === month; // true thì filter nhận contact, false thì loại
        });

        const response = filteredContacts.map(contact => ({
            id: contact._id,
            avatar: contact.avatar,
            name: contact.name,
            labels: contact.labels,
            description: contact.description,
            // phoneNumbers: contact.phoneNumbers,
            isFavorite: contact.isFavorite,
            description: contact.birthday ? contact.birthday.toISOString().split('T')[0] : null, // format yyyy-mm-dd
        }));

        res.json(response);
    } catch (error) {
        res.status(500).json({error: 'Internal Server Error'});
    }
};

// GET: lấy dsach contacts có cùng tag (1 tag thôi)

// GET: lọc dsach contacts chưa có sđt

// GET: lấy dsach contacts yêu thích

// GET: lấy thông tin của 1 contact
getContactInformation = async (req, res) => {
    try {
        const contact = await Contacts.findById(req.params.id);

        if (!contact) {
            return res.status(404).json({error: 'Contact Not Found'});
        }

        res.json(contact);
    } catch (error) {
        res.status(500).json({message: 'Internal Server Error'});
    }
};

// GET: tìm kiếm contacts theo tên, phonenums, emails, home addresses, description, tags, labels, social networks,... nchung là all

// POST: thêm contact mới
createNewContact = async (req, res) => {
    try {
        const {
            name,
            avatar,
            description,
            phoneNumbers = [],
            emails = [],
            birthday,
            socialNetworks = [],
            homeAddresses = [],
            labels = [],
            tags = [],
            isFavorite = false
        } = req.body;

        // Ensure birthday is properly formatted
        const parsedBirthday = birthday ? new Date(birthday) : null;
        
        const newContact = new Contacts({
            name,
            avatar,
            description,
            phoneNumbers,
            emails,
            birthday: parsedBirthday, // Ensure it's a Date
            socialNetworks,
            homeAddresses,
            labels,
            tags,
            isFavorite
        });

        await newContact.save(); // để lưu một document mới vào MongoDB bằng Mongoose
        res.status(201).json(newContact);
    } catch (error) {
        res.status(400).json({ message: 'Invalid Data' });
    }
};

// POST: thêm nhiều contacts mới (để test thôi chứ fe ko nối)
addMultipleContacts = async (req, res) => {
    try {
        const listOfContacts = req.body.contacts;

        if (!Array.isArray(listOfContacts) || listOfContacts.length === 0) { // nếu ko phải array contacts hoặc là array trống
            return res.status(400).json({ message: 'Invalid Data' }); // thì sẽ trả về 400
        }

        // đảm bảo all birthdays phải đúng định dạng
        const formattedContacts = listOfContacts.map(contact => ({
            ...contact, // cú pháp spread, để sao chép tất cả các thuộc tính của đối tượng contact vào đối tượng mới
            birthday: contact.birthday ? new Date(contact.birthday) : null,
        }));

        const newContacts = await Contacts.insertMany(formattedContacts);
        console.log(newContacts);
        

        res.status(201).json(newContacts);
    } catch (error) {
        console.log(`error: ${error}`);
        res.status(400).json({ message: 'Invalid Data' });
    }
};

// PATCH: sửa contact
editContact = async (req, res) => {
    try {
        const updatedContact = await Contacts.findByIdAndUpdate(req.params.id, req.body, {new: true}); // để tìm và cập nhật một document trong MongoDB dựa trên _id | { new: true } → Trả về document đã cập nhật thay vì document cũ
        res.json(updatedContact);
    } catch (error) {
        res.status(400).json({message: 'Update Failed'});
    }
};

// DELETE: xoá contact
deleteOneContact = async (req, res) => {
    try {
        await Contacts.findByIdAndDelete(req.params.id);
        res.json({message: 'Contact Deleted'});
    } catch (error) {
        res.status(400).json({message: 'Delete Failed'});
    }
};

// DELETE: xoá contacts được chọn

// DELETE: xoá all contacts
deleteAllContacts = async (req, res) => {
    try {
        await Contacts.deleteMany();
        res.json({message: 'All Contacts Deleted'});
    } catch (error) {
        res.status(500).json({message: 'Internal Server Error'});
    }
}

// export ở đây
module.exports = {
    getContacts,
    getNumberOfContacts,
    getContactsGroupedByFirstLetter,
    getContactsGroupedByFirstLetterPaginated,
    getContactsByYearOfBirth,
    getContactsByMonthOfBirth,
    getContactInformation,
    createNewContact,
    addMultipleContacts,
    editContact,
    deleteOneContact,
    deleteAllContacts,
};