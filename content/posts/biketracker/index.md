---
title: "bike tracker adventures"
date: 2018-02-24T15:25:32-04:00
slug: gps-adventures
draft: true
status: "this project is still underway..."
---

## the motivation ##
A while ago I started bicycling with my landlord. The rides were very
relaxing and a great way to get in shape. Every now and again, my
landlord would show me our ride history captured from his Garmin bike
computer. It was really cool to see our fitness and range improving
over the course of the season.

I am terrible at remembering or keeping track of things. I decided I
would figure out how to build a simple bike tracker that would
remember where and when I had biked.

I needed some components and I'm not savvy with electronics, but
thought I could find a GPS module that spits out [NMEA
strings](http://www.gpsinformation.org/dale/nmea.htm) and wire it up
to a [CHIP](https://getchip.com/) or a [Raspberry
Pi](https://www.raspberrypi.org/). I found this [25 dollar GPS
unit](https://www.amazon.com/gp/product/B018DW8QNO/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1)
and bought it. Then I put it in a drawer, unopened.

After a few years, I decided it was time to actually build the
tracker. I took the GPS unit out of the bag and hooked it up to a
[Serial to USB
converter](https://learn.sparkfun.com/tutorials/cp2102-usb-to-serial-converter-hook-up-guide). To
my horror I was greeted with a wall of binary garbage instead of human
readable text. Investigations on the net yielded information from
pawelsky at RCGroups and a forum thread at LibrePilot showing the GPS
unit was:

1. meant to be a replacement part for a [DJI
   drone](https://www.dji.com/naza-m-v2)
2. a Chinese clone running [pawelsky's closed source but freely
   available
   firmware](https://www.rcgroups.com/forums/showthread.php?2290346-Naza-v1-v2-Lite-GPS-module-alternative-using-APM-2-6-GPS-compass-combo)
   targeted at the Arduino Pro Mini
3. unable to be easily modified due to [missing the Arduino
   bootloader](https://forum.librepilot.org/index.php?topic=449.msg4984#msg4984)
   on the ATMega 328p

This was frustrating. Even worse, the GPS wasn't getting a fix. The 4
wire output of the unit goes to the AVR, not the uBlox, so no easy way
to debug the situation.

I took a break and promptly forgot about the GPS unit altogether.

Recently I finished another _side project_ involving solder and
[Adafruit's Feather HUZZAH](https://www.adafruit.com/product/2821)
which was a pleasure to use thanks to the well-polished libraries and
active community. It also reminded me that I probably have most of the
things I need at this point to resume the GPS adventure.

## analyzing the uBlox ##
The GPS module is a custom board but is running the closed source
pawelsky firmware, which means it has to be acting like a combined
Arduino Pro Mini and [pawelsky's
shield](https://oshpark.com/shared_projects/Ehm2RZPY). Also
interesting are the six (very small!) breakouts on the board. An AVR
programmer has six pins too. I took a wild chance and made some very
flimsy connections to these points. They correspond to pins 1-6 of
[this
diagram](https://www.arduino.cc/en/uploads/Tutorial/ICSP_connector_pinout.png),
and I used an old Arduino Duemilanove I had as an [AVR
programmer](https://www.arduino.cc/en/Tutorial/ArduinoISP) to push
Arduino Pro Mini sketches to the ATMega328 on the board.

{{<img gps_wires>}}a bike tracker in progress{{</img>}}

Not a great solder job, but trust me, I've come a long way.

Now I wanted to connect to the uBlox GPS unit using
[uCenter](https://www.u-blox.com/en/product/u-center-windows) to see
why the unit can't get a fix. Looking at the BRD file for pawelsky's
shield in
[EAGLE](https://www.autodesk.com/products/eagle/free-download) showed
the pins needed to modify the Arduino
[SoftwareSerialExample](https://www.arduino.cc/en/Tutorial/SoftwareSerialExample)
to pass through the serial connection to the uBlox. (Later, I found
that pawelsky [has a great diagram
here](https://www.rcgroups.com/forums/showthread.php?2290346-Naza-v1-v2-Lite-GPS-module-alternative-%28using-APM-2-6-GPS-compass-combo%29/page20#post30987654)
that contains all of the relevant information needed to make new
sketches!) The modified sketch - the only things changed are the pins
and baud rate:

```c
#include <SoftwareSerial.h>

SoftwareSerial mySerial(8, 9); // RX, TX

void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // set the data rate for the SoftwareSerial port
  mySerial.begin(9600);
  Serial.println("Hello, world?");
}

void loop() { // run over and over
  if (mySerial.available()) {
    Serial.write(mySerial.read());
  }
  if (Serial.available()) {
    mySerial.write(Serial.read());
  }
}
```

I tried to flash the uBlox with newer firmware in uCenter, but
discovered this module doesn't seem to be flashable. Some more digging
online suggests the uBlox is not actually a Neo-M8N (it looks like a
[M8030-KT](https://forum.u-blox.com/index.php?qa=4976&qa_1=is-my-m8n-module-using-real-m8n),
though there is some sort of extra chip) - disappointing, but I guess
I got what I paid for.

There's still some value to be had since it's a compact unit which is
loosely equivalent to having an Arduino attached to a uBlox breakout
board. After playing around with uCenter I thought the module wasn't
picking up enough signal, but cross-referencing it against an
[Adafruit GPS unit](https://www.adafruit.com/product/1059) suggests
that the problem is due to the test location, not the unit. Even
though I can't update the firmware, the unit still has some writable
memory (the extra chip under the metal cap?) which I'll utilize to
make a "set it and forget it" solution.

## building the tracker ##
I really like [Adafruit](https://www.adafruit.com/). An AdaBox
subscription has given me enough pieces to attempt reasonable projects
and the tutorials and examples are really helpful for getting
started. I've ordered from (and read some really helpful explanations
at) [SparkFun](https://www.sparkfun.com/) as well, but having a few
AdaBox sets lying around really lowers the barrier to cobbling
together a weekend project.

Combining the GPS unit with a Feather HUZZAH and an OLED Featherwing
board that couples with it yields all of the essentials for a
bare-bones bike computer! The goal is to have the HUZZAH display some
basic information when on the road and harness the datalogging
capability of the uBlox to let the HUZZAH push GPS tracks to a server
when I get home.

The basic control flow is:

On the GPS/ATMega328 side - on startup, ensure there is a circular log
file, tell the uBlox to append to the log and disable the NMEA output
to the serial connection. Afterward, either pass-through serial
traffic to the uBlox, or if nothing is communicating with the uBlox
output the compass heading and elapsed time ticks to the serial
connection.

On the HUZZAH/display side - on startup, try to connect to my WiFi,
and if that's possible, push all logged data from the uBlox to a web
service. afterward, display heading, time, distance travelled, and/or
velocity depending on the last pressed button on the display board (A,
B, or C).

### GPS sketch ###

### Feather sketch ###
