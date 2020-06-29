const { Router } = require('express')
const CharityEventController = require('./controllers/CharityEventController')
const SearchController = require('./controllers/SearchController')
const routes = Router()

routes.get('/charity-event', CharityEventController.index)
routes.post('/charity-event', CharityEventController.store)
routes.put('/charity-event', CharityEventController.update)
routes.delete('/charity-event/:id', CharityEventController.destroy)

routes.get('/search', SearchController.index)

module.exports = routes