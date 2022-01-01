---
title: "Geometric Algebra"
date: 2022-01-01T10:27:17-05:00
---

Happy new year! One of my resolutions for this year will be to write
up and finish at least one _side project_ within 2022.

---

I missed opportunities for learning intuitions about foundational math
during my undergraduate education. One reminder of this is whenever
the subject of [Linear
Algebra](https://en.wikipedia.org/wiki/Linear_algebra) comes up (which
is far more often than my undergraduate-age self would have thought!)

Fortunately there is an abundance of high quality educational
resources online and a couple of years ago I finished working through
[Dr. van de Geijn and Dr. Myers' excellent course on Linear Algebra:
Foundations to
Frontiers](https://www.edx.org/course/linear-algebra-foundations-to-frontiers). I
**highly** recommend the course. The course videos, the exercises and
solutions, and the general flow through the material were all
excellent. The instructors may be hanging up their hats, but [all of
the materials are available at their website](http://www.ulaff.net/)
and working through their Advanced Linear Algebra course is on my
to-do list.

There's two ways this topic keeps popping up for me. One is whenever
data/statistics/optimization methods are involved. From what I've seen
for these applications, algorithms and techniques often build on
manipulating systems of linear equations. Getting a better feel for
how systems of linear equations are compactly represented in matrix
notation and the operations that can be performed on these matrices
seems necessary to attack problems like [Convex
Optimization](https://www.edx.org/course/convex-optimization). The
link is to another course that I'm (very) slowly working through due
to a lack of mathematical maturity.

The other way is more directly related to my current _side
projects_. An initial problem when working with sensors (say a
[Software Defined Radio](https://greatscottgadgets.com/hackrf/one/) or
a
[camera](https://opencv.org/introducing-oak-spatial-ai-powered-by-opencv/))
is converting measurements from the sensor into something else, such
as positional information. There are already ready-made solutions to
this problem, depending on the sensor, but understanding how they work
generally seems to involve coordinate systems and vector quantities
(and other things as well! [Michael Ossman's course on
DSP](https://greatscottgadgets.com/sdr/) is yet another course I began
to dip my toes into during 2021...) Coordinate system transformations,
at least in views of the world where straight lines can be parallel,
can be compactly represented as matrices. Things get complicated when
rotations are involved in three dimensional space, though the general
guidance I've run across suggests that
[quaternions](https://liorsinai.github.io/mathematics/2021/11/05/quaternion-1-intro.html)
are the smart way to go when thinking about rotations.

But quaternions (and the conceptually simpler complex numbers - which
are also related to rotations! [This brilliant
explanation](https://betterexplained.com/articles/a-visual-intuitive-guide-to-imaginary-numbers/)
really helped me land an intuition a few years back) also seem like a
weird one-off specific to three dimensional geometry problems. In
software development this sort of 'hard coding' is frowned upon,
though its not always avoidable. Quaternions seem a bit unintuitive to
me. Even the [story of how they were
discovered](https://archive.maths.nuim.ie/hamiltonwalk/HamiltonWalk20years.pdf)
hints at the whole concept being somewhat unusual.

It turns out there's a more general framework for thinking about
vectors that might help my depleted brain cells handle the sorts of
transformation problems that come up with sensors. Enter [Geometric
Algebra](https://marctenbosch.com/quaternions/), a helpful framework
for geometric manipulations.

I couldn't find course material for Geometric Algebra, but I did
purchase [Professor Alan Macdonald's
book](http://www.faculty.luther.edu/~macdonal/laga/) on the subject,
and recently I found his [Youtube Video series on Geometric
Algebra](https://www.youtube.com/playlist?list=PLLvlxwbzkr7igd6bL7959WWE7XInCCevt)
which is **awesome**.

Now that I've purchased a couple of
[ESP32-CAM](https://www.arducam.com/esp32-machine-vision-learning-guide/)
modules and have a new _side project_ idea, I'm hoping to use this as
motivation to work through Dr. Macdonald's book and build a better
applied math foundation in my head.
