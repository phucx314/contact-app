const express = require('express');
const contactController = require('../controllers/contact-controller');

const router = express.Router();

router.get('/get-contacts', contactController.getContacts);
router.get('/get-contacts-grouped-by-first-letter', contactController.getContactsGroupedByFirstLetter);
router.post('/create-new-contact', contactController.createNewContact);
router.put('/edit-contact/:id', contactController.editContact);
router.delete('/delete-one-contact/:id', contactController.deleteOneContact);

module.exports = router;