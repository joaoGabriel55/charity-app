const dotenv = require('dotenv')

const session = require('express-session')
const Keycloak = require('keycloak-connect')

dotenv.config();

let _keycloak


const keycloakConfig = {
    clientId: process.env.CLIENT_ID,
    bearerOnly: true,
    serverUrl: process.env.KEYCLOAK_AUTH_URL,
    realm: process.env.REALM,
    sslRequired: 'external',
    realmPublicKey: process.env.PUBLIC_KEY
}

function initKeycloak() {
    if (_keycloak) {
        console.warn("Trying to init Keycloak again!")
        return _keycloak
    } else {
        console.log("Initializing Keycloak...")
        const memoryStore = new session.MemoryStore()
        _keycloak = new Keycloak({ store: memoryStore }, keycloakConfig)
        // console.log(_keycloak.stores)
        return _keycloak
    }
}

function getKeycloak() {
    if (!_keycloak) {
        console.error('Keycloak has not been initialized. Please called init first.')
    }
    return _keycloak
}

module.exports = {
    initKeycloak,
    getKeycloak
}