
###
 # Module dependencies.
###

express = require('express')
routes = require('./config/routes')
http = require('http')
path = require('path')
faye = require('faye')

app = express()

# all environments
app.set('port', process.env.PORT || 3000)
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.json())
app.use(express.urlencoded())
app.use(express.methodOverride())
app.use(app.router)
app.use(express.static(path.join(__dirname, '../public')))

# development only
if app.get('env') is 'development'
  app.use(express.errorHandler())

routes.load(app)

server = http.createServer(app)
bayeux = new faye.NodeAdapter(mount: '/bayeux', timeout: 45)
bayeux.attach(server)

bayeux.on 'publish', (clientId, channel, data) ->
  console.log "Client ##{clientId} posted #{JSON.stringify data} to #{channel}."

bayeux.on 'handshake', (clientId) ->
  console.log "Client ##{clientId} connected."

server.listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))

