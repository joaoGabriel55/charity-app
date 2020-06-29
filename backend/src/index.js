const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')
const routes = require('./routes')
const http = require('http')
// const { setupWebSocket } = require('./websocket')


const app = express()

const server = http.Server(app)

setupWebSocket(server)

// TODO: get from a .env file
mongoose.connect('mongodb+srv://omnistack:omnistack@cluster0-megep.mongodb.net/week10?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})

app.use(cors())
app.use(express.json())
app.use(routes)

server.listen(5555)