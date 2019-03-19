---
title: "march madness"
date: 2019-03-17T22:33:58-04:00
slug: marchmadness
---

I've been participating in a March Madness bracket league for a few
years now. It's been a lot of fun! Unfortunately I don't know the
first thing about basketball or who plays it (though I've been meaning
to play [Barkley, Shut Up and Jam:
Gaiden](https://www.talesofgames.com/related_game/barkley-shut-up-jam-gaiden/)
for YEARS.) The league organizer, a colleague in grad school, swept me
in when he suggested looking at the problem as a statistical modeling
challenge. It even led to a poster presentation at the [New England
Statistics Symposium](https://nestat.org/events/symposium/)!

My general approach was based on data that [Ken
Massey](https://www.masseyratings.com/) continues to make available on
his excellent site. I grabbed a ranking composite for the NCAA
Division 1 teams and used [Principal Component
Analysis](https://en.wikipedia.org/wiki/Principal_component_analysis)
to create an aggregate ranking for each team. The different ranking
systems are highly correlated with one another, so the first principal
component captures the lion's share of the variance. I used the
aggregate ranking for each team in a simple penalized logistic
regression model fit against the games from that season:

$$
\Pr(\text{Team1 Wins}) = \frac{1}{1+\exp(\alpha x + \beta)}
$$

The model gives the probability that a higher ranked _Team1_ defeats a
lower ranked _Team2_ given the aggregate scores for each.

I wrote up a [Monte
Carlo](https://en.wikipedia.org/wiki/Monte_Carlo_method) bracket
simulator to use the probabilities from the regression model to
predict my bracket that year. There were a couple of issues: the
simulator was completely unnecessary as the model assumes conditional
independence between matches given team rankings, the bracket
predictions didn't account for different prediction weights such as
the "upset bonus" scoring rule (correctly predicting a worse-seeded
team defeating a better-seeded team counted "more" than vice versa),
and maybe most importantly -- I wrote most of the code the night
before after consuming copious amounts of
[Laphroaig](https://www.laphroaig.com/product/quarter-cask-70cl/).

That last issue was the real doozie. In fact, after the hangover
subsided, I found that some bugs in the model fitting routines meant
that my model output the probability _Team1 Is Ranked Higher_ given
the rankings, not _Team1 Wins_. That explained why my model supposedly
had 100% classification accuracy. Oops. The predictions (effectively
following the bracket seeding) landed in second-to-last place out of
roughly 50 brackets.

Cleaning up the bugs for the next year, however, landed third place!
Last year the predictions landed somewhere in the middle of the pack
and I experimented with replacing the bracket simulator with a mixed
integer linear program to account for prediction weighting. I didn't
have enough time to fully implement it before the tournament but it
wouldn't have significantly changed the outcome, partially due to the
simplicity of the regression model.

This year I rewrote the code in [Julia](https://julialang.org/)
(previously, everything was written in
[R](https://www.r-project.org/).) Aside from being a fun learning
opportunity, a fresh start in Julia let me leverage the excellent
[JuMP](https://github.com/JuliaOpt/JuMP.jl) package. I also spent some
time fitting a model with [Flux](https://github.com/FluxML/Flux.jl),
but that was just an experiment -- I ended up using the [GLMNet Julia
port](https://github.com/JuliaStats/GLMNet.jl) to fit the same simple
regression model (there's always next year!) I also inadvertently
reintroduced, but fortunately caught, the "probability _Team1 Is
Ranked Higher_ given the rankings" bug this year. This time I started
drinking
[Cragganmore](https://www.malts.com/en-row/our-whisky-collection/cragganmore/cragganmore-12-years-old/)
AFTER identifying and fixing the bug.


We'll see how the predictions fare -- the code is MUCH cleaner but I'm
also much less familiar with the tools, so the potential for semantic
bugs is high. Still, I'm declaring victory since the code produced a
reasonable looking bracket. Just to quantify the large amount of
uncertainty in the model, the expected number of prediction points is
77.03 out of a possible 231 points (we use Fibonacci scoring). Here's
a visualization of the output!

The left shows the bracket predictions from
JuMP/[GLPK](http://www.gnu.org/software/glpk/) while the right shows
the estimated point values per matchup given to the optimizer. This
was a quick debugging plot I made as a smoke test, but it has the side
effect of summarizing the final results succinctly.

<script src="/vega/vega.min.js"></script>
<script src="/vega/vega-embed.min.js"></script>
  <!-- Container for the visualization -->
  <div id="vis"></div>
<script>
vlSpec={
  "autosize": "pad",
  "padding": 5,
  "data": [
    {
      "name": "source_0",
      "values": [
        {
          "expected": 1.8594807935817257,
          "win": 1,
          "team": "Duke",
          "round": "First Round"
        },
        {
          "expected": 1.049633956916049,
          "win": 1,
          "team": "Duke",
          "round": "Second Round"
        },
        {
          "expected": 0.9287252110209678,
          "win": 1,
          "team": "Duke",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7267104489112778,
          "win": 1,
          "team": "Duke",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5918836992806563,
          "win": 1,
          "team": "Duke",
          "round": "Final Four"
        },
        {
          "expected": 0.4732293754472537,
          "win": 0,
          "team": "Duke",
          "round": "National Championship"
        },
        {
          "expected": 0.1405192064182743,
          "win": 0,
          "team": "N Dakota St",
          "round": "First Round"
        },
        {
          "expected": 0.143272573273227,
          "win": 0,
          "team": "N Dakota St",
          "round": "Second Round"
        },
        {
          "expected": 0.16544106289170213,
          "win": 0,
          "team": "N Dakota St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.12673790628014614,
          "win": 0,
          "team": "N Dakota St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.11450459528945225,
          "win": 0,
          "team": "N Dakota St",
          "round": "Final Four"
        },
        {
          "expected": 0.08851248817420641,
          "win": 0,
          "team": "N Dakota St",
          "round": "National Championship"
        },
        {
          "expected": 0.7496307127708404,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "First Round"
        },
        {
          "expected": 0.9035354672728934,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Second Round"
        },
        {
          "expected": 0.6873843669121311,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5314659739734096,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4464674821907956,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Final Four"
        },
        {
          "expected": 0.3613493540325653,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "National Championship"
        },
        {
          "expected": 1.2503692872291596,
          "win": 1,
          "team": "UCF",
          "round": "First Round"
        },
        {
          "expected": 0.9035580025378307,
          "win": 0,
          "team": "UCF",
          "round": "Second Round"
        },
        {
          "expected": 0.6874106145116321,
          "win": 0,
          "team": "UCF",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5314874062240297,
          "win": 0,
          "team": "UCF",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4464848917508311,
          "win": 0,
          "team": "UCF",
          "round": "Final Four"
        },
        {
          "expected": 0.36136346333599956,
          "win": 0,
          "team": "UCF",
          "round": "National Championship"
        },
        {
          "expected": 1.491838411213134,
          "win": 1,
          "team": "Mississippi St",
          "round": "First Round"
        },
        {
          "expected": 0.8684195529302292,
          "win": 0,
          "team": "Mississippi St",
          "round": "Second Round"
        },
        {
          "expected": 0.7903207310649042,
          "win": 0,
          "team": "Mississippi St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5829191478735175,
          "win": 0,
          "team": "Mississippi St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4752288572766788,
          "win": 0,
          "team": "Mississippi St",
          "round": "Final Four"
        },
        {
          "expected": 0.39507661614906575,
          "win": 0,
          "team": "Mississippi St",
          "round": "National Championship"
        },
        {
          "expected": 0.508161588786866,
          "win": 0,
          "team": "Liberty",
          "round": "First Round"
        },
        {
          "expected": 0.6963195614058049,
          "win": 0,
          "team": "Liberty",
          "round": "Second Round"
        },
        {
          "expected": 0.5025456896955975,
          "win": 0,
          "team": "Liberty",
          "round": "Sweet 16"
        },
        {
          "expected": 0.37259959624937206,
          "win": 0,
          "team": "Liberty",
          "round": "Elite Eight"
        },
        {
          "expected": 0.30539990297392505,
          "win": 0,
          "team": "Liberty",
          "round": "Final Four"
        },
        {
          "expected": 0.24254827696907172,
          "win": 0,
          "team": "Liberty",
          "round": "National Championship"
        },
        {
          "expected": 1.6437068454137127,
          "win": 1,
          "team": "Virginia Tech",
          "round": "First Round"
        },
        {
          "expected": 1.0598358473088685,
          "win": 1,
          "team": "Virginia Tech",
          "round": "Second Round"
        },
        {
          "expected": 0.8116423468072189,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6336485112472897,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5295934902581486,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Final Four"
        },
        {
          "expected": 0.4230978400463663,
          "win": 0,
          "team": "Virginia Tech",
          "round": "National Championship"
        },
        {
          "expected": 0.3562931545862873,
          "win": 0,
          "team": "St Louis",
          "round": "First Round"
        },
        {
          "expected": 0.3754250383550972,
          "win": 0,
          "team": "St Louis",
          "round": "Second Round"
        },
        {
          "expected": 0.42652997709584606,
          "win": 0,
          "team": "St Louis",
          "round": "Sweet 16"
        },
        {
          "expected": 0.2778331966165076,
          "win": 0,
          "team": "St Louis",
          "round": "Elite Eight"
        },
        {
          "expected": 0.22901873356876437,
          "win": 0,
          "team": "St Louis",
          "round": "Final Four"
        },
        {
          "expected": 0.18504244027285313,
          "win": 0,
          "team": "St Louis",
          "round": "National Championship"
        },
        {
          "expected": 1.3818329899931352,
          "win": 1,
          "team": "Maryland",
          "round": "First Round"
        },
        {
          "expected": 0.8331884632082676,
          "win": 0,
          "team": "Maryland",
          "round": "Second Round"
        },
        {
          "expected": 0.7875480367161892,
          "win": 0,
          "team": "Maryland",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6362192869848167,
          "win": 0,
          "team": "Maryland",
          "round": "Elite Eight"
        },
        {
          "expected": 0.47826349937235185,
          "win": 0,
          "team": "Maryland",
          "round": "Final Four"
        },
        {
          "expected": 0.3975529479751355,
          "win": 0,
          "team": "Maryland",
          "round": "National Championship"
        },
        {
          "expected": 0.6181670100068648,
          "win": 0,
          "team": "Belmont",
          "round": "First Round"
        },
        {
          "expected": 0.7406764969792452,
          "win": 0,
          "team": "Belmont",
          "round": "Second Round"
        },
        {
          "expected": 0.5592610595824373,
          "win": 0,
          "team": "Belmont",
          "round": "Sweet 16"
        },
        {
          "expected": 0.48396949115819127,
          "win": 0,
          "team": "Belmont",
          "round": "Elite Eight"
        },
        {
          "expected": 0.36638690298291077,
          "win": 0,
          "team": "Belmont",
          "round": "Final Four"
        },
        {
          "expected": 0.3064228901814369,
          "win": 0,
          "team": "Belmont",
          "round": "National Championship"
        },
        {
          "expected": 1.5436190453298106,
          "win": 1,
          "team": "LSU",
          "round": "First Round"
        },
        {
          "expected": 1.015658417744208,
          "win": 1,
          "team": "LSU",
          "round": "Second Round"
        },
        {
          "expected": 0.8061351087738615,
          "win": 0,
          "team": "LSU",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6835434017347625,
          "win": 0,
          "team": "LSU",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5301994644985606,
          "win": 0,
          "team": "LSU",
          "round": "Final Four"
        },
        {
          "expected": 0.4235850980511384,
          "win": 0,
          "team": "LSU",
          "round": "National Championship"
        },
        {
          "expected": 0.45638095467018935,
          "win": 0,
          "team": "Yale",
          "round": "First Round"
        },
        {
          "expected": 0.4104766220682791,
          "win": 0,
          "team": "Yale",
          "round": "Second Round"
        },
        {
          "expected": 0.4769165149543619,
          "win": 0,
          "team": "Yale",
          "round": "Sweet 16"
        },
        {
          "expected": 0.38908798572713676,
          "win": 0,
          "team": "Yale",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2872467201084957,
          "win": 0,
          "team": "Yale",
          "round": "Final Four"
        },
        {
          "expected": 0.23688947404379754,
          "win": 0,
          "team": "Yale",
          "round": "National Championship"
        },
        {
          "expected": 1.3565223184745034,
          "win": 1,
          "team": "Louisville",
          "round": "First Round"
        },
        {
          "expected": 0.8959438208986017,
          "win": 0,
          "team": "Louisville",
          "round": "Second Round"
        },
        {
          "expected": 0.6726997019086255,
          "win": 0,
          "team": "Louisville",
          "round": "Sweet 16"
        },
        {
          "expected": 0.599421850679446,
          "win": 0,
          "team": "Louisville",
          "round": "Elite Eight"
        },
        {
          "expected": 0.47420825102700603,
          "win": 0,
          "team": "Louisville",
          "round": "Final Four"
        },
        {
          "expected": 0.39424338358188354,
          "win": 0,
          "team": "Louisville",
          "round": "National Championship"
        },
        {
          "expected": 0.6434776815254966,
          "win": 0,
          "team": "Minnesota",
          "round": "First Round"
        },
        {
          "expected": 0.8365342299105152,
          "win": 0,
          "team": "Minnesota",
          "round": "Second Round"
        },
        {
          "expected": 0.6084199056059639,
          "win": 0,
          "team": "Minnesota",
          "round": "Sweet 16"
        },
        {
          "expected": 0.490652682173073,
          "win": 0,
          "team": "Minnesota",
          "round": "Elite Eight"
        },
        {
          "expected": 0.38430605636314236,
          "win": 0,
          "team": "Minnesota",
          "round": "Final Four"
        },
        {
          "expected": 0.31601057409628913,
          "win": 0,
          "team": "Minnesota",
          "round": "National Championship"
        },
        {
          "expected": 1.7751679440955594,
          "win": 1,
          "team": "Michigan St",
          "round": "First Round"
        },
        {
          "expected": 1.0434582518664295,
          "win": 1,
          "team": "Michigan St",
          "round": "Second Round"
        },
        {
          "expected": 0.8847840933471971,
          "win": 1,
          "team": "Michigan St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7001887511719881,
          "win": 0,
          "team": "Michigan St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5712163019051838,
          "win": 0,
          "team": "Michigan St",
          "round": "Final Four"
        },
        {
          "expected": 0.4620473719727411,
          "win": 0,
          "team": "Michigan St",
          "round": "National Championship"
        },
        {
          "expected": 0.22483205590444055,
          "win": 0,
          "team": "Bradley",
          "round": "First Round"
        },
        {
          "expected": 0.22406369732445364,
          "win": 0,
          "team": "Bradley",
          "round": "Second Round"
        },
        {
          "expected": 0.2042355791113637,
          "win": 0,
          "team": "Bradley",
          "round": "Sweet 16"
        },
        {
          "expected": 0.23351436299503564,
          "win": 0,
          "team": "Bradley",
          "round": "Elite Eight"
        },
        {
          "expected": 0.16211583777907143,
          "win": 0,
          "team": "Bradley",
          "round": "Final Four"
        },
        {
          "expected": 0.13059791371096538,
          "win": 0,
          "team": "Bradley",
          "round": "National Championship"
        },
        {
          "expected": 1.864306626057734,
          "win": 1,
          "team": "Gonzaga",
          "round": "First Round"
        },
        {
          "expected": 1.0748048989627803,
          "win": 1,
          "team": "Gonzaga",
          "round": "Second Round"
        },
        {
          "expected": 0.8979303827555432,
          "win": 1,
          "team": "Gonzaga",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7211346700178858,
          "win": 1,
          "team": "Gonzaga",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5823214127442182,
          "win": 0,
          "team": "Gonzaga",
          "round": "Final Four"
        },
        {
          "expected": 0.47266229190877135,
          "win": 0,
          "team": "Gonzaga",
          "round": "National Championship"
        },
        {
          "expected": 0.1356933739422661,
          "win": 0,
          "team": "F Dickinson",
          "round": "First Round"
        },
        {
          "expected": 0.1505878245272329,
          "win": 0,
          "team": "F Dickinson",
          "round": "Second Round"
        },
        {
          "expected": 0.13220969889035655,
          "win": 0,
          "team": "F Dickinson",
          "round": "Sweet 16"
        },
        {
          "expected": 0.11515171842473827,
          "win": 0,
          "team": "F Dickinson",
          "round": "Elite Eight"
        },
        {
          "expected": 0.10966946696694554,
          "win": 0,
          "team": "F Dickinson",
          "round": "Final Four"
        },
        {
          "expected": 0.0827067608072862,
          "win": 0,
          "team": "F Dickinson",
          "round": "National Championship"
        },
        {
          "expected": 1.2693678863303814,
          "win": 1,
          "team": "Syracuse",
          "round": "First Round"
        },
        {
          "expected": 0.8928863914435576,
          "win": 0,
          "team": "Syracuse",
          "round": "Second Round"
        },
        {
          "expected": 0.6342920135767547,
          "win": 0,
          "team": "Syracuse",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5121819088579819,
          "win": 0,
          "team": "Syracuse",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4162643526463184,
          "win": 0,
          "team": "Syracuse",
          "round": "Final Four"
        },
        {
          "expected": 0.34736884584906225,
          "win": 0,
          "team": "Syracuse",
          "round": "National Championship"
        },
        {
          "expected": 0.7306321136696186,
          "win": 0,
          "team": "Baylor",
          "round": "First Round"
        },
        {
          "expected": 0.8817208850664291,
          "win": 0,
          "team": "Baylor",
          "round": "Second Round"
        },
        {
          "expected": 0.6200993755574825,
          "win": 0,
          "team": "Baylor",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4708744438463117,
          "win": 0,
          "team": "Baylor",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4078454323978302,
          "win": 0,
          "team": "Baylor",
          "round": "Final Four"
        },
        {
          "expected": 0.3202486476490093,
          "win": 0,
          "team": "Baylor",
          "round": "National Championship"
        },
        {
          "expected": 1.3560435703504607,
          "win": 1,
          "team": "Marquette",
          "round": "First Round"
        },
        {
          "expected": 0.818568682554363,
          "win": 0,
          "team": "Marquette",
          "round": "Second Round"
        },
        {
          "expected": 0.7964254809988324,
          "win": 0,
          "team": "Marquette",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5390081381693649,
          "win": 0,
          "team": "Marquette",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4628196918027435,
          "win": 0,
          "team": "Marquette",
          "round": "Final Four"
        },
        {
          "expected": 0.38044038323372786,
          "win": 0,
          "team": "Marquette",
          "round": "National Championship"
        },
        {
          "expected": 0.6439564296495393,
          "win": 0,
          "team": "Murray St",
          "round": "First Round"
        },
        {
          "expected": 0.7433106634296848,
          "win": 0,
          "team": "Murray St",
          "round": "Second Round"
        },
        {
          "expected": 0.5865547604085365,
          "win": 0,
          "team": "Murray St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4589565160467921,
          "win": 0,
          "team": "Murray St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.386148916525257,
          "win": 0,
          "team": "Murray St",
          "round": "Final Four"
        },
        {
          "expected": 0.31245313502500144,
          "win": 0,
          "team": "Murray St",
          "round": "National Championship"
        },
        {
          "expected": 1.533588918240898,
          "win": 1,
          "team": "Florida St",
          "round": "First Round"
        },
        {
          "expected": 1.0176061409194816,
          "win": 1,
          "team": "Florida St",
          "round": "Second Round"
        },
        {
          "expected": 0.8222948465988565,
          "win": 0,
          "team": "Florida St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.626378534444001,
          "win": 0,
          "team": "Florida St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5199523347007795,
          "win": 0,
          "team": "Florida St",
          "round": "Final Four"
        },
        {
          "expected": 0.42175700987036335,
          "win": 0,
          "team": "Florida St",
          "round": "National Championship"
        },
        {
          "expected": 0.46641108175910206,
          "win": 0,
          "team": "Vermont",
          "round": "First Round"
        },
        {
          "expected": 0.4205145130964705,
          "win": 0,
          "team": "Vermont",
          "round": "Second Round"
        },
        {
          "expected": 0.5101934412136379,
          "win": 0,
          "team": "Vermont",
          "round": "Sweet 16"
        },
        {
          "expected": 0.36050035855050033,
          "win": 0,
          "team": "Vermont",
          "round": "Elite Eight"
        },
        {
          "expected": 0.308135754087331,
          "win": 0,
          "team": "Vermont",
          "round": "Final Four"
        },
        {
          "expected": 0.23870972110238067,
          "win": 0,
          "team": "Vermont",
          "round": "National Championship"
        },
        {
          "expected": 1.409662096600278,
          "win": 1,
          "team": "Buffalo",
          "round": "First Round"
        },
        {
          "expected": 0.8563152805696812,
          "win": 0,
          "team": "Buffalo",
          "round": "Second Round"
        },
        {
          "expected": 0.6913843272053699,
          "win": 0,
          "team": "Buffalo",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6328598788771466,
          "win": 0,
          "team": "Buffalo",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5136466418645451,
          "win": 0,
          "team": "Buffalo",
          "round": "Final Four"
        },
        {
          "expected": 0.40593969037831507,
          "win": 0,
          "team": "Buffalo",
          "round": "National Championship"
        },
        {
          "expected": 0.590337903399722,
          "win": 0,
          "team": "Arizona St",
          "round": "First Round"
        },
        {
          "expected": 0.7499006189936771,
          "win": 0,
          "team": "Arizona St",
          "round": "Second Round"
        },
        {
          "expected": 0.5225052025900566,
          "win": 0,
          "team": "Arizona St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.43594006597477597,
          "win": 0,
          "team": "Arizona St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.36559002826727194,
          "win": 0,
          "team": "Arizona St",
          "round": "Final Four"
        },
        {
          "expected": 0.29075418221662563,
          "win": 0,
          "team": "Arizona St",
          "round": "National Championship"
        },
        {
          "expected": 1.634921046236841,
          "win": 1,
          "team": "Texas Tech",
          "round": "First Round"
        },
        {
          "expected": 1.0397518661297718,
          "win": 1,
          "team": "Texas Tech",
          "round": "Second Round"
        },
        {
          "expected": 0.8019598907903226,
          "win": 0,
          "team": "Texas Tech",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6885717409070258,
          "win": 0,
          "team": "Texas Tech",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5589923624959321,
          "win": 0,
          "team": "Texas Tech",
          "round": "Final Four"
        },
        {
          "expected": 0.44818467472278717,
          "win": 0,
          "team": "Texas Tech",
          "round": "National Championship"
        },
        {
          "expected": 0.3650789537631589,
          "win": 0,
          "team": "N Kentucky",
          "round": "First Round"
        },
        {
          "expected": 0.35403223430687003,
          "win": 0,
          "team": "N Kentucky",
          "round": "Second Round"
        },
        {
          "expected": 0.395908018840144,
          "win": 0,
          "team": "N Kentucky",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3098332514248747,
          "win": 0,
          "team": "N Kentucky",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2618206987275654,
          "win": 0,
          "team": "N Kentucky",
          "round": "Final Four"
        },
        {
          "expected": 0.1969125687012608,
          "win": 0,
          "team": "N Kentucky",
          "round": "National Championship"
        },
        {
          "expected": 1.366728711165511,
          "win": 1,
          "team": "Nevada",
          "round": "First Round"
        },
        {
          "expected": 0.8782953033532526,
          "win": 0,
          "team": "Nevada",
          "round": "Second Round"
        },
        {
          "expected": 0.7777116988283522,
          "win": 0,
          "team": "Nevada",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6359879720279793,
          "win": 0,
          "team": "Nevada",
          "round": "Elite Eight"
        },
        {
          "expected": 0.51619332284741,
          "win": 0,
          "team": "Nevada",
          "round": "Final Four"
        },
        {
          "expected": 0.41333399466268606,
          "win": 0,
          "team": "Nevada",
          "round": "National Championship"
        },
        {
          "expected": 0.6332712888344889,
          "win": 0,
          "team": "Florida",
          "round": "First Round"
        },
        {
          "expected": 0.8075551466716189,
          "win": 0,
          "team": "Florida",
          "round": "Second Round"
        },
        {
          "expected": 0.6308204001256662,
          "win": 0,
          "team": "Florida",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5212211422975944,
          "win": 0,
          "team": "Florida",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4101036002321915,
          "win": 0,
          "team": "Florida",
          "round": "Final Four"
        },
        {
          "expected": 0.32712337327201335,
          "win": 0,
          "team": "Florida",
          "round": "National Championship"
        },
        {
          "expected": 1.6819522746293292,
          "win": 1,
          "team": "Michigan",
          "round": "First Round"
        },
        {
          "expected": 1.0209795151693537,
          "win": 1,
          "team": "Michigan",
          "round": "Second Round"
        },
        {
          "expected": 0.8874450115359045,
          "win": 1,
          "team": "Michigan",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6894548691500768,
          "win": 0,
          "team": "Michigan",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5597118586656118,
          "win": 0,
          "team": "Michigan",
          "round": "Final Four"
        },
        {
          "expected": 0.44877704379338257,
          "win": 0,
          "team": "Michigan",
          "round": "National Championship"
        },
        {
          "expected": 0.31804772537067083,
          "win": 0,
          "team": "Montana",
          "round": "First Round"
        },
        {
          "expected": 0.2931700348057749,
          "win": 0,
          "team": "Montana",
          "round": "Second Round"
        },
        {
          "expected": 0.29226545008418386,
          "win": 0,
          "team": "Montana",
          "round": "Sweet 16"
        },
        {
          "expected": 0.28194479098295055,
          "win": 0,
          "team": "Montana",
          "round": "Elite Eight"
        },
        {
          "expected": 0.22825943840207397,
          "win": 0,
          "team": "Montana",
          "round": "Final Four"
        },
        {
          "expected": 0.17796574535583284,
          "win": 0,
          "team": "Montana",
          "round": "National Championship"
        },
        {
          "expected": 1.7975468441885418,
          "win": 1,
          "team": "Virginia",
          "round": "First Round"
        },
        {
          "expected": 1.0721364322578437,
          "win": 1,
          "team": "Virginia",
          "round": "Second Round"
        },
        {
          "expected": 0.9001895258250202,
          "win": 1,
          "team": "Virginia",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7269039118577583,
          "win": 1,
          "team": "Virginia",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5968915198361358,
          "win": 1,
          "team": "Virginia",
          "round": "Final Four"
        },
        {
          "expected": 0.4813708040864944,
          "win": 1,
          "team": "Virginia",
          "round": "National Championship"
        },
        {
          "expected": 0.20245315581145817,
          "win": 0,
          "team": "Gardner Webb",
          "round": "First Round"
        },
        {
          "expected": 0.21873383710217442,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Second Round"
        },
        {
          "expected": 0.19377660456523121,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Sweet 16"
        },
        {
          "expected": 0.16943891971811212,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Elite Eight"
        },
        {
          "expected": 0.1595141534943231,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Final Four"
        },
        {
          "expected": 0.12848434707218184,
          "win": 0,
          "team": "Gardner Webb",
          "round": "National Championship"
        },
        {
          "expected": 0.717467121690303,
          "win": 0,
          "team": "Mississippi",
          "round": "First Round"
        },
        {
          "expected": 0.8451856969412378,
          "win": 0,
          "team": "Mississippi",
          "round": "Second Round"
        },
        {
          "expected": 0.6216839087087661,
          "win": 0,
          "team": "Mississippi",
          "round": "Sweet 16"
        },
        {
          "expected": 0.47652842939268325,
          "win": 0,
          "team": "Mississippi",
          "round": "Elite Eight"
        },
        {
          "expected": 0.40815201626796727,
          "win": 0,
          "team": "Mississippi",
          "round": "Final Four"
        },
        {
          "expected": 0.32876601766905744,
          "win": 0,
          "team": "Mississippi",
          "round": "National Championship"
        },
        {
          "expected": 1.282532878309697,
          "win": 1,
          "team": "Oklahoma",
          "round": "First Round"
        },
        {
          "expected": 0.8639440336987441,
          "win": 0,
          "team": "Oklahoma",
          "round": "Second Round"
        },
        {
          "expected": 0.6426449062440245,
          "win": 0,
          "team": "Oklahoma",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5233762139768423,
          "win": 0,
          "team": "Oklahoma",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4459447699145932,
          "win": 0,
          "team": "Oklahoma",
          "round": "Final Four"
        },
        {
          "expected": 0.34912571716080865,
          "win": 0,
          "team": "Oklahoma",
          "round": "National Championship"
        },
        {
          "expected": 1.4414531963095396,
          "win": 1,
          "team": "Wisconsin",
          "round": "First Round"
        },
        {
          "expected": 1.0414730844292373,
          "win": 1,
          "team": "Wisconsin",
          "round": "Second Round"
        },
        {
          "expected": 0.8032383857623316,
          "win": 0,
          "team": "Wisconsin",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6271792946642099,
          "win": 0,
          "team": "Wisconsin",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5166424311626129,
          "win": 0,
          "team": "Wisconsin",
          "round": "Final Four"
        },
        {
          "expected": 0.41653366164306044,
          "win": 0,
          "team": "Wisconsin",
          "round": "National Championship"
        },
        {
          "expected": 0.5585468036904604,
          "win": 0,
          "team": "Oregon",
          "round": "First Round"
        },
        {
          "expected": 0.705419168499581,
          "win": 0,
          "team": "Oregon",
          "round": "Second Round"
        },
        {
          "expected": 0.5411570896650781,
          "win": 0,
          "team": "Oregon",
          "round": "Sweet 16"
        },
        {
          "expected": 0.41101641531272,
          "win": 0,
          "team": "Oregon",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3434275338777791,
          "win": 0,
          "team": "Oregon",
          "round": "Final Four"
        },
        {
          "expected": 0.28135286773350654,
          "win": 0,
          "team": "Oregon",
          "round": "National Championship"
        },
        {
          "expected": 1.4930015627563138,
          "win": 1,
          "team": "Kansas St",
          "round": "First Round"
        },
        {
          "expected": 0.8085983264531544,
          "win": 0,
          "team": "Kansas St",
          "round": "Second Round"
        },
        {
          "expected": 0.7960173390725436,
          "win": 0,
          "team": "Kansas St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6209659927781227,
          "win": 0,
          "team": "Kansas St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4986189042999448,
          "win": 0,
          "team": "Kansas St",
          "round": "Final Four"
        },
        {
          "expected": 0.40197412811010413,
          "win": 0,
          "team": "Kansas St",
          "round": "National Championship"
        },
        {
          "expected": 0.5069984372436862,
          "win": 0,
          "team": "UC Irvine",
          "round": "First Round"
        },
        {
          "expected": 0.444509420618027,
          "win": 0,
          "team": "UC Irvine",
          "round": "Second Round"
        },
        {
          "expected": 0.5012922401570044,
          "win": 0,
          "team": "UC Irvine",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3768009922583144,
          "win": 0,
          "team": "UC Irvine",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3163078832833659,
          "win": 0,
          "team": "UC Irvine",
          "round": "Final Four"
        },
        {
          "expected": 0.25942480034155097,
          "win": 0,
          "team": "UC Irvine",
          "round": "National Championship"
        },
        {
          "expected": 1.370436531211971,
          "win": 1,
          "team": "Villanova",
          "round": "First Round"
        },
        {
          "expected": 0.8378926947231502,
          "win": 0,
          "team": "Villanova",
          "round": "Second Round"
        },
        {
          "expected": 0.7657474469943975,
          "win": 0,
          "team": "Villanova",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5822921584995016,
          "win": 0,
          "team": "Villanova",
          "round": "Elite Eight"
        },
        {
          "expected": 0.49008409370644584,
          "win": 0,
          "team": "Villanova",
          "round": "Final Four"
        },
        {
          "expected": 0.3793480088126046,
          "win": 0,
          "team": "Villanova",
          "round": "National Championship"
        },
        {
          "expected": 0.6295634687880289,
          "win": 0,
          "team": "St Mary's CA",
          "round": "First Round"
        },
        {
          "expected": 0.7562610709086991,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Second Round"
        },
        {
          "expected": 0.5404077185805779,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Sweet 16"
        },
        {
          "expected": 0.46431056393381287,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Elite Eight"
        },
        {
          "expected": 0.38199692705213173,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Final Four"
        },
        {
          "expected": 0.29779865350824763,
          "win": 0,
          "team": "St Mary's CA",
          "round": "National Championship"
        },
        {
          "expected": 1.6035044761557602,
          "win": 1,
          "team": "Purdue",
          "round": "First Round"
        },
        {
          "expected": 1.0320817863569551,
          "win": 1,
          "team": "Purdue",
          "round": "Second Round"
        },
        {
          "expected": 0.801000901311877,
          "win": 0,
          "team": "Purdue",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6752357605127367,
          "win": 0,
          "team": "Purdue",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5390438296767887,
          "win": 0,
          "team": "Purdue",
          "round": "Final Four"
        },
        {
          "expected": 0.4399950777936904,
          "win": 0,
          "team": "Purdue",
          "round": "National Championship"
        },
        {
          "expected": 0.3964955238442398,
          "win": 0,
          "team": "Old Dominion",
          "round": "First Round"
        },
        {
          "expected": 0.37376444801119546,
          "win": 0,
          "team": "Old Dominion",
          "round": "Second Round"
        },
        {
          "expected": 0.42069196908907636,
          "win": 0,
          "team": "Old Dominion",
          "round": "Sweet 16"
        },
        {
          "expected": 0.310579077311683,
          "win": 0,
          "team": "Old Dominion",
          "round": "Elite Eight"
        },
        {
          "expected": 0.26919632234548463,
          "win": 0,
          "team": "Old Dominion",
          "round": "Final Four"
        },
        {
          "expected": 0.21681092400588994,
          "win": 0,
          "team": "Old Dominion",
          "round": "National Championship"
        },
        {
          "expected": 1.3087156738665018,
          "win": 1,
          "team": "Cincinnati",
          "round": "First Round"
        },
        {
          "expected": 0.855097999385072,
          "win": 0,
          "team": "Cincinnati",
          "round": "Second Round"
        },
        {
          "expected": 0.6704984092472909,
          "win": 0,
          "team": "Cincinnati",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5750944730332219,
          "win": 0,
          "team": "Cincinnati",
          "round": "Elite Eight"
        },
        {
          "expected": 0.45850711484256934,
          "win": 0,
          "team": "Cincinnati",
          "round": "Final Four"
        },
        {
          "expected": 0.36950745066335583,
          "win": 0,
          "team": "Cincinnati",
          "round": "National Championship"
        },
        {
          "expected": 0.6912843261334982,
          "win": 0,
          "team": "Iowa",
          "round": "First Round"
        },
        {
          "expected": 0.8200660384728311,
          "win": 0,
          "team": "Iowa",
          "round": "Second Round"
        },
        {
          "expected": 0.6363751482181712,
          "win": 0,
          "team": "Iowa",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5172206491702056,
          "win": 0,
          "team": "Iowa",
          "round": "Elite Eight"
        },
        {
          "expected": 0.42463494253620315,
          "win": 0,
          "team": "Iowa",
          "round": "Final Four"
        },
        {
          "expected": 0.3370280346459285,
          "win": 0,
          "team": "Iowa",
          "round": "National Championship"
        },
        {
          "expected": 1.7046948031923423,
          "win": 1,
          "team": "Tennessee",
          "round": "First Round"
        },
        {
          "expected": 1.0392176369237962,
          "win": 1,
          "team": "Tennessee",
          "round": "Second Round"
        },
        {
          "expected": 0.8918171436509006,
          "win": 1,
          "team": "Tennessee",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6858551064785142,
          "win": 0,
          "team": "Tennessee",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5744162978761407,
          "win": 0,
          "team": "Tennessee",
          "round": "Final Four"
        },
        {
          "expected": 0.45773871353911066,
          "win": 0,
          "team": "Tennessee",
          "round": "National Championship"
        },
        {
          "expected": 0.29530519680765766,
          "win": 0,
          "team": "Colgate",
          "round": "First Round"
        },
        {
          "expected": 0.28561832521830066,
          "win": 0,
          "team": "Colgate",
          "round": "Second Round"
        },
        {
          "expected": 0.27346126290770867,
          "win": 0,
          "team": "Colgate",
          "round": "Sweet 16"
        },
        {
          "expected": 0.2572020411015611,
          "win": 0,
          "team": "Colgate",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2152393268883297,
          "win": 0,
          "team": "Colgate",
          "round": "Final Four"
        },
        {
          "expected": 0.16940262301522754,
          "win": 0,
          "team": "Colgate",
          "round": "National Championship"
        },
        {
          "expected": 1.8623037329981895,
          "win": 1,
          "team": "North Carolina",
          "round": "First Round"
        },
        {
          "expected": 1.0681206711564384,
          "win": 1,
          "team": "North Carolina",
          "round": "Second Round"
        },
        {
          "expected": 0.8918577868365163,
          "win": 1,
          "team": "North Carolina",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7276880157963207,
          "win": 1,
          "team": "North Carolina",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5737684782543425,
          "win": 0,
          "team": "North Carolina",
          "round": "Final Four"
        },
        {
          "expected": 0.46670326501472903,
          "win": 0,
          "team": "North Carolina",
          "round": "National Championship"
        },
        {
          "expected": 0.13769626700181048,
          "win": 0,
          "team": "Iona",
          "round": "First Round"
        },
        {
          "expected": 0.149569164284528,
          "win": 0,
          "team": "Iona",
          "round": "Second Round"
        },
        {
          "expected": 0.13307005287999826,
          "win": 0,
          "team": "Iona",
          "round": "Sweet 16"
        },
        {
          "expected": 0.1234576931746014,
          "win": 0,
          "team": "Iona",
          "round": "Elite Eight"
        },
        {
          "expected": 0.097875816388864,
          "win": 0,
          "team": "Iona",
          "round": "Final Four"
        },
        {
          "expected": 0.0891863329889937,
          "win": 0,
          "team": "Iona",
          "round": "National Championship"
        },
        {
          "expected": 0.7464869520055273,
          "win": 0,
          "team": "Utah St",
          "round": "First Round"
        },
        {
          "expected": 0.8893342961097241,
          "win": 0,
          "team": "Utah St",
          "round": "Second Round"
        },
        {
          "expected": 0.6246822110299006,
          "win": 0,
          "team": "Utah St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5179614424911825,
          "win": 0,
          "team": "Utah St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.40381525703750215,
          "win": 0,
          "team": "Utah St",
          "round": "Final Four"
        },
        {
          "expected": 0.3354899241268493,
          "win": 0,
          "team": "Utah St",
          "round": "National Championship"
        },
        {
          "expected": 1.2535130479944727,
          "win": 1,
          "team": "Washington",
          "round": "First Round"
        },
        {
          "expected": 0.8929758684493095,
          "win": 0,
          "team": "Washington",
          "round": "Second Round"
        },
        {
          "expected": 0.6292145629792506,
          "win": 0,
          "team": "Washington",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5214383241321359,
          "win": 0,
          "team": "Washington",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4191384776675434,
          "win": 0,
          "team": "Washington",
          "round": "Final Four"
        },
        {
          "expected": 0.3377324132604633,
          "win": 0,
          "team": "Washington",
          "round": "National Championship"
        },
        {
          "expected": 1.4031118847255273,
          "win": 1,
          "team": "Auburn",
          "round": "First Round"
        },
        {
          "expected": 0.8487246039387648,
          "win": 0,
          "team": "Auburn",
          "round": "Second Round"
        },
        {
          "expected": 0.8161965643033537,
          "win": 0,
          "team": "Auburn",
          "round": "Sweet 16"
        },
        {
          "expected": 0.631026859664764,
          "win": 0,
          "team": "Auburn",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5085699172324598,
          "win": 0,
          "team": "Auburn",
          "round": "Final Four"
        },
        {
          "expected": 0.40911850839765196,
          "win": 0,
          "team": "Auburn",
          "round": "National Championship"
        },
        {
          "expected": 0.5968881152744727,
          "win": 0,
          "team": "New Mexico St",
          "round": "First Round"
        },
        {
          "expected": 0.7421811962418536,
          "win": 0,
          "team": "New Mexico St",
          "round": "Second Round"
        },
        {
          "expected": 0.5811670633358001,
          "win": 0,
          "team": "New Mexico St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4660688185545981,
          "win": 0,
          "team": "New Mexico St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3615778505745718,
          "win": 0,
          "team": "New Mexico St",
          "round": "Final Four"
        },
        {
          "expected": 0.2967243858907433,
          "win": 0,
          "team": "New Mexico St",
          "round": "National Championship"
        },
        {
          "expected": 1.5590094848935803,
          "win": 1,
          "team": "Kansas",
          "round": "First Round"
        },
        {
          "expected": 1.0132109658076642,
          "win": 1,
          "team": "Kansas",
          "round": "Second Round"
        },
        {
          "expected": 0.8262039356771217,
          "win": 0,
          "team": "Kansas",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6398550435256852,
          "win": 0,
          "team": "Kansas",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5290571319476562,
          "win": 0,
          "team": "Kansas",
          "round": "Final Four"
        },
        {
          "expected": 0.4362302187946985,
          "win": 0,
          "team": "Kansas",
          "round": "National Championship"
        },
        {
          "expected": 0.44099051510641973,
          "win": 0,
          "team": "Northeastern",
          "round": "First Round"
        },
        {
          "expected": 0.39588323401171743,
          "win": 0,
          "team": "Northeastern",
          "round": "Second Round"
        },
        {
          "expected": 0.4976078229580587,
          "win": 0,
          "team": "Northeastern",
          "round": "Sweet 16"
        },
        {
          "expected": 0.36122377122836885,
          "win": 0,
          "team": "Northeastern",
          "round": "Elite Eight"
        },
        {
          "expected": 0.27721006832967554,
          "win": 0,
          "team": "Northeastern",
          "round": "Final Four"
        },
        {
          "expected": 0.22993164776401231,
          "win": 0,
          "team": "Northeastern",
          "round": "National Championship"
        },
        {
          "expected": 1.3533681637746269,
          "win": 1,
          "team": "Iowa St",
          "round": "First Round"
        },
        {
          "expected": 0.8373588874723221,
          "win": 0,
          "team": "Iowa St",
          "round": "Second Round"
        },
        {
          "expected": 0.6944565120148949,
          "win": 0,
          "team": "Iowa St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5837295108088189,
          "win": 0,
          "team": "Iowa St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4670719125912712,
          "win": 0,
          "team": "Iowa St",
          "round": "Final Four"
        },
        {
          "expected": 0.3707131161376707,
          "win": 0,
          "team": "Iowa St",
          "round": "National Championship"
        },
        {
          "expected": 0.6466318362253731,
          "win": 0,
          "team": "Ohio St",
          "round": "First Round"
        },
        {
          "expected": 0.7685081059466659,
          "win": 0,
          "team": "Ohio St",
          "round": "Second Round"
        },
        {
          "expected": 0.6359525099016639,
          "win": 0,
          "team": "Ohio St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.47508420679732,
          "win": 0,
          "team": "Ohio St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3772375030757796,
          "win": 0,
          "team": "Ohio St",
          "round": "Final Four"
        },
        {
          "expected": 0.30438707612740645,
          "win": 0,
          "team": "Ohio St",
          "round": "National Championship"
        },
        {
          "expected": 1.6273113030342272,
          "win": 1,
          "team": "Houston",
          "round": "First Round"
        },
        {
          "expected": 1.0373463470836992,
          "win": 1,
          "team": "Houston",
          "round": "Second Round"
        },
        {
          "expected": 0.8168960560724445,
          "win": 0,
          "team": "Houston",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6831427034646655,
          "win": 0,
          "team": "Houston",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5486681334081042,
          "win": 0,
          "team": "Houston",
          "round": "Final Four"
        },
        {
          "expected": 0.44120453767629736,
          "win": 0,
          "team": "Houston",
          "round": "National Championship"
        },
        {
          "expected": 0.3726886969657728,
          "win": 0,
          "team": "Georgia St",
          "round": "First Round"
        },
        {
          "expected": 0.356786659497313,
          "win": 0,
          "team": "Georgia St",
          "round": "Second Round"
        },
        {
          "expected": 0.4233455252906368,
          "win": 0,
          "team": "Georgia St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.31010583820624554,
          "win": 0,
          "team": "Georgia St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.23973839388663898,
          "win": 0,
          "team": "Georgia St",
          "round": "Final Four"
        },
        {
          "expected": 0.2086203561934838,
          "win": 0,
          "team": "Georgia St",
          "round": "National Championship"
        },
        {
          "expected": 1.385827142855928,
          "win": 1,
          "team": "Wofford",
          "round": "First Round"
        },
        {
          "expected": 0.8786911384230722,
          "win": 0,
          "team": "Wofford",
          "round": "Second Round"
        },
        {
          "expected": 0.7613319242378075,
          "win": 0,
          "team": "Wofford",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5875278680382295,
          "win": 0,
          "team": "Wofford",
          "round": "Elite Eight"
        },
        {
          "expected": 0.47027092531993686,
          "win": 0,
          "team": "Wofford",
          "round": "Final Four"
        },
        {
          "expected": 0.3784338753164888,
          "win": 0,
          "team": "Wofford",
          "round": "National Championship"
        },
        {
          "expected": 0.6141728571440721,
          "win": 0,
          "team": "Seton Hall",
          "round": "First Round"
        },
        {
          "expected": 0.7966247964019956,
          "win": 0,
          "team": "Seton Hall",
          "round": "Second Round"
        },
        {
          "expected": 0.5248928079818848,
          "win": 0,
          "team": "Seton Hall",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4337442748862783,
          "win": 0,
          "team": "Seton Hall",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3553922140433035,
          "win": 0,
          "team": "Seton Hall",
          "round": "Final Four"
        },
        {
          "expected": 0.2869895046814202,
          "win": 0,
          "team": "Seton Hall",
          "round": "National Championship"
        },
        {
          "expected": 1.738615741282133,
          "win": 1,
          "team": "Kentucky",
          "round": "First Round"
        },
        {
          "expected": 1.055339867813387,
          "win": 1,
          "team": "Kentucky",
          "round": "Second Round"
        },
        {
          "expected": 0.8939595645800389,
          "win": 1,
          "team": "Kentucky",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6907235417779272,
          "win": 0,
          "team": "Kentucky",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5550188657335497,
          "win": 0,
          "team": "Kentucky",
          "round": "Final Four"
        },
        {
          "expected": 0.4570852505872814,
          "win": 0,
          "team": "Kentucky",
          "round": "National Championship"
        },
        {
          "expected": 0.26138425871786697,
          "win": 0,
          "team": "Abilene Chr",
          "round": "First Round"
        },
        {
          "expected": 0.26934419736154525,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Second Round"
        },
        {
          "expected": 0.24916509992062877,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Sweet 16"
        },
        {
          "expected": 0.24722208745285845,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Elite Eight"
        },
        {
          "expected": 0.17697098744798478,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Final Four"
        },
        {
          "expected": 0.1538801806517147,
          "win": 0,
          "team": "Abilene Chr",
          "round": "National Championship"
        }
      ]
    },
    {
      "name": "data_1",
      "source": "source_0",
      "transform": [
        {"type": "formula", "expr": "toNumber(datum[\"win\"])", "as": "win"},
        {
          "type": "formula",
          "expr": "datum[\"round\"]===\"First Round\" ? 0 : datum[\"round\"]===\"Second Round\" ? 1 : datum[\"round\"]===\"Sweet 16\" ? 2 : datum[\"round\"]===\"Elite Eight\" ? 3 : datum[\"round\"]===\"Final Four\" ? 4 : datum[\"round\"]===\"National Championship\" ? 5 : 6",
          "as": "x_round_sort_index"
        },
        {
          "type": "formula",
          "expr": "datum[\"team\"]===\"Duke\" ? 0 : datum[\"team\"]===\"N Dakota St\" ? 1 : datum[\"team\"]===\"VA Commonwealth\" ? 2 : datum[\"team\"]===\"UCF\" ? 3 : datum[\"team\"]===\"Mississippi St\" ? 4 : datum[\"team\"]===\"Liberty\" ? 5 : datum[\"team\"]===\"Virginia Tech\" ? 6 : datum[\"team\"]===\"St Louis\" ? 7 : datum[\"team\"]===\"Maryland\" ? 8 : datum[\"team\"]===\"Belmont\" ? 9 : datum[\"team\"]===\"LSU\" ? 10 : datum[\"team\"]===\"Yale\" ? 11 : datum[\"team\"]===\"Louisville\" ? 12 : datum[\"team\"]===\"Minnesota\" ? 13 : datum[\"team\"]===\"Michigan St\" ? 14 : datum[\"team\"]===\"Bradley\" ? 15 : datum[\"team\"]===\"Gonzaga\" ? 16 : datum[\"team\"]===\"F Dickinson\" ? 17 : datum[\"team\"]===\"Syracuse\" ? 18 : datum[\"team\"]===\"Baylor\" ? 19 : datum[\"team\"]===\"Marquette\" ? 20 : datum[\"team\"]===\"Murray St\" ? 21 : datum[\"team\"]===\"Florida St\" ? 22 : datum[\"team\"]===\"Vermont\" ? 23 : datum[\"team\"]===\"Buffalo\" ? 24 : datum[\"team\"]===\"Arizona St\" ? 25 : datum[\"team\"]===\"Texas Tech\" ? 26 : datum[\"team\"]===\"N Kentucky\" ? 27 : datum[\"team\"]===\"Nevada\" ? 28 : datum[\"team\"]===\"Florida\" ? 29 : datum[\"team\"]===\"Michigan\" ? 30 : datum[\"team\"]===\"Montana\" ? 31 : datum[\"team\"]===\"Virginia\" ? 32 : datum[\"team\"]===\"Gardner Webb\" ? 33 : datum[\"team\"]===\"Mississippi\" ? 34 : datum[\"team\"]===\"Oklahoma\" ? 35 : datum[\"team\"]===\"Wisconsin\" ? 36 : datum[\"team\"]===\"Oregon\" ? 37 : datum[\"team\"]===\"Kansas St\" ? 38 : datum[\"team\"]===\"UC Irvine\" ? 39 : datum[\"team\"]===\"Villanova\" ? 40 : datum[\"team\"]===\"St Mary's CA\" ? 41 : datum[\"team\"]===\"Purdue\" ? 42 : datum[\"team\"]===\"Old Dominion\" ? 43 : datum[\"team\"]===\"Cincinnati\" ? 44 : datum[\"team\"]===\"Iowa\" ? 45 : datum[\"team\"]===\"Tennessee\" ? 46 : datum[\"team\"]===\"Colgate\" ? 47 : datum[\"team\"]===\"North Carolina\" ? 48 : datum[\"team\"]===\"Iona\" ? 49 : datum[\"team\"]===\"Utah St\" ? 50 : datum[\"team\"]===\"Washington\" ? 51 : datum[\"team\"]===\"Auburn\" ? 52 : datum[\"team\"]===\"New Mexico St\" ? 53 : datum[\"team\"]===\"Kansas\" ? 54 : datum[\"team\"]===\"Northeastern\" ? 55 : datum[\"team\"]===\"Iowa St\" ? 56 : datum[\"team\"]===\"Ohio St\" ? 57 : datum[\"team\"]===\"Houston\" ? 58 : datum[\"team\"]===\"Georgia St\" ? 59 : datum[\"team\"]===\"Wofford\" ? 60 : datum[\"team\"]===\"Seton Hall\" ? 61 : datum[\"team\"]===\"Kentucky\" ? 62 : datum[\"team\"]===\"Abilene Chr\" ? 63 : 64",
          "as": "y_team_sort_index"
        }
      ]
    },
    {
      "name": "data_2",
      "source": "data_1",
      "transform": [
        {
          "type": "filter",
          "expr": "datum[\"win\"] !== null && !isNaN(datum[\"win\"])"
        }
      ]
    },
    {
      "name": "data_3",
      "source": "source_0",
      "transform": [
        {
          "type": "formula",
          "expr": "toNumber(datum[\"expected\"])",
          "as": "expected"
        },
        {
          "type": "formula",
          "expr": "datum[\"round\"]===\"First Round\" ? 0 : datum[\"round\"]===\"Second Round\" ? 1 : datum[\"round\"]===\"Sweet 16\" ? 2 : datum[\"round\"]===\"Elite Eight\" ? 3 : datum[\"round\"]===\"Final Four\" ? 4 : datum[\"round\"]===\"National Championship\" ? 5 : 6",
          "as": "x_round_sort_index"
        },
        {
          "type": "formula",
          "expr": "datum[\"team\"]===\"Duke\" ? 0 : datum[\"team\"]===\"N Dakota St\" ? 1 : datum[\"team\"]===\"VA Commonwealth\" ? 2 : datum[\"team\"]===\"UCF\" ? 3 : datum[\"team\"]===\"Mississippi St\" ? 4 : datum[\"team\"]===\"Liberty\" ? 5 : datum[\"team\"]===\"Virginia Tech\" ? 6 : datum[\"team\"]===\"St Louis\" ? 7 : datum[\"team\"]===\"Maryland\" ? 8 : datum[\"team\"]===\"Belmont\" ? 9 : datum[\"team\"]===\"LSU\" ? 10 : datum[\"team\"]===\"Yale\" ? 11 : datum[\"team\"]===\"Louisville\" ? 12 : datum[\"team\"]===\"Minnesota\" ? 13 : datum[\"team\"]===\"Michigan St\" ? 14 : datum[\"team\"]===\"Bradley\" ? 15 : datum[\"team\"]===\"Gonzaga\" ? 16 : datum[\"team\"]===\"F Dickinson\" ? 17 : datum[\"team\"]===\"Syracuse\" ? 18 : datum[\"team\"]===\"Baylor\" ? 19 : datum[\"team\"]===\"Marquette\" ? 20 : datum[\"team\"]===\"Murray St\" ? 21 : datum[\"team\"]===\"Florida St\" ? 22 : datum[\"team\"]===\"Vermont\" ? 23 : datum[\"team\"]===\"Buffalo\" ? 24 : datum[\"team\"]===\"Arizona St\" ? 25 : datum[\"team\"]===\"Texas Tech\" ? 26 : datum[\"team\"]===\"N Kentucky\" ? 27 : datum[\"team\"]===\"Nevada\" ? 28 : datum[\"team\"]===\"Florida\" ? 29 : datum[\"team\"]===\"Michigan\" ? 30 : datum[\"team\"]===\"Montana\" ? 31 : datum[\"team\"]===\"Virginia\" ? 32 : datum[\"team\"]===\"Gardner Webb\" ? 33 : datum[\"team\"]===\"Mississippi\" ? 34 : datum[\"team\"]===\"Oklahoma\" ? 35 : datum[\"team\"]===\"Wisconsin\" ? 36 : datum[\"team\"]===\"Oregon\" ? 37 : datum[\"team\"]===\"Kansas St\" ? 38 : datum[\"team\"]===\"UC Irvine\" ? 39 : datum[\"team\"]===\"Villanova\" ? 40 : datum[\"team\"]===\"St Mary's CA\" ? 41 : datum[\"team\"]===\"Purdue\" ? 42 : datum[\"team\"]===\"Old Dominion\" ? 43 : datum[\"team\"]===\"Cincinnati\" ? 44 : datum[\"team\"]===\"Iowa\" ? 45 : datum[\"team\"]===\"Tennessee\" ? 46 : datum[\"team\"]===\"Colgate\" ? 47 : datum[\"team\"]===\"North Carolina\" ? 48 : datum[\"team\"]===\"Iona\" ? 49 : datum[\"team\"]===\"Utah St\" ? 50 : datum[\"team\"]===\"Washington\" ? 51 : datum[\"team\"]===\"Auburn\" ? 52 : datum[\"team\"]===\"New Mexico St\" ? 53 : datum[\"team\"]===\"Kansas\" ? 54 : datum[\"team\"]===\"Northeastern\" ? 55 : datum[\"team\"]===\"Iowa St\" ? 56 : datum[\"team\"]===\"Ohio St\" ? 57 : datum[\"team\"]===\"Houston\" ? 58 : datum[\"team\"]===\"Georgia St\" ? 59 : datum[\"team\"]===\"Wofford\" ? 60 : datum[\"team\"]===\"Seton Hall\" ? 61 : datum[\"team\"]===\"Kentucky\" ? 62 : datum[\"team\"]===\"Abilene Chr\" ? 63 : 64",
          "as": "y_team_sort_index"
        }
      ]
    },
    {
      "name": "data_4",
      "source": "data_3",
      "transform": [
        {
          "type": "filter",
          "expr": "datum[\"expected\"] !== null && !isNaN(datum[\"expected\"])"
        }
      ]
    }
  ],
  "signals": [
    {"name": "child_win_x_step", "value": 21},
    {
      "name": "child_win_width",
      "update": "bandspace(domain('child_win_x').length, 0.1, 0.05) * child_win_x_step"
    },
    {"name": "child_win_y_step", "value": 21},
    {
      "name": "child_win_height",
      "update": "bandspace(domain('child_win_y').length, 0.1, 0.05) * child_win_y_step"
    },
    {"name": "child_expected_x_step", "value": 21},
    {
      "name": "child_expected_width",
      "update": "bandspace(domain('child_expected_x').length, 0.1, 0.05) * child_expected_x_step"
    },
    {"name": "child_expected_y_step", "value": 21},
    {
      "name": "child_expected_height",
      "update": "bandspace(domain('child_expected_y').length, 0.1, 0.05) * child_expected_y_step"
    }
  ],
  "layout": {
    "padding": {"row": 10, "column": 10},
    "columns": 2,
    "bounds": "full",
    "align": "all"
  },
  "marks": [
    {
      "type": "group",
      "name": "child_win_group",
      "style": "cell",
      "encode": {
        "update": {
          "width": {"signal": "child_win_width"},
          "height": {"signal": "child_win_height"}
        }
      },
      "marks": [
        {
          "name": "child_win_marks",
          "type": "rect",
          "style": ["rect"],
          "from": {"data": "data_2"},
          "encode": {
            "update": {
              "fill": {"scale": "color", "field": "win"},
              "x": {"scale": "child_win_x", "field": "round"},
              "width": {"scale": "child_win_x", "band": true},
              "y": {"scale": "child_win_y", "field": "team"},
              "height": {"scale": "child_win_y", "band": true}
            }
          }
        }
      ],
      "axes": [
        {
          "scale": "child_win_x",
          "orient": "bottom",
          "grid": false,
          "title": "round",
          "encode": {
            "labels": {
              "update": {
                "angle": {"value": 270},
                "align": {"value": "right"},
                "baseline": {"value": "middle"}
              }
            }
          },
          "zindex": 1
        },
        {
          "scale": "child_win_y",
          "orient": "left",
          "grid": false,
          "title": "team",
          "zindex": 1
        }
      ]
    },
    {
      "type": "group",
      "name": "child_expected_group",
      "style": "cell",
      "encode": {
        "update": {
          "width": {"signal": "child_expected_width"},
          "height": {"signal": "child_expected_height"}
        }
      },
      "marks": [
        {
          "name": "child_expected_marks",
          "type": "rect",
          "style": ["rect"],
          "from": {"data": "data_4"},
          "encode": {
            "update": {
              "fill": {"scale": "color", "field": "expected"},
              "x": {"scale": "child_expected_x", "field": "round"},
              "width": {"scale": "child_expected_x", "band": true},
              "y": {"scale": "child_expected_y", "field": "team"},
              "height": {"scale": "child_expected_y", "band": true}
            }
          }
        }
      ],
      "axes": [
        {
          "scale": "child_expected_x",
          "orient": "bottom",
          "grid": false,
          "title": "round",
          "encode": {
            "labels": {
              "update": {
                "angle": {"value": 270},
                "align": {"value": "right"},
                "baseline": {"value": "middle"}
              }
            }
          },
          "zindex": 1
        },
        {
          "scale": "child_expected_y",
          "orient": "left",
          "grid": false,
          "title": "team",
          "zindex": 1
        }
      ]
    }
  ],
  "scales": [
    {
      "name": "color",
      "type": "sequential",
      "domain": {
        "fields": [
          {"data": "data_2", "field": "win"},
          {"data": "data_4", "field": "expected"}
        ]
      },
      "range": "heatmap",
      "nice": false,
      "zero": false
    },
    {
      "name": "child_win_x",
      "type": "band",
      "domain": {
        "data": "data_1",
        "field": "round",
        "sort": {"op": "min", "field": "x_round_sort_index"}
      },
      "range": {"step": {"signal": "child_win_x_step"}},
      "paddingInner": 0.1,
      "paddingOuter": 0.05
    },
    {
      "name": "child_win_y",
      "type": "band",
      "domain": {
        "data": "data_1",
        "field": "team",
        "sort": {"op": "min", "field": "y_team_sort_index"}
      },
      "range": {"step": {"signal": "child_win_y_step"}},
      "paddingInner": 0.1,
      "paddingOuter": 0.05
    },
    {
      "name": "child_expected_x",
      "type": "band",
      "domain": {
        "data": "data_3",
        "field": "round",
        "sort": {"op": "min", "field": "x_round_sort_index"}
      },
      "range": {"step": {"signal": "child_expected_x_step"}},
      "paddingInner": 0.1,
      "paddingOuter": 0.05
    },
    {
      "name": "child_expected_y",
      "type": "band",
      "domain": {
        "data": "data_3",
        "field": "team",
        "sort": {"op": "min", "field": "y_team_sort_index"}
      },
      "range": {"step": {"signal": "child_expected_y_step"}},
      "paddingInner": 0.1,
      "paddingOuter": 0.05
    }
  ],
  "legends": [
    {"title": "Expected Bracket Points", "fill": "color", "type": "gradient"}
  ],
  "config": {"axisY": {"minExtent": 30}}
};
// Embed the visualization in the container with id `vis`
vegaEmbed("#vis", vlSpec,
          {"actions": false, "hover": false});
</script>
