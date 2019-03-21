import { init } from 'ityped'

let oneElement = document.querySelector('#one')
let twoElement = document.querySelector('#two')
init(oneElement, { showCursor: false, strings: ['Paris', 'Moscow' ], backDelay: 3000 });
init(twoElement, { showCursor: false, strings: ['Minsk', 'Berlin' ], backDelay: 3000 });
