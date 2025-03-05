const express = require('express');
const contactController = require('../controllers/contact-controller');

const router = express.Router();

router.get('/get-contacts', contactController.getContacts);
router.get('/get-contacts-grouped-by-first-letter', contactController.getContactsGroupedByFirstLetter);
router.get('/get-contacts-grouped-by-yob/:year', contactController.getContactsByYearOfBirth);
router.get('/get-contacts-grouped-by-mob/:month', contactController.getContactsByMonthOfBirth);
router.get('/get-contact-infomation/:id', contactController.getContactInformation);
router.post('/create-new-contact', contactController.createNewContact);
router.post('/create-multiple-contacts', contactController.addMultipleContacts);
router.patch('/edit-contact/:id', contactController.editContact);
router.delete('/delete-one-contact/:id', contactController.deleteOneContact);
router.delete('/delete-all-contacts', contactController.deleteAllContacts);

module.exports = router;