// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import '../css/app.css';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
// import "phoenix_html"

import LiveSocket from 'phoenix_live_view';
import './channels/calculator';
import './calculator';

const liveSocket = new LiveSocket('/live');
liveSocket.connect();
