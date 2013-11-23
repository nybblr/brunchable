user = require('../controllers/user')
root = require('../controllers/root')

exports.load = (app) ->
  app.get('/', root.index)
  app.get('/users', user.list)
