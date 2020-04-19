---
title: "salt lamp v2"
date: 2020-04-19T11:00:03-04:00
draft: true
---

A couple of years ago, I bought a [salt
lamp](https://rationalwiki.org/wiki/Salt_lamp) when it was a fad. Not
for the 'health benefits', but I thought it was really cool that
someone would ship a block of something [incredibly valuable in
ancient times](https://en.wikipedia.org/wiki/History_of_salt) across
the world for less than $20 total.

The lamp electronics were pretty rudimentary, but the block itself has
a nice base with a hollow core for the lamp bulb, and made for a nice
weekend _side project_. I put in a strand of [WS2812b RGB
LEDs](https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf) connected
to an [Adafruit Feather
HUZZAH](https://learn.adafruit.com/adafruit-feather-huzzah-esp8266). 

The logic was pretty straightforward:
* On start, the HUZZAH would poll a [location
  service](https://ip-api.com/) and a [time
  service](https://time.gov/) to populate an attached [RTC
  module](https://cdn-shop.adafruit.com/product-files/3013/DS3231.pdf).
* Every 15min, the HUZZAH would poll the [Dark Sky
  API](https://darksky.net/dev) to get the forecast for the upcoming
  hour, and color the LEDs accordingly.

LED colors loosely followed the rhyme from the [Hancock
building](https://en.wikipedia.org/wiki/Berkeley_Building) in Boston:

> Steady blue, clear view.  Flashing blue, clouds due.  Steady red,
> rain ahead.  Flashing red, snow instead.

It was also a cool opportunity to learn about [Linear Congruential
Generators](https://en.wikipedia.org/wiki/Linear_congruential_generator),
a simple random number generator, which I used to vary the LED
transition patterns.

Unfortunately, being jammed into a small space surrounded by salt and
heat in an environment with changing humidity for several years did
not agree with the HUZZAH. A couple of months ago, the lamp stopped
functioning normally. Additionally, [Apple just acquired Dark
Sky](https://blog.darksky.net/dark-sky-has-a-new-home/) and the API
will be shutting down.

---

I don't have another HUZZAH to drop in, but I thought of building an
updated version with an [Adafruit Circuit Playground
Bluefruit](https://learn.adafruit.com/adafruit-circuit-playground-bluefruit)
I have. This would let me redo the logic in Python and is one of the
microcontrollers I have on-hand that has a radio. Thinking more about
how I'd push updated weather information to the Bluefruit, I realized
I have a couple of [Raspberry Pi Zero
W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) still
lying around, and due to the crazy sale at Microcenter ($5 for each!)
they are much cheaper than the Bluefruit, even including the price of
the SD card.

Even better, the community has already figured out a way to let the
Raspberry Pi drive WS2812B LEDs *without* needing a
microcontroller-in-the-middle! The library is wrapped by the [python
package
`rpi_ws218x`](https://github.com/rpi-ws281x/rpi-ws281x-python). This
will let me program in Python, keep all the logic on one board, and
let me code/debug without needing to disturb the lamp, by SSHing into
the Pi Zero W! Overall a win.

The project is using [Alpine Linux](https://alpinelinux.org/) again,
because I want to avoid SD card corruption without needing to "shut
down" the lamp before unplugging it. I was originally planning to use
Adafruit's `adafruit-circuitpython-neopixel` package, but the RPi Zero
W is memory constrained and the Adafruit package relies on
`rpi_ws281x` anyway.


---

WIP notes: 

add `iommu=relaxed` to `cmdline.txt`

`apk add python3-dev libstdc++ musl-dev`

`apk add gcc make`

`pip3 install rpi_ws281x`

`lbu add /usr/lib/python3.8`
