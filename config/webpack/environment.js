const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')

const webpack = require('webpack');
environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    JQuery: 'jquery',
    jquery: 'jquery',
    'window.Tether': "tether",
    Popper: ['popper.js', 'default'], // for Bootstrap 4
  })
)

environment.loaders.prepend('coffee', coffee)
module.exports = environment
