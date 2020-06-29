const mongoose = require('mongoose')
const PointSchema = require('./utils/PointSchema')

const CharityEventSchema = new mongoose.Schema({
    userId: String,
    name: String,
    description: String,
    photos_urls: [String],
    startDate: Date,
    endDate: Date,
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