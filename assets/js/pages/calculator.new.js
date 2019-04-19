import '../../css/pages/calculator.new.css';

import LiveSocket from 'phoenix_live_view';

const liveSocket = new LiveSocket('/live');
liveSocket.connect();
