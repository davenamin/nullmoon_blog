---
title: "SDR Power"
date: 2016-02-06T21:44:57-04:00
slug: "sdr-power"
---


I'm a sucker for electronics - especially items that offer a lot of
new opportunities for very small investments. Case in point, [RTL
SDR](http://sdr.osmocom.org/trac/wiki/rtl-sdr). Buying an inexpensive
USB dongle lets someone like me with no experience get some toes into
the weird and cool world of [Software Defined
Radio](https://en.wikipedia.org/wiki/Software-defined_radio).

I've gotten the device to play nicely with my [Beaglebone
Black](http://beagleboard.org/BLACK) and can pipe data over to a
workstation using
[rtl_tcp](http://sdr.osmocom.org/trac/wiki/rtl-sdr#rtl_tcp). I ran
into two quick gotchas, but it didn't take too long to get past them:

* The Beaglebone seems to be much happier when I set the cpufreq
  governor to "performance" - no more stuttering samples!
* Trying to use a WiFi connection to get data off the Beagle is a bad
  idea. Trying to use the USB network connection is a better idea, but
  it turns out the amount of data getting pumped through is enough to
  saturate the link. Right now everything is working by using the
  Ethernet connection.

Here's a quick plot of the spectrum I can see in my area! ([still want
to get my hands wet with Plotly..](https://plot.ly/javascript/))

<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
<div id="tester" style="width:800px;height:600px;"></div>

<script>
TESTER = document.getElementById('tester');
Plotly.d3.csv('cleaned_data.csv', function(err, rows){

    function unpack(rows, key) {
        return rows.map(function(row) { return row[key]; });
    }
    function unpackMhz(rows, key) {
     return rows.map(function(row) { return row[key]/1000000;});
    }

    var time = unpack(rows, 'time'),
        freq = unpackMhz(rows, 'freq'),
        db = unpack(rows, 'db');
    //freq = freq.map(function(val){val/1000});
    var data = [{
        type: 'heatmap',
        x: freq,
        y: time,
        z: db,
        colorbar: {title: "SNR (dB)"}
    }];

    var layout = {
        title: '15 min of spectrum',
        xaxis:{exponentformat:"none",
               title: "Frequency (MHz)"}
    };

    Plotly.plot(TESTER, data, layout, { showLink: false,
  sendData: false,
  displaylogo: false,
  displayModeBar: false
});

});
</script>
