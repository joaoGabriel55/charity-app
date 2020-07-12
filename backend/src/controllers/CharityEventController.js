const axios = require('axios')
const moment = require('moment-timezone');
const { charityEventValidator } = require('./validators/CharityEventValidator')
const { getPointLocationSchema } = require('../models/utils/PointSchema')
const CharityEvent = require('../models/CharityEvent')

function getDateMoment(date) {
    return moment.tz(date.toLocaleString(), 'America/Sao_Paulo').format()
}

module.exports = {
    async index(req, res) {
        try {
            const events = await CharityEvent.find()
            return res.status(200).json(events)
        } catch (error) {
            return res.status(500).json({ "error": error })
        }
    },

    async store(req, res) {
        const { userId, name, description, type, photosUrls, startDate, endDate, eventDays, location } = req.body
        const event = { userId, name, description, type: type.toUpperCase(), photosUrls, startDate, endDate, eventDays, location }

        const error = charityEventValidator(res, event)
        if (error)
            return error

        const { latitude, longitude } = event.location
        event.location = getPointLocationSchema(latitude, longitude)
        event.startDate = getDateMoment(event.startDate)
        event.endDate = getDateMoment(event.endDate)

        await CharityEvent.create(event)
            .then((result) => res.status(201).json({ "id": result.id }))
            .catch((error) => res.status(500).json({ "error": error }))
    },
    async update(req, res) {
        const idRequest = req.params.id
        const { id, userId, name, description, type, photosUrls, startDate, endDate, eventDays, location } = req.body

        if (!id || !idRequest)
            return res.json({ "error": "Path and payload ID must be present" })

        if (id !== idRequest)
            return res.json({ "error": "Path ID and Payload ID must be equals" })

        const event = { userId, name, description, type: type.toUpperCase(), photosUrls, startDate, endDate, eventDays, location }
        const error = charityEventValidator(res, event)
        if (error)
            return error

        const { latitude, longitude } = event.location
        event.location = getPointLocationSchema(latitude, longitude)
        event.startDate = getDateMoment(event.startDate)
        event.endDate = getDateMoment(event.endDate)

        await CharityEvent.findByIdAndUpdate(id, event, (err, event) => {
            if (err) return res.status(500).json()
            if (!event)
                return res.status(404).json({ message: `Charity Event '${id}' not found.` })

            return res.status(204).json()
        })
    },
    async destroy(req, res) {
        const id = req.params.id

        await CharityEvent.findByIdAndDelete(id, (err, event) => {
            if (err) return res.status(500).json(err)
            if (event)
                return res.status(200).json({ message: `Charity Event '${event.id}' was removed.` })
            else
                return res.status(404).json({ message: `Charity Event '${id}' not found.` })
        })
    }
}