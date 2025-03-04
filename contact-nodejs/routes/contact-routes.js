const express = require('express');
const contactController = require('../controllers/contact-controller');

const router = express.Router();

router.get('/get-contacts', contactController.getContacts);
router.get('/get-contacts-grouped-by-first-letter', contactController.getContactsGroupedByFirstLetter);
router.get('/get-contacts-grouped-by-yob/:year', contactController.getContactsByYearOfBirth);
router.get('/get-contacts-grouped-by-mob/:month', contactController.getContactsByMonthOfBirth);
router.get('/get-contact-infomation/:id', contactController.getContactInformation);
router.post('/create-new-contact', contactController.createNewContact);
router.put('/edit-contact/:id', contactController.editContact);
router.delete('/delete-one-contact/:id', contactController.deleteOneContact);

module.exports = router;