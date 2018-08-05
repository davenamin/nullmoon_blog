---
title: "Preliminary DOTA2 Analysis, July-September 2012"
date: 2014-01-01T17:00:00-04:00
slug: "dota2-analysis-july-september-2012"
---

This past fall I had to write an analysis on a categorical
dataset. I'm not a statistician or a researcher in my day-to-day life,
so I don't have a seasoned set of data to fall into. Faced with the
problem of finding some data to care about, I figured this was an
opportunity to do some meta-learning in the two social activities I
started to explore late 2013 - committing online dating faux pas and
getting owned in _DOTA2_.

* * *

My original plan was to analyze variable effects on "attractiveness"
in a mythical OKCupid dataset on Infochimps.com - but the data was
nowhere to be found! There are some really killer posts on how to
scrape together a dataset (like
[this](http://axiomofcats.com/2012/07/30/data-mining-okcupid/)) but I
needed something quicker. Someday I'll revisit that decision.

* * *

Fortunately, I stumbled onto some excellent sites
(i.e. [Dotametrics](http://dotametrics.wordpress.com/)) which uncover
interesting trends in _DOTA2_ match data. I shopped around for sources
of data - there's a sweet [dev community](http://dev.dota2.com) with
documentation of Valve's WebAPI which lets just about anyone query
every _DOTA2_ match, ever. Convenient, with clear and permissive
ToS. Walking around on the boards helped me to find a nicely packaged
dataset of *every match played up until November 2012* created by a
user "Sproinknet". Exactly what I needed! One install of PostgreSQL,
Python, Psycopg, and R later, I was ready to roll.

My analysis concentrated on the timeframe between **July 27, 2012**
and **September 20, 2012**. The specific timeframe used was chosen to
minimize the effect of _DOTA2_ software updates on match
outcomes. During this timeframe, Valve did not modify the available
hero selection and [instead encouraged professional teams to prepare
for the second "The International"
tournament](http://blog.dota2.com/2012/07/and-then-there-were-18/). The
dataset includes the month of stability prior to "The International
2", the week of "The International" tournament, and the subsequent
three weeks following the tournament up until the day before [Valve
released the next major _DOTA2_ software
update](http://blog.dota2.com/2012/09/the-greatest-update/).


The timeframe is also great because, really, who cares? A lot has
changed since 2012 - new heroes have been added, lots of balancing
patches have been made, and there's been another "The International"
tournament. I figured it was a good way to create some (albeit quite
shoddy) tools to quickly work up pictures in ggplot2.

* * *

I'm not going to put up the all the original analysis - essentially I
built a lookup table from scraping the [Valve
Heropedia](http://www.dota2.com/heroes/) for each hero to get
classifications, such as "Carry", "Support", "Jungler", etc. I
filtered on all of the timesliced matches at the *Very High* level of
play with no disconnects, and ran the winning / losing team
compositions through a Python script to count the number of hero
classifications. This created a derivative dataset where each
observation corresponded to a number of quantitiative team composition
variables ("number of Disabler heroes") and a binary match outcome
("team was victorious"). The final dataset contained observations from
31186 matches (so 62372 observations, if I did that right).

Some histograms (created with ggplot2):

![Frequency of Carry heroes split by match outcome. Teams tended to
consist of 2 or 3 carries, and this composition also tended to
win.](histo_carry.png)

![Frequency of Support heroes split by match
outcome.](histo_support.png)


I fit a number of logistic models and ended up finding the number of
"carry" heroes had a significant effect on the likelihood of match
victory (duh!) but couldn't get the number of "support" heroes to
affect probability of match success.

For posterity, the final model consisted of:

* positive linear association for "durable", "escape", "initiator",
  and "nuker" heroes
* negative linear association for "support" heroes
* squared interactions (positive then negative association) for
  "carry" and "disabler" heroes

My coworkers are pretty smart and some of them play _DOTA2_. I asked
one why he thought supports wouldn't be significant.

>"Valve's hero classifications suck."

He gave some examples that I've forgotten (something about Skeleton
King being classified as a "carry" maybe?), but I've been ruminating
on his underlying premise. I have some ideas on how to get stronger
conclusions from looking at the same timeslice of matches. I hope to
write up a post with any results from that line of thought.
