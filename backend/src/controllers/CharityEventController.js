const axios = require('axios')
const CharityEvent = require('../models/CharityEvent')

module.exports = {
    async index(req, res) {
        const events = await CharityEvent.find()
        return res.json(events)
    },
    async store(req, res) {
        const { userId, name, description, photos_urls, startDate, endDate, eventDays, location } = req.body

        // TODO: Validation

        event = await CharityEvent.create({
            userId, name, description, photos_urls, startDate, endDate, eventDays, location
        })

        return res.json(event)
    },
    async update(req, res) {
        let payload = req.body

        //TODO: Improve
        if (!payload.hasOwnProperty("id"))
            return res.json({ "error": "msg" })

        const id = req.body.id

        await CharityEvent.findByIdAndUpdate(id, req.body, (err, event) => {
            if (err) return res.json(err)
            if (event)
                return res.json({ event })
        })
    },
    async destroy(req, res) {
        const id = req.params.id

        await CharityEvent.findByIdAndDelete(id, (err, event) => {
            if (err) return res.json(err)
            if (event)
                return res.json({ message: `Charity Event '${event.id}' was removed.` })
            else
                return res.json({ message: `Charity Event '${id}' not found.` })
        })
    }
}