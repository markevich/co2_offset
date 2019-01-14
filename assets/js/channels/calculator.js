import socket from "../socket";

let channel = socket.channel("calculator:1", {})
let plane = document.querySelector("#data-plane-value")
let planeSlider = document.querySelector("#data-plane-slider")
let beef = document.querySelector("#data-beef-value")
let car = document.querySelector("#data-car-value")
let chicken = document.querySelector("#data-chicken-value")
let etnoVolcano  = document.querySelector("#data-etno-volcano-value")
let human = document.querySelector("#data-human-value")
let petrol = document.querySelector("#data-petrol-value")
let train = document.querySelector("#data-train-value")

let lastOccurance = Date.now()
planeSlider.addEventListener("input", event => {
  if(Date.now() - lastOccurance > 50) {
    channel.push("value_updated", {plane_km: planeSlider.value})

    lastOccurance = Date.now()
  }
})

channel.on("value_updated", payload => {
  let new_values = payload.new_values
  planeSlider.value = new_values.plane.km

  plane.innerHTML = new_values.plane.km
  beef.innerHTML = new_values.beef.kg
  car.innerHTML = new_values.car.km
  chicken.innerHTML = new_values.chicken.kg
  etnoVolcano.innerHTML = new_values.etno_volcano.seconds
  human.innerHTML = new_values.human.days
  petrol.innerHTML = new_values.petrol.liters
  train.innerHTML = new_values.train.km
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default channel
