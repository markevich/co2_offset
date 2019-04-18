import {
  init,
} from 'ityped';

const oneElement = document.querySelector('#one');
const twoElement = document.querySelector('#two');
if (oneElement && twoElement) {
  init(oneElement, {
    showCursor: false,
    strings: ['Paris', 'Moscow'],
    backDelay: 3000,
  });
  init(twoElement, {
    showCursor: false,
    strings: ['Minsk', 'Berlin'],
    backDelay: 3000,
  });
}
