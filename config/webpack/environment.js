const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const webpack = require('webpack');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  'jquery-ui/widget': 'blueimp-file-upload/js/vendor/jquery.ui.widget.js'
}));

environment.loaders.append('typescript', typescript)
module.exports = environment
