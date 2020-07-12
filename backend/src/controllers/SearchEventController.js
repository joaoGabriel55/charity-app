const CharityEvent = require('../models/CharityEvent')

module.exports = {
    async index(req, res) {
        // Buscar events em um raio de 10km
        // TODO Filters 

        const { longitude, latitude, type } = req.query

        try {

            let query = {
                location: {
                    $near: {
                        $geometry: {
                            type: 'Point',
                            coordinates: [longitude, latitude]
                        },
                        $maxDistance: 10000
                    }
                }
            }
            if (type)
                query['type'] = { $eq: type.toUpperCase() }


            const events = await CharityEvent.find(query)

            return res.status(200).json({ events })
        } catch (error) {
            return res.status(500).json({ "error": error })
        }

    }
}