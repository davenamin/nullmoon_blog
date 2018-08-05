---
title: "plotface"
date: 2015-12-26T06:03:32-04:00
slug: "plotface-zilla"
---

I've been doing some work with visualization lately. I enjoy using
[R](https://www.r-project.org/) quite a bit and for the recent work I
utilized the ggplot2 and Shiny packages to quickly prototype a tool
for exploring a large dataset.

Though I didn't have a chance to integrate it into my work, I was
really excited to read about [Plot.ly](https://plot.ly) and their
recent open-sourcing. Can I plot onto this blog without having to
utilize Shiny? Let's find out:

<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
<div id="tester" style="width:600px;height:250px;"></div>

<script>
TESTER = document.getElementById('tester');
Plotly.newPlot( TESTER, 
[{
x: [1, 2, 3, 4, 5],
y: [2, 4, 8, 16, 32] 
}], 
{ margin: { t: 0 } },
{ showLink: false,
  sendData: false,
  displaylogo: false,
  displayModeBar: false
} );
</script>

Awesome.
