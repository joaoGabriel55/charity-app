const moment = require('moment-timezone');

const { Exception } = require('../../exceptions/Exception')

const eventTypes = ['SPORTS', 'CLOTHING', 'CULTURE', 'FOOD']

function validateDate(date, dataCompare) {
    const dateMoment = moment(date).tz('America/Sao_Paulo')
    const dataCompareMoment = moment(dataCompare).tz('America/Sao_Paulo')

    if (dateMoment.isSameOrBefore(dataCompareMoment))
        return false

    return true
}

function validateLocation(location) {
    if (!location.latitude || !location.longitude)
        return false
    return true
}

function validateType(type) {
    if (!eventTypes.includes(type.toUpperCase()))
        return false
    return true
}

module.exports = {
    charityEventValidator(res, event) {
        if (!event.startDate || event.startDate === '')
            return Exception(res, 400, 'Start date is required')

        if (!validateDate(new Date(event.startDate), new Date()) ||
            !validateDate(new Date(event.endDate), new Date(event.startDate)))
            return Exception(res, 400, 'Start date is invalid')

        if (!event.endDate || event.endDate === '')
            return Exception(res, 400, 'End date is required')

        if (!validateDate(new Date(event.endDate), new Date()) ||
            !validateDate(new Date(event.endDate), new Date(event.startDate)))
            return Exception(res, 400, 'End date is invalid')

        // TODO
        // if (!event.eventDays.startDate || event.eventDays.startDate === '')
        //     return Exception(res, 400, 'Start date from eventDays is required')

        // if (!validateDate(new Date(event.eventDays.startDate), new Date()) ||
        //     !validateDate(new Date(event.eventDays.endDate), new Date(event.eventDays.startDate)))
        //     return Exception(res, 400, 'Start date from eventDays is invalid')

        // if (!event.eventDays.endDate || event.eventDays.endDate === '')
        //     return Exception(res, 400, 'End date from eventDays is required')

        // if (!validateDate(new Date(event.eventDays.endDate), new Date()) ||
        //     !validateDate(new Date(event.eventDays.endDate), new Date(event.eventDays.startDate)))
        //     return Exception(res, 400, 'End date from eventDays is invalid')

        if (!event.userId || event.userId === '')
            return Exception(res, 400, 'User ID is required')

        if (!event.type || event.type === '')
            return Exception(res, 400, 'Type is required')

        if (!validateType(event.type))
            return Exception(res, 400, `Type is invalid, type must be one of them: ${eventTypes}`)

        if (!event.name || event.name === '')
            return Exception(res, 400, 'Name is required')

        if (!event.description || event.description === '')
            return Exception(res, 400, 'Description is required')

        if (!event.photosUrls || event.photosUrls.length === 0)
            return Exception(res, 400, 'Photos URLs are required')

        if (!event.location)
            return Exception(res, 400, 'Location is required')

        if (!validateLocation(event.location))
            return Exception(res, 400, 'Location is invalid')

        return null
    }
}