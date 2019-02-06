let chickenSvg = document.getElementById("data-chicken-svg")

Math.lerp = function (value1, value2, amount) {
	amount = amount < 0 ? 0 : amount
	amount = amount > 1 ? 1 : amount
	return value1 + (value2 - value1) * amount
};

let SvgUpdate = (new_value) => {
  let offset = Math.lerp(2000, 0, new_value / 20000)
  chickenSvg.contentDocument.getElementsByClassName("diamond")[0].setAttribute("style", `stroke-dashoffset: ${offset}`)
  chickenSvg.contentDocument.getElementsByClassName("diamond")[1].setAttribute("style", `stroke-dashoffset: ${offset}`)
  chickenSvg.contentDocument.getElementsByClassName("diamond")[2].setAttribute("style", `stroke-dashoffset: ${offset}`)
}

export default SvgUpdate
