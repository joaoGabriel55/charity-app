const { Router } = require('express')
const CharityEventController = require('./controllers/CharityEventController')
const SearchEventController = require('./controllers/SearchEventController')
const routes = Router()

routes.get('/charity-event', CharityEventController.index)
routes.post('/charity-event', CharityEventController.store)
routes.put('/charity-event/:id', CharityEventController.update)
routes.delete('/charity-event/:id', CharityEventController.destroy)

routes.get('/charity-event/search', SearchEventController.index)

module.exports = routes