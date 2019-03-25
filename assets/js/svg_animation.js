const chickenSvg = document.getElementById('data-chicken-svg');

Math.lerp = function lerp(value1, value2, amount) {
  let newAmount = amount;
  newAmount = newAmount < 0 ? 0 : newAmount;
  newAmount = newAmount > 1 ? 1 : newAmount;
  return value1 + (value2 - value1) * newAmount;
};

const SvgUpdate = (newValue) => {
  const offset = Math.lerp(2000, 0, newValue / 20000);
  chickenSvg.contentDocument.getElementsByClassName('diamond')[0].setAttribute('style', `stroke-dashoffset: ${offset}`);
  chickenSvg.contentDocument.getElementsByClassName('diamond')[1].setAttribute('style', `stroke-dashoffset: ${offset}`);
  chickenSvg.contentDocument.getElementsByClassName('diamond')[2].setAttribute('style', `stroke-dashoffset: ${offset}`);
};

export default SvgUpdate;
