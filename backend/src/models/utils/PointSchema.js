const mongoose = require('mongoose')

const getPointLocationSchema = (latitude, longitude) => {
    return {
        type: 'Point',
        coordinates: [longitude, latitude]
    }
}

const PointSchema = new mongoose.Schema({
    type: {
        type: String,
        enum: ['Point'],
        required: true
    },
    coordinates: {
        type: [Number],
        required: true
    }
})

module.exports = { PointSchema, getPointLocationSchema }