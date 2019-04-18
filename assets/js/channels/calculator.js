import socket from '../socket';
import SvgUpdate from '../svg_animation';

const channel = socket.channel('calculator:1', {});
const co2ValueInput = document.querySelector('#data-co2-value');
const plane = document.querySelector('#data-plane-value');
const planeSlider = document.querySelector('#data-plane-slider');
const beef = document.querySelector('#data-beef-value');
const car = document.querySelector('#data-car-value');
const chicken = document.querySelector('#data-chicken-value');
const etnoVolcano = document.querySelector('#data-etno-volcano-value');
const human = document.querySelector('#data-human-value');
const petrol = document.querySelector('#data-petrol-value');
const train = document.querySelector('#data-train-value');

let lastOccurance = Date.now();
if (planeSlider) {
  planeSlider.addEventListener('input', () => {
    if (Date.now() - lastOccurance > 50) {
      channel.push('value_updated', {
        plane_km: planeSlider.value,
      });

      lastOccurance = Date.now();
    }
  });
}


channel.on('value_updated', (payload) => {
  const newValues = payload.new_values;
  planeSlider.value = newValues.plane.km;

  SvgUpdate(newValues.plane.km);

  co2ValueInput.innerHTML = newValues.co2;
  plane.innerHTML = newValues.plane.km;
  beef.innerHTML = newValues.beef.kg;
  car.innerHTML = newValues.car.km;
  chicken.innerHTML = newValues.chicken.kg;
  etnoVolcano.innerHTML = newValues.etno_volcano.seconds;
  human.innerHTML = newValues.human.days;
  petrol.innerHTML = newValues.petrol.liters;
  train.innerHTML = newValues.train.km;
});

channel.join();

export default channel;
