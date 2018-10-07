---
title: "a year of sleep"
date: 2018-10-07T14:44:37-04:00
slug: "gradsleep"
---

<script src="/vega/vega.min.js"></script>
<script src="/vega/vega-embed.min.js"></script>
  <!-- Container for the visualization -->
  <div id="vis"></div>
<script>
var vlSpec = {
    "$schema": "https://vega.github.io/schema/vega/v4.json",
    "description": "sleep status",
    "width": 800,
    "height":600,
    "autosize": {
	"type": "fit",
	"resize": true,
    },
    "data": [{ 
	"url": "sleep.csv",
	"name": "sleep",
	"format": {
	    "type": "csv",
	    "parse": {
		"date":'utc:"%m/%d/%y"',
		"sleep":'utc:"%H:%M"',
		"wake":'utc:"%H:%M"',
		"hours":'number'
	    }
	},
	"transform": [
	    {"type":"formula",
	     "expr": 'utchours(datum.sleep)'+
	     '+ (utcminutes(datum.sleep) / 60)',
	     "as": "sleeph"},
	    {"type":"formula",
	     "expr": 'if(datum.sleeph < 12,'+
	     'datum.sleeph + 24, datum.sleeph)',
	     "as": "sleep1"},
	    {"type":"formula",
	     "expr":'datum.hours + datum.sleep1',
	     "as":"wake1"},
	],
    }],
    "scales": [
	{
	    "name":"xscale",
	    "type":"time",
	    "domain":{"data":"sleep", "field": "date"},
	    "range": "width",
	    "padding": 0.05,
	    "nice": "day"
	},
	{
	    "name":"yscale",
	    "type":"linear",
	    "domain":{"data": "sleep", "fields":["sleep1","wake1"]},
	    "nice": true,
	    "range":"height",
	    "zero": false
	},
    ],
    "axes": [
	{ "orient": "bottom", "scale":"xscale"},
	{ "orient":"left","scale":"yscale",
	  "encode": {
	      "labels":{
		  "update":{"text":{"signal":"datum.value % 24"}}
	      }
	  }
	}
    ],
    "signals": [
    	{
	    "name": "tooltip",
	    "value":{},
	    "on":[
		{"events": "rect:mouseover", "update": "datum"},
		{"events": "rect:mouseout", "update":"{}"}
	    ]
	}
    ],
    "marks": [

	{
	    "type":"rect",
	    "from": {"data":"sleep"},
	    "encode": {
		"enter":{
		    "x": {"scale":"xscale","signal": "utc(2015,4,30)"},
		    "x2": {"scale":"xscale","signal": "utc(2015,6,31)"},
		    "y":{"scale":"yscale", "signal": "min(datum.sleep1)"},
		    "y2":{"scale":"yscale","signal": "max(datum.wake1)"},
		    "fill": {"value": "coral"},
		    "tooltip":{
			"signal": "{'event': 'summer assistantship abroad'}"
		    }
		}
	    }
	},
	{
	    "type":"rect",
	    "from": {"data":"sleep"},
	    "encode": {
		"enter":{
		    "x": {"scale":"xscale","signal": "utc(2015,4,4)"},
		    "x2": {"scale":"xscale","signal": "utc(2015,4,12)"},
		    "y":{"scale":"yscale", "signal": "min(datum.sleep1)"},
		    "y2":{"scale":"yscale","signal": "max(datum.wake1)"},
		    "fill": {"value": "tomato"},
		    "tooltip":{
			"signal": "{'event': 'finals week'}"
		    }
		}
	    }
	},
	{
	    "type":"rect",
	    "from": {"data":"sleep"},
	    "encode": {
		"enter":{
		    "x": {"scale":"xscale","signal": "utc(2015,11,11)"},
		    "x2": {"scale":"xscale","signal": "utc(2015,11,19)"},
		    "y":{"scale":"yscale", "signal": "min(datum.sleep1)"},
		    "y2":{"scale":"yscale","signal": "max(datum.wake1)"},
		    "fill": {"value": "tomato"},
		    "tooltip":{
			"signal": "{'event': 'finals week'}"
		    }
		}
	    }
	},
	{
	    "type":"rect",
	    "from": {"data":"sleep"},
	    "encode": {
		"enter":{
		    "x": {"scale":"xscale","signal": "utc(2015,11,28)"},
		    "x2": {"scale":"xscale","signal": "utc(2016,0,26)"},
		    "y":{"scale":"yscale", "signal": "min(datum.sleep1)"},
		    "y2":{"scale":"yscale","signal": "max(datum.wake1)"},
		    "fill": {"value": "aquamarine"},
		    "tooltip":{
			"signal": "{'event': 'winter break'}"
		    }
		}
	    }
	},
	{
	    "type":"rect",
	    "from": {"data":"sleep"},
	    "encode": {
		"enter":{
		    "x": {"scale":"xscale","field": "date"},
		    "width":{"value": 2},
		    "y":{"scale":"yscale", "field": "sleep1"},
		    "y2":{"scale":"yscale","field": "wake1"},
		    "tooltip":{
			"signal": "{" +
			    "'sleep': format(utchours(datum.sleep), '02d')"+
			    "+ ':' + format(utcminutes(datum.sleep), '02d'),"+
			    "'wake': format(utchours(datum.wake), '02d')"+
			    "+ ':' + format(utcminutes(datum.wake), '02d')}"
		    }
		}
	    }
	},
    ]
};

// Embed the visualization in the container with id `vis`
vegaEmbed("#vis", vlSpec,
          {"actions": false, "hover": false});
</script>

_What are we looking at?_ These are recorded sleep times from 2015 and
2016, when I was a full-time graduate student. I generally would fall
asleep within 15 minutes of marking the "sleep time".

Some semester-related events are noted on the graphic. I need to pull
out the difference between pre- and post- midterm sleep hours as well as
vacation and school year sleep.

_Where did the data come from?_ A couple of years ago I had a [phone
with a charging
dock](https://en.wikipedia.org/wiki/Sony_Xperia_Z1_Compact) that could
launch apps when docked. I got the idea to run [a sleep
tracker](http://mysleepbot.com/) from some colleagues and used it to
collect the data shown above. I should have more, but lost maybe an
extra year's worth of data when the SD card (and later, the phone
itself) fizzed out.  My subsequent phones haven't come with docks so
I've lost the habit of clocking in before bedtime.
