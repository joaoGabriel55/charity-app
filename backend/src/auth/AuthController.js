const dotenv = require('dotenv')
const { Exception } = require('../exceptions/Exception')

dotenv.config();

const validateUserPayload = async (res, user) => {

    if (user.username === '' || !user.username)
        return Exception(res, 400, `Username is required`)

    if (user.email === '' || !user.email)
        return Exception(res, 400, `Email is required`)

    if (user.password === '' || !user.password)
        return Exception(res, 400, `Password is required`)

    return null
}

const signUp = async (req, res) => {

    const { name, bio, username, email, password } = req.body
    const user = { name, bio, username, email, password }

    const error = validateUserPayload(res, user)
    if (error) return error

    return res.status(201).json({})
}

const signIn = async (req, res) => {

    return res.status(200).json({})
}

module.exports = { signIn }