/* eslint no-console:0 */

// RailsUjs is *required* for links in Lucky that use DELETE, POST and PUT.
// Though it says "Rails" it actually works with any framework.
import RailsUjs from "rails-ujs";

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
import Turbolinks from "turbolinks";

RailsUjs.start();
Turbolinks.start();

// If using Turbolinks, you can attach events to page load like this:
//
document.addEventListener("turbolinks:load", function() {
  document.querySelector("#conversion-currency").addEventListener("change", function() {

  })
  document.querySelector("#base-currency").addEventListener("change", function() {

  })
  document.getElementById("converter-form").addEventListener("ajax:success", function(e) {
    let body = e.detail[0]
    console.log(body.data)
    let output = document.querySelector("#converted-rate").innerHTML = body.data;
  })
})
