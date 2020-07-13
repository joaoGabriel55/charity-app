const express = require('express');
const routers = express.Router();
const CharityEventController = require('../controllers/CharityEventController')
const SearchEventController = require('../controllers/SearchEventController')

routers.get('/', CharityEventController.index)
routers.post('/', CharityEventController.store)
routers.put('/:id', CharityEventController.update)
routers.delete('/:id', CharityEventController.destroy)

routers.get('/search', SearchEventController.index)

module.exports = routers