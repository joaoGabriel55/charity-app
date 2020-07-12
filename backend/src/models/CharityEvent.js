const mongoose = require('mongoose')
const moment = require('moment-timezone');

const { PointSchema } = require('./utils/PointSchema')

const dateBrazil = moment.tz(Date.now(), 'America/Sao_Paulo')

const CharityEventSchema = new mongoose.Schema({
    userId: String,
    name: String,
    description: String,
    type: String,
    photosUrls: [String],
    startDate: { type: Date, default: dateBrazil },
    endDate: { type: Date, default: dateBrazil },
    eventDays: {
        weekDay: [String],
        startDate: Date,
        endDate: Date
    },
    location: {
        type: PointSchema,
        index: '2dsphere'
    }
})

module.exports = mongoose.model('CharityEvent', CharityEventSchema)