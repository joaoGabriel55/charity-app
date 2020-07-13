const express = require('express')
const mongoose = require('mongoose')
const bodyParser = require('body-parser');
const cors = require('cors')
const charityEventRoutes = require('./routes/CharityEventRoutes')
// const http = require('http')
const logger = require('morgan')

const app = express()

const keycloak = require('./auth/config/KeycloakConfig.js').initKeycloak()
const keycloakInstance = require('./auth/config/KeycloakConfig.js').getKeycloak()

app.use(keycloak.middleware())

// const server = http.Server(app)
app.use(bodyParser.json());

// Enable CORS support
app.use(cors());

// TODO: get from a .env file
mongoose.connect('mongodb://localhost:27017/charity', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})

app.use(logger('dev'))
app.use(cors())
app.use(express.json())
app.use('/charity-event', keycloakInstance.protect('user'), charityEventRoutes)

app.listen(5555)