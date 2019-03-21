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
          "probs": 0.9297403967908628,
          "win": 1,
          "team": "Duke",
          "round": "First Round"
        },
        {
          "expected": 1.049633956916049,
          "probs": 0.349877985638683,
          "win": 1,
          "team": "Duke",
          "round": "Second Round"
        },
        {
          "expected": 0.9287252110209678,
          "probs": 0.18574504220419358,
          "win": 1,
          "team": "Duke",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7267104489112778,
          "probs": 0.09083880611390972,
          "win": 1,
          "team": "Duke",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5918836992806563,
          "probs": 0.045529515329281255,
          "win": 1,
          "team": "Duke",
          "round": "Final Four"
        },
        {
          "expected": 0.4732293754472537,
          "probs": 0.022534732164154938,
          "win": 0,
          "team": "Duke",
          "round": "National Championship"
        },
        {
          "expected": 0.1405192064182743,
          "probs": 0.07025960320913716,
          "win": 0,
          "team": "N Dakota St",
          "round": "First Round"
        },
        {
          "expected": 0.143272573273227,
          "probs": 0.047757524424409004,
          "win": 0,
          "team": "N Dakota St",
          "round": "Second Round"
        },
        {
          "expected": 0.16544106289170213,
          "probs": 0.03308821257834042,
          "win": 0,
          "team": "N Dakota St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.12673790628014614,
          "probs": 0.015842238285018267,
          "win": 0,
          "team": "N Dakota St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.11450459528945225,
          "probs": 0.008808045791496327,
          "win": 0,
          "team": "N Dakota St",
          "round": "Final Four"
        },
        {
          "expected": 0.08851248817420641,
          "probs": 0.0042148803892479245,
          "win": 0,
          "team": "N Dakota St",
          "round": "National Championship"
        },
        {
          "expected": 0.7496307127708404,
          "probs": 0.3748153563854202,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "First Round"
        },
        {
          "expected": 0.9035354672728934,
          "probs": 0.30117848909096445,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Second Round"
        },
        {
          "expected": 0.6873843669121311,
          "probs": 0.13747687338242623,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5314659739734096,
          "probs": 0.0664332467466762,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4464674821907956,
          "probs": 0.03434365247621504,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Final Four"
        },
        {
          "expected": 0.3613493540325653,
          "probs": 0.017207112096788824,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "National Championship"
        },
        {
          "expected": 1.2503692872291596,
          "probs": 0.6251846436145798,
          "win": 1,
          "team": "UCF",
          "round": "First Round"
        },
        {
          "expected": 0.9035580025378307,
          "probs": 0.30118600084594355,
          "win": 0,
          "team": "UCF",
          "round": "Second Round"
        },
        {
          "expected": 0.6874106145116321,
          "probs": 0.13748212290232642,
          "win": 0,
          "team": "UCF",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5314874062240297,
          "probs": 0.06643592577800371,
          "win": 0,
          "team": "UCF",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4464848917508311,
          "probs": 0.034344991673140854,
          "win": 0,
          "team": "UCF",
          "round": "Final Four"
        },
        {
          "expected": 0.36136346333599956,
          "probs": 0.017207783968380932,
          "win": 0,
          "team": "UCF",
          "round": "National Championship"
        },
        {
          "expected": 1.491838411213134,
          "probs": 0.745919205606567,
          "win": 1,
          "team": "Mississippi St",
          "round": "First Round"
        },
        {
          "expected": 0.8684195529302292,
          "probs": 0.2894731843100764,
          "win": 0,
          "team": "Mississippi St",
          "round": "Second Round"
        },
        {
          "expected": 0.7903207310649042,
          "probs": 0.15806414621298084,
          "win": 0,
          "team": "Mississippi St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5829191478735175,
          "probs": 0.07286489348418969,
          "win": 0,
          "team": "Mississippi St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4752288572766788,
          "probs": 0.03655606594435991,
          "win": 0,
          "team": "Mississippi St",
          "round": "Final Four"
        },
        {
          "expected": 0.39507661614906575,
          "probs": 0.01881317219757456,
          "win": 0,
          "team": "Mississippi St",
          "round": "National Championship"
        },
        {
          "expected": 0.508161588786866,
          "probs": 0.254080794393433,
          "win": 0,
          "team": "Liberty",
          "round": "First Round"
        },
        {
          "expected": 0.6963195614058049,
          "probs": 0.23210652046860164,
          "win": 0,
          "team": "Liberty",
          "round": "Second Round"
        },
        {
          "expected": 0.5025456896955975,
          "probs": 0.1005091379391195,
          "win": 0,
          "team": "Liberty",
          "round": "Sweet 16"
        },
        {
          "expected": 0.37259959624937206,
          "probs": 0.04657494953117151,
          "win": 0,
          "team": "Liberty",
          "round": "Elite Eight"
        },
        {
          "expected": 0.30539990297392505,
          "probs": 0.023492300228763467,
          "win": 0,
          "team": "Liberty",
          "round": "Final Four"
        },
        {
          "expected": 0.24254827696907172,
          "probs": 0.011549917950908177,
          "win": 0,
          "team": "Liberty",
          "round": "National Championship"
        },
        {
          "expected": 1.6437068454137127,
          "probs": 0.8218534227068564,
          "win": 1,
          "team": "Virginia Tech",
          "round": "First Round"
        },
        {
          "expected": 1.0598358473088685,
          "probs": 0.35327861576962283,
          "win": 1,
          "team": "Virginia Tech",
          "round": "Second Round"
        },
        {
          "expected": 0.8116423468072189,
          "probs": 0.1623284693614438,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6336485112472897,
          "probs": 0.07920606390591121,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5295934902581486,
          "probs": 0.040737960789088354,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Final Four"
        },
        {
          "expected": 0.4230978400463663,
          "probs": 0.02014751619268411,
          "win": 0,
          "team": "Virginia Tech",
          "round": "National Championship"
        },
        {
          "expected": 0.3562931545862873,
          "probs": 0.17814657729314365,
          "win": 0,
          "team": "St Louis",
          "round": "First Round"
        },
        {
          "expected": 0.3754250383550972,
          "probs": 0.12514167945169907,
          "win": 0,
          "team": "St Louis",
          "round": "Second Round"
        },
        {
          "expected": 0.42652997709584606,
          "probs": 0.08530599541916921,
          "win": 0,
          "team": "St Louis",
          "round": "Sweet 16"
        },
        {
          "expected": 0.2778331966165076,
          "probs": 0.03472914957706345,
          "win": 0,
          "team": "St Louis",
          "round": "Elite Eight"
        },
        {
          "expected": 0.22901873356876437,
          "probs": 0.01761682565913572,
          "win": 0,
          "team": "St Louis",
          "round": "Final Four"
        },
        {
          "expected": 0.18504244027285313,
          "probs": 0.008811544774897768,
          "win": 0,
          "team": "St Louis",
          "round": "National Championship"
        },
        {
          "expected": 1.3818329899931352,
          "probs": 0.6909164949965676,
          "win": 1,
          "team": "Maryland",
          "round": "First Round"
        },
        {
          "expected": 0.8331884632082676,
          "probs": 0.2777294877360892,
          "win": 0,
          "team": "Maryland",
          "round": "Second Round"
        },
        {
          "expected": 0.7875480367161892,
          "probs": 0.15750960734323785,
          "win": 0,
          "team": "Maryland",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6362192869848167,
          "probs": 0.07952741087310208,
          "win": 0,
          "team": "Maryland",
          "round": "Elite Eight"
        },
        {
          "expected": 0.47826349937235185,
          "probs": 0.03678949995171937,
          "win": 0,
          "team": "Maryland",
          "round": "Final Four"
        },
        {
          "expected": 0.3975529479751355,
          "probs": 0.01893109276072074,
          "win": 0,
          "team": "Maryland",
          "round": "National Championship"
        },
        {
          "expected": 0.6181670100068648,
          "probs": 0.3090835050034324,
          "win": 0,
          "team": "Belmont",
          "round": "First Round"
        },
        {
          "expected": 0.7406764969792452,
          "probs": 0.2468921656597484,
          "win": 0,
          "team": "Belmont",
          "round": "Second Round"
        },
        {
          "expected": 0.5592610595824373,
          "probs": 0.11185221191648746,
          "win": 0,
          "team": "Belmont",
          "round": "Sweet 16"
        },
        {
          "expected": 0.48396949115819127,
          "probs": 0.06049618639477391,
          "win": 0,
          "team": "Belmont",
          "round": "Elite Eight"
        },
        {
          "expected": 0.36638690298291077,
          "probs": 0.028183607921762367,
          "win": 0,
          "team": "Belmont",
          "round": "Final Four"
        },
        {
          "expected": 0.3064228901814369,
          "probs": 0.014591566199116043,
          "win": 0,
          "team": "Belmont",
          "round": "National Championship"
        },
        {
          "expected": 1.5436190453298106,
          "probs": 0.7718095226649053,
          "win": 1,
          "team": "LSU",
          "round": "First Round"
        },
        {
          "expected": 1.015658417744208,
          "probs": 0.338552805914736,
          "win": 1,
          "team": "LSU",
          "round": "Second Round"
        },
        {
          "expected": 0.8061351087738615,
          "probs": 0.1612270217547723,
          "win": 0,
          "team": "LSU",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6835434017347625,
          "probs": 0.08544292521684531,
          "win": 0,
          "team": "LSU",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5301994644985606,
          "probs": 0.04078457419219697,
          "win": 0,
          "team": "LSU",
          "round": "Final Four"
        },
        {
          "expected": 0.4235850980511384,
          "probs": 0.020170718954816116,
          "win": 0,
          "team": "LSU",
          "round": "National Championship"
        },
        {
          "expected": 0.45638095467018935,
          "probs": 0.22819047733509468,
          "win": 0,
          "team": "Yale",
          "round": "First Round"
        },
        {
          "expected": 0.4104766220682791,
          "probs": 0.13682554068942637,
          "win": 0,
          "team": "Yale",
          "round": "Second Round"
        },
        {
          "expected": 0.4769165149543619,
          "probs": 0.09538330299087237,
          "win": 0,
          "team": "Yale",
          "round": "Sweet 16"
        },
        {
          "expected": 0.38908798572713676,
          "probs": 0.048635998215892096,
          "win": 0,
          "team": "Yale",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2872467201084957,
          "probs": 0.022095901546807364,
          "win": 0,
          "team": "Yale",
          "round": "Final Four"
        },
        {
          "expected": 0.23688947404379754,
          "probs": 0.01128045114494274,
          "win": 0,
          "team": "Yale",
          "round": "National Championship"
        },
        {
          "expected": 1.3565223184745034,
          "probs": 0.6782611592372517,
          "win": 1,
          "team": "Louisville",
          "round": "First Round"
        },
        {
          "expected": 0.8959438208986017,
          "probs": 0.2986479402995339,
          "win": 0,
          "team": "Louisville",
          "round": "Second Round"
        },
        {
          "expected": 0.6726997019086255,
          "probs": 0.1345399403817251,
          "win": 0,
          "team": "Louisville",
          "round": "Sweet 16"
        },
        {
          "expected": 0.599421850679446,
          "probs": 0.07492773133493075,
          "win": 0,
          "team": "Louisville",
          "round": "Elite Eight"
        },
        {
          "expected": 0.47420825102700603,
          "probs": 0.03647755777130816,
          "win": 0,
          "team": "Louisville",
          "round": "Final Four"
        },
        {
          "expected": 0.39424338358188354,
          "probs": 0.018773494456280168,
          "win": 0,
          "team": "Louisville",
          "round": "National Championship"
        },
        {
          "expected": 0.6434776815254966,
          "probs": 0.3217388407627483,
          "win": 0,
          "team": "Minnesota",
          "round": "First Round"
        },
        {
          "expected": 0.8365342299105152,
          "probs": 0.27884474330350506,
          "win": 0,
          "team": "Minnesota",
          "round": "Second Round"
        },
        {
          "expected": 0.6084199056059639,
          "probs": 0.12168398112119279,
          "win": 0,
          "team": "Minnesota",
          "round": "Sweet 16"
        },
        {
          "expected": 0.490652682173073,
          "probs": 0.061331585271634126,
          "win": 0,
          "team": "Minnesota",
          "round": "Elite Eight"
        },
        {
          "expected": 0.38430605636314236,
          "probs": 0.029562004335626335,
          "win": 0,
          "team": "Minnesota",
          "round": "Final Four"
        },
        {
          "expected": 0.31601057409628913,
          "probs": 0.015048122576013769,
          "win": 0,
          "team": "Minnesota",
          "round": "National Championship"
        },
        {
          "expected": 1.7751679440955594,
          "probs": 0.8875839720477797,
          "win": 1,
          "team": "Michigan St",
          "round": "First Round"
        },
        {
          "expected": 1.0434582518664295,
          "probs": 0.34781941728880983,
          "win": 1,
          "team": "Michigan St",
          "round": "Second Round"
        },
        {
          "expected": 0.8847840933471971,
          "probs": 0.1769568186694394,
          "win": 1,
          "team": "Michigan St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7001887511719881,
          "probs": 0.08752359389649851,
          "win": 0,
          "team": "Michigan St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5712163019051838,
          "probs": 0.04393971553116798,
          "win": 0,
          "team": "Michigan St",
          "round": "Final Four"
        },
        {
          "expected": 0.4620473719727411,
          "probs": 0.022002255808225766,
          "win": 0,
          "team": "Michigan St",
          "round": "National Championship"
        },
        {
          "expected": 0.22483205590444055,
          "probs": 0.11241602795222028,
          "win": 0,
          "team": "Bradley",
          "round": "First Round"
        },
        {
          "expected": 0.22406369732445364,
          "probs": 0.07468789910815121,
          "win": 0,
          "team": "Bradley",
          "round": "Second Round"
        },
        {
          "expected": 0.2042355791113637,
          "probs": 0.04084711582227274,
          "win": 0,
          "team": "Bradley",
          "round": "Sweet 16"
        },
        {
          "expected": 0.23351436299503564,
          "probs": 0.029189295374379455,
          "win": 0,
          "team": "Bradley",
          "round": "Elite Eight"
        },
        {
          "expected": 0.16211583777907143,
          "probs": 0.012470449059928572,
          "win": 0,
          "team": "Bradley",
          "round": "Final Four"
        },
        {
          "expected": 0.13059791371096538,
          "probs": 0.006218948271950732,
          "win": 0,
          "team": "Bradley",
          "round": "National Championship"
        },
        {
          "expected": 1.864306626057734,
          "probs": 0.932153313028867,
          "win": 1,
          "team": "Gonzaga",
          "round": "First Round"
        },
        {
          "expected": 1.0748048989627803,
          "probs": 0.3582682996542601,
          "win": 1,
          "team": "Gonzaga",
          "round": "Second Round"
        },
        {
          "expected": 0.8979303827555432,
          "probs": 0.17958607655110864,
          "win": 1,
          "team": "Gonzaga",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7211346700178858,
          "probs": 0.09014183375223572,
          "win": 1,
          "team": "Gonzaga",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5823214127442182,
          "probs": 0.04479395482647833,
          "win": 0,
          "team": "Gonzaga",
          "round": "Final Four"
        },
        {
          "expected": 0.47266229190877135,
          "probs": 0.02250772818613197,
          "win": 0,
          "team": "Gonzaga",
          "round": "National Championship"
        },
        {
          "expected": 0.1356933739422661,
          "probs": 0.06784668697113305,
          "win": 0,
          "team": "F Dickinson",
          "round": "First Round"
        },
        {
          "expected": 0.1505878245272329,
          "probs": 0.050195941509077635,
          "win": 0,
          "team": "F Dickinson",
          "round": "Second Round"
        },
        {
          "expected": 0.13220969889035655,
          "probs": 0.026441939778071313,
          "win": 0,
          "team": "F Dickinson",
          "round": "Sweet 16"
        },
        {
          "expected": 0.11515171842473827,
          "probs": 0.014393964803092284,
          "win": 0,
          "team": "F Dickinson",
          "round": "Elite Eight"
        },
        {
          "expected": 0.10966946696694554,
          "probs": 0.008436112843611196,
          "win": 0,
          "team": "F Dickinson",
          "round": "Final Four"
        },
        {
          "expected": 0.0827067608072862,
          "probs": 0.003938417181299343,
          "win": 0,
          "team": "F Dickinson",
          "round": "National Championship"
        },
        {
          "expected": 1.2693678863303814,
          "probs": 0.6346839431651907,
          "win": 1,
          "team": "Syracuse",
          "round": "First Round"
        },
        {
          "expected": 0.8928863914435576,
          "probs": 0.29762879714785256,
          "win": 0,
          "team": "Syracuse",
          "round": "Second Round"
        },
        {
          "expected": 0.6342920135767547,
          "probs": 0.12685840271535093,
          "win": 0,
          "team": "Syracuse",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5121819088579819,
          "probs": 0.06402273860724773,
          "win": 0,
          "team": "Syracuse",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4162643526463184,
          "probs": 0.03202033481894757,
          "win": 0,
          "team": "Syracuse",
          "round": "Final Four"
        },
        {
          "expected": 0.34736884584906225,
          "probs": 0.016541373611860106,
          "win": 0,
          "team": "Syracuse",
          "round": "National Championship"
        },
        {
          "expected": 0.7306321136696186,
          "probs": 0.3653160568348093,
          "win": 0,
          "team": "Baylor",
          "round": "First Round"
        },
        {
          "expected": 0.8817208850664291,
          "probs": 0.2939069616888097,
          "win": 0,
          "team": "Baylor",
          "round": "Second Round"
        },
        {
          "expected": 0.6200993755574825,
          "probs": 0.12401987511149651,
          "win": 0,
          "team": "Baylor",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4708744438463117,
          "probs": 0.058859305480788965,
          "win": 0,
          "team": "Baylor",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4078454323978302,
          "probs": 0.03137272556906386,
          "win": 0,
          "team": "Baylor",
          "round": "Final Four"
        },
        {
          "expected": 0.3202486476490093,
          "probs": 0.015249935602333776,
          "win": 0,
          "team": "Baylor",
          "round": "National Championship"
        },
        {
          "expected": 1.3560435703504607,
          "probs": 0.6780217851752304,
          "win": 1,
          "team": "Marquette",
          "round": "First Round"
        },
        {
          "expected": 0.818568682554363,
          "probs": 0.272856227518121,
          "win": 0,
          "team": "Marquette",
          "round": "Second Round"
        },
        {
          "expected": 0.7964254809988324,
          "probs": 0.15928509619976647,
          "win": 0,
          "team": "Marquette",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5390081381693649,
          "probs": 0.06737601727117061,
          "win": 0,
          "team": "Marquette",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4628196918027435,
          "probs": 0.03560151475405719,
          "win": 0,
          "team": "Marquette",
          "round": "Final Four"
        },
        {
          "expected": 0.38044038323372786,
          "probs": 0.01811620872541561,
          "win": 0,
          "team": "Marquette",
          "round": "National Championship"
        },
        {
          "expected": 0.6439564296495393,
          "probs": 0.3219782148247696,
          "win": 0,
          "team": "Murray St",
          "round": "First Round"
        },
        {
          "expected": 0.7433106634296848,
          "probs": 0.24777022114322825,
          "win": 0,
          "team": "Murray St",
          "round": "Second Round"
        },
        {
          "expected": 0.5865547604085365,
          "probs": 0.1173109520817073,
          "win": 0,
          "team": "Murray St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4589565160467921,
          "probs": 0.05736956450584901,
          "win": 0,
          "team": "Murray St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.386148916525257,
          "probs": 0.029703762809635156,
          "win": 0,
          "team": "Murray St",
          "round": "Final Four"
        },
        {
          "expected": 0.31245313502500144,
          "probs": 0.01487872071547626,
          "win": 0,
          "team": "Murray St",
          "round": "National Championship"
        },
        {
          "expected": 1.533588918240898,
          "probs": 0.766794459120449,
          "win": 1,
          "team": "Florida St",
          "round": "First Round"
        },
        {
          "expected": 1.0176061409194816,
          "probs": 0.3392020469731606,
          "win": 1,
          "team": "Florida St",
          "round": "Second Round"
        },
        {
          "expected": 0.8222948465988565,
          "probs": 0.1644589693197713,
          "win": 0,
          "team": "Florida St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.626378534444001,
          "probs": 0.07829731680550013,
          "win": 0,
          "team": "Florida St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5199523347007795,
          "probs": 0.0399963334385215,
          "win": 0,
          "team": "Florida St",
          "round": "Final Four"
        },
        {
          "expected": 0.42175700987036335,
          "probs": 0.02008366713668397,
          "win": 0,
          "team": "Florida St",
          "round": "National Championship"
        },
        {
          "expected": 0.46641108175910206,
          "probs": 0.23320554087955103,
          "win": 0,
          "team": "Vermont",
          "round": "First Round"
        },
        {
          "expected": 0.4205145130964705,
          "probs": 0.14017150436549017,
          "win": 0,
          "team": "Vermont",
          "round": "Second Round"
        },
        {
          "expected": 0.5101934412136379,
          "probs": 0.10203868824272756,
          "win": 0,
          "team": "Vermont",
          "round": "Sweet 16"
        },
        {
          "expected": 0.36050035855050033,
          "probs": 0.04506254481881254,
          "win": 0,
          "team": "Vermont",
          "round": "Elite Eight"
        },
        {
          "expected": 0.308135754087331,
          "probs": 0.02370275031441008,
          "win": 0,
          "team": "Vermont",
          "round": "Final Four"
        },
        {
          "expected": 0.23870972110238067,
          "probs": 0.011367129576303842,
          "win": 0,
          "team": "Vermont",
          "round": "National Championship"
        },
        {
          "expected": 1.409662096600278,
          "probs": 0.704831048300139,
          "win": 1,
          "team": "Buffalo",
          "round": "First Round"
        },
        {
          "expected": 0.8563152805696812,
          "probs": 0.2854384268565604,
          "win": 0,
          "team": "Buffalo",
          "round": "Second Round"
        },
        {
          "expected": 0.6913843272053699,
          "probs": 0.13827686544107398,
          "win": 0,
          "team": "Buffalo",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6328598788771466,
          "probs": 0.07910748485964332,
          "win": 0,
          "team": "Buffalo",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5136466418645451,
          "probs": 0.039511280143426544,
          "win": 0,
          "team": "Buffalo",
          "round": "Final Four"
        },
        {
          "expected": 0.40593969037831507,
          "probs": 0.01933046144658643,
          "win": 0,
          "team": "Buffalo",
          "round": "National Championship"
        },
        {
          "expected": 0.590337903399722,
          "probs": 0.295168951699861,
          "win": 0,
          "team": "Arizona St",
          "round": "First Round"
        },
        {
          "expected": 0.7499006189936771,
          "probs": 0.24996687299789236,
          "win": 0,
          "team": "Arizona St",
          "round": "Second Round"
        },
        {
          "expected": 0.5225052025900566,
          "probs": 0.10450104051801132,
          "win": 0,
          "team": "Arizona St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.43594006597477597,
          "probs": 0.054492508246846996,
          "win": 0,
          "team": "Arizona St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.36559002826727194,
          "probs": 0.028122309866713227,
          "win": 0,
          "team": "Arizona St",
          "round": "Final Four"
        },
        {
          "expected": 0.29075418221662563,
          "probs": 0.013845437248410744,
          "win": 0,
          "team": "Arizona St",
          "round": "National Championship"
        },
        {
          "expected": 1.634921046236841,
          "probs": 0.8174605231184205,
          "win": 1,
          "team": "Texas Tech",
          "round": "First Round"
        },
        {
          "expected": 1.0397518661297718,
          "probs": 0.3465839553765906,
          "win": 1,
          "team": "Texas Tech",
          "round": "Second Round"
        },
        {
          "expected": 0.8019598907903226,
          "probs": 0.16039197815806452,
          "win": 0,
          "team": "Texas Tech",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6885717409070258,
          "probs": 0.08607146761337822,
          "win": 0,
          "team": "Texas Tech",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5589923624959321,
          "probs": 0.042999412499687084,
          "win": 0,
          "team": "Texas Tech",
          "round": "Final Four"
        },
        {
          "expected": 0.44818467472278717,
          "probs": 0.02134212736775177,
          "win": 0,
          "team": "Texas Tech",
          "round": "National Championship"
        },
        {
          "expected": 0.3650789537631589,
          "probs": 0.18253947688157945,
          "win": 0,
          "team": "N Kentucky",
          "round": "First Round"
        },
        {
          "expected": 0.35403223430687003,
          "probs": 0.11801074476895668,
          "win": 0,
          "team": "N Kentucky",
          "round": "Second Round"
        },
        {
          "expected": 0.395908018840144,
          "probs": 0.0791816037680288,
          "win": 0,
          "team": "N Kentucky",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3098332514248747,
          "probs": 0.03872915642810934,
          "win": 0,
          "team": "N Kentucky",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2618206987275654,
          "probs": 0.020140053748274264,
          "win": 0,
          "team": "N Kentucky",
          "round": "Final Four"
        },
        {
          "expected": 0.1969125687012608,
          "probs": 0.009376788985774324,
          "win": 0,
          "team": "N Kentucky",
          "round": "National Championship"
        },
        {
          "expected": 1.366728711165511,
          "probs": 0.6833643555827555,
          "win": 1,
          "team": "Nevada",
          "round": "First Round"
        },
        {
          "expected": 0.8782953033532526,
          "probs": 0.29276510111775084,
          "win": 0,
          "team": "Nevada",
          "round": "Second Round"
        },
        {
          "expected": 0.7777116988283522,
          "probs": 0.15554233976567045,
          "win": 0,
          "team": "Nevada",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6359879720279793,
          "probs": 0.07949849650349741,
          "win": 0,
          "team": "Nevada",
          "round": "Elite Eight"
        },
        {
          "expected": 0.51619332284741,
          "probs": 0.039707178680570006,
          "win": 0,
          "team": "Nevada",
          "round": "Final Four"
        },
        {
          "expected": 0.41333399466268606,
          "probs": 0.019682571174413622,
          "win": 0,
          "team": "Nevada",
          "round": "National Championship"
        },
        {
          "expected": 0.6332712888344889,
          "probs": 0.31663564441724446,
          "win": 0,
          "team": "Florida",
          "round": "First Round"
        },
        {
          "expected": 0.8075551466716189,
          "probs": 0.2691850488905396,
          "win": 0,
          "team": "Florida",
          "round": "Second Round"
        },
        {
          "expected": 0.6308204001256662,
          "probs": 0.12616408002513324,
          "win": 0,
          "team": "Florida",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5212211422975944,
          "probs": 0.0651526427871993,
          "win": 0,
          "team": "Florida",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4101036002321915,
          "probs": 0.031546430787091656,
          "win": 0,
          "team": "Florida",
          "round": "Final Four"
        },
        {
          "expected": 0.32712337327201335,
          "probs": 0.015577303489143492,
          "win": 0,
          "team": "Florida",
          "round": "National Championship"
        },
        {
          "expected": 1.6819522746293292,
          "probs": 0.8409761373146646,
          "win": 1,
          "team": "Michigan",
          "round": "First Round"
        },
        {
          "expected": 1.0209795151693537,
          "probs": 0.34032650505645123,
          "win": 1,
          "team": "Michigan",
          "round": "Second Round"
        },
        {
          "expected": 0.8874450115359045,
          "probs": 0.1774890023071809,
          "win": 1,
          "team": "Michigan",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6894548691500768,
          "probs": 0.0861818586437596,
          "win": 0,
          "team": "Michigan",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5597118586656118,
          "probs": 0.04305475835889322,
          "win": 0,
          "team": "Michigan",
          "round": "Final Four"
        },
        {
          "expected": 0.44877704379338257,
          "probs": 0.021370335418732504,
          "win": 0,
          "team": "Michigan",
          "round": "National Championship"
        },
        {
          "expected": 0.31804772537067083,
          "probs": 0.15902386268533542,
          "win": 0,
          "team": "Montana",
          "round": "First Round"
        },
        {
          "expected": 0.2931700348057749,
          "probs": 0.0977233449352583,
          "win": 0,
          "team": "Montana",
          "round": "Second Round"
        },
        {
          "expected": 0.29226545008418386,
          "probs": 0.058453090016836774,
          "win": 0,
          "team": "Montana",
          "round": "Sweet 16"
        },
        {
          "expected": 0.28194479098295055,
          "probs": 0.03524309887286882,
          "win": 0,
          "team": "Montana",
          "round": "Elite Eight"
        },
        {
          "expected": 0.22825943840207397,
          "probs": 0.017558418338621075,
          "win": 0,
          "team": "Montana",
          "round": "Final Four"
        },
        {
          "expected": 0.17796574535583284,
          "probs": 0.008474559302658707,
          "win": 0,
          "team": "Montana",
          "round": "National Championship"
        },
        {
          "expected": 1.7975468441885418,
          "probs": 0.8987734220942709,
          "win": 1,
          "team": "Virginia",
          "round": "First Round"
        },
        {
          "expected": 1.0721364322578437,
          "probs": 0.3573788107526146,
          "win": 1,
          "team": "Virginia",
          "round": "Second Round"
        },
        {
          "expected": 0.9001895258250202,
          "probs": 0.18003790516500404,
          "win": 1,
          "team": "Virginia",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7269039118577583,
          "probs": 0.09086298898221978,
          "win": 1,
          "team": "Virginia",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5968915198361358,
          "probs": 0.045914732295087364,
          "win": 1,
          "team": "Virginia",
          "round": "Final Four"
        },
        {
          "expected": 0.4813708040864944,
          "probs": 0.02292241924221402,
          "win": 1,
          "team": "Virginia",
          "round": "National Championship"
        },
        {
          "expected": 0.20245315581145817,
          "probs": 0.10122657790572909,
          "win": 0,
          "team": "Gardner Webb",
          "round": "First Round"
        },
        {
          "expected": 0.21873383710217442,
          "probs": 0.07291127903405814,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Second Round"
        },
        {
          "expected": 0.19377660456523121,
          "probs": 0.038755320913046246,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Sweet 16"
        },
        {
          "expected": 0.16943891971811212,
          "probs": 0.021179864964764015,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Elite Eight"
        },
        {
          "expected": 0.1595141534943231,
          "probs": 0.012270319499563316,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Final Four"
        },
        {
          "expected": 0.12848434707218184,
          "probs": 0.0061183022415324684,
          "win": 0,
          "team": "Gardner Webb",
          "round": "National Championship"
        },
        {
          "expected": 0.717467121690303,
          "probs": 0.3587335608451515,
          "win": 0,
          "team": "Mississippi",
          "round": "First Round"
        },
        {
          "expected": 0.8451856969412378,
          "probs": 0.28172856564707927,
          "win": 0,
          "team": "Mississippi",
          "round": "Second Round"
        },
        {
          "expected": 0.6216839087087661,
          "probs": 0.12433678174175322,
          "win": 0,
          "team": "Mississippi",
          "round": "Sweet 16"
        },
        {
          "expected": 0.47652842939268325,
          "probs": 0.059566053674085406,
          "win": 0,
          "team": "Mississippi",
          "round": "Elite Eight"
        },
        {
          "expected": 0.40815201626796727,
          "probs": 0.03139630894368979,
          "win": 0,
          "team": "Mississippi",
          "round": "Final Four"
        },
        {
          "expected": 0.32876601766905744,
          "probs": 0.0156555246509075,
          "win": 0,
          "team": "Mississippi",
          "round": "National Championship"
        },
        {
          "expected": 1.282532878309697,
          "probs": 0.6412664391548485,
          "win": 1,
          "team": "Oklahoma",
          "round": "First Round"
        },
        {
          "expected": 0.8639440336987441,
          "probs": 0.287981344566248,
          "win": 0,
          "team": "Oklahoma",
          "round": "Second Round"
        },
        {
          "expected": 0.6426449062440245,
          "probs": 0.1285289812488049,
          "win": 0,
          "team": "Oklahoma",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5233762139768423,
          "probs": 0.06542202674710529,
          "win": 0,
          "team": "Oklahoma",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4459447699145932,
          "probs": 0.03430344383958409,
          "win": 0,
          "team": "Oklahoma",
          "round": "Final Four"
        },
        {
          "expected": 0.34912571716080865,
          "probs": 0.0166250341505147,
          "win": 0,
          "team": "Oklahoma",
          "round": "National Championship"
        },
        {
          "expected": 1.4414531963095396,
          "probs": 0.7207265981547698,
          "win": 1,
          "team": "Wisconsin",
          "round": "First Round"
        },
        {
          "expected": 1.0414730844292373,
          "probs": 0.3471576948097458,
          "win": 1,
          "team": "Wisconsin",
          "round": "Second Round"
        },
        {
          "expected": 0.8032383857623316,
          "probs": 0.16064767715246633,
          "win": 0,
          "team": "Wisconsin",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6271792946642099,
          "probs": 0.07839741183302623,
          "win": 0,
          "team": "Wisconsin",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5166424311626129,
          "probs": 0.03974172547404715,
          "win": 0,
          "team": "Wisconsin",
          "round": "Final Four"
        },
        {
          "expected": 0.41653366164306044,
          "probs": 0.019834936268717164,
          "win": 0,
          "team": "Wisconsin",
          "round": "National Championship"
        },
        {
          "expected": 0.5585468036904604,
          "probs": 0.2792734018452302,
          "win": 0,
          "team": "Oregon",
          "round": "First Round"
        },
        {
          "expected": 0.705419168499581,
          "probs": 0.23513972283319368,
          "win": 0,
          "team": "Oregon",
          "round": "Second Round"
        },
        {
          "expected": 0.5411570896650781,
          "probs": 0.10823141793301563,
          "win": 0,
          "team": "Oregon",
          "round": "Sweet 16"
        },
        {
          "expected": 0.41101641531272,
          "probs": 0.05137705191409,
          "win": 0,
          "team": "Oregon",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3434275338777791,
          "probs": 0.026417502605983006,
          "win": 0,
          "team": "Oregon",
          "round": "Final Four"
        },
        {
          "expected": 0.28135286773350654,
          "probs": 0.013397755606357455,
          "win": 0,
          "team": "Oregon",
          "round": "National Championship"
        },
        {
          "expected": 1.4930015627563138,
          "probs": 0.7465007813781569,
          "win": 1,
          "team": "Kansas St",
          "round": "First Round"
        },
        {
          "expected": 0.8085983264531544,
          "probs": 0.2695327754843848,
          "win": 0,
          "team": "Kansas St",
          "round": "Second Round"
        },
        {
          "expected": 0.7960173390725436,
          "probs": 0.15920346781450873,
          "win": 0,
          "team": "Kansas St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6209659927781227,
          "probs": 0.07762074909726534,
          "win": 0,
          "team": "Kansas St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4986189042999448,
          "probs": 0.03835530033076499,
          "win": 0,
          "team": "Kansas St",
          "round": "Final Four"
        },
        {
          "expected": 0.40197412811010413,
          "probs": 0.019141625148100198,
          "win": 0,
          "team": "Kansas St",
          "round": "National Championship"
        },
        {
          "expected": 0.5069984372436862,
          "probs": 0.2534992186218431,
          "win": 0,
          "team": "UC Irvine",
          "round": "First Round"
        },
        {
          "expected": 0.444509420618027,
          "probs": 0.14816980687267567,
          "win": 0,
          "team": "UC Irvine",
          "round": "Second Round"
        },
        {
          "expected": 0.5012922401570044,
          "probs": 0.10025844803140087,
          "win": 0,
          "team": "UC Irvine",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3768009922583144,
          "probs": 0.0471001240322893,
          "win": 0,
          "team": "UC Irvine",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3163078832833659,
          "probs": 0.02433137563718199,
          "win": 0,
          "team": "UC Irvine",
          "round": "Final Four"
        },
        {
          "expected": 0.25942480034155097,
          "probs": 0.012353561921026237,
          "win": 0,
          "team": "UC Irvine",
          "round": "National Championship"
        },
        {
          "expected": 1.370436531211971,
          "probs": 0.6852182656059855,
          "win": 1,
          "team": "Villanova",
          "round": "First Round"
        },
        {
          "expected": 0.8378926947231502,
          "probs": 0.27929756490771673,
          "win": 0,
          "team": "Villanova",
          "round": "Second Round"
        },
        {
          "expected": 0.7657474469943975,
          "probs": 0.15314948939887948,
          "win": 0,
          "team": "Villanova",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5822921584995016,
          "probs": 0.0727865198124377,
          "win": 0,
          "team": "Villanova",
          "round": "Elite Eight"
        },
        {
          "expected": 0.49008409370644584,
          "probs": 0.037698776438957374,
          "win": 0,
          "team": "Villanova",
          "round": "Final Four"
        },
        {
          "expected": 0.3793480088126046,
          "probs": 0.018064190895838314,
          "win": 0,
          "team": "Villanova",
          "round": "National Championship"
        },
        {
          "expected": 0.6295634687880289,
          "probs": 0.31478173439401447,
          "win": 0,
          "team": "St Mary's CA",
          "round": "First Round"
        },
        {
          "expected": 0.7562610709086991,
          "probs": 0.25208702363623303,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Second Round"
        },
        {
          "expected": 0.5404077185805779,
          "probs": 0.10808154371611559,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Sweet 16"
        },
        {
          "expected": 0.46431056393381287,
          "probs": 0.05803882049172661,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Elite Eight"
        },
        {
          "expected": 0.38199692705213173,
          "probs": 0.029384379004010135,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Final Four"
        },
        {
          "expected": 0.29779865350824763,
          "probs": 0.014180888262297506,
          "win": 0,
          "team": "St Mary's CA",
          "round": "National Championship"
        },
        {
          "expected": 1.6035044761557602,
          "probs": 0.8017522380778801,
          "win": 1,
          "team": "Purdue",
          "round": "First Round"
        },
        {
          "expected": 1.0320817863569551,
          "probs": 0.34402726211898504,
          "win": 1,
          "team": "Purdue",
          "round": "Second Round"
        },
        {
          "expected": 0.801000901311877,
          "probs": 0.1602001802623754,
          "win": 0,
          "team": "Purdue",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6752357605127367,
          "probs": 0.08440447006409209,
          "win": 0,
          "team": "Purdue",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5390438296767887,
          "probs": 0.04146490997513759,
          "win": 0,
          "team": "Purdue",
          "round": "Final Four"
        },
        {
          "expected": 0.4399950777936904,
          "probs": 0.020952146561604306,
          "win": 0,
          "team": "Purdue",
          "round": "National Championship"
        },
        {
          "expected": 0.3964955238442398,
          "probs": 0.1982477619221199,
          "win": 0,
          "team": "Old Dominion",
          "round": "First Round"
        },
        {
          "expected": 0.37376444801119546,
          "probs": 0.12458814933706516,
          "win": 0,
          "team": "Old Dominion",
          "round": "Second Round"
        },
        {
          "expected": 0.42069196908907636,
          "probs": 0.08413839381781527,
          "win": 0,
          "team": "Old Dominion",
          "round": "Sweet 16"
        },
        {
          "expected": 0.310579077311683,
          "probs": 0.038822384663960374,
          "win": 0,
          "team": "Old Dominion",
          "round": "Elite Eight"
        },
        {
          "expected": 0.26919632234548463,
          "probs": 0.020707409411191126,
          "win": 0,
          "team": "Old Dominion",
          "round": "Final Four"
        },
        {
          "expected": 0.21681092400588994,
          "probs": 0.010324329714566188,
          "win": 0,
          "team": "Old Dominion",
          "round": "National Championship"
        },
        {
          "expected": 1.3087156738665018,
          "probs": 0.6543578369332509,
          "win": 1,
          "team": "Cincinnati",
          "round": "First Round"
        },
        {
          "expected": 0.855097999385072,
          "probs": 0.2850326664616907,
          "win": 0,
          "team": "Cincinnati",
          "round": "Second Round"
        },
        {
          "expected": 0.6704984092472909,
          "probs": 0.13409968184945817,
          "win": 0,
          "team": "Cincinnati",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5750944730332219,
          "probs": 0.07188680912915274,
          "win": 0,
          "team": "Cincinnati",
          "round": "Elite Eight"
        },
        {
          "expected": 0.45850711484256934,
          "probs": 0.035269778064813025,
          "win": 0,
          "team": "Cincinnati",
          "round": "Final Four"
        },
        {
          "expected": 0.36950745066335583,
          "probs": 0.01759559288873123,
          "win": 0,
          "team": "Cincinnati",
          "round": "National Championship"
        },
        {
          "expected": 0.6912843261334982,
          "probs": 0.3456421630667491,
          "win": 0,
          "team": "Iowa",
          "round": "First Round"
        },
        {
          "expected": 0.8200660384728311,
          "probs": 0.27335534615761037,
          "win": 0,
          "team": "Iowa",
          "round": "Second Round"
        },
        {
          "expected": 0.6363751482181712,
          "probs": 0.12727502964363424,
          "win": 0,
          "team": "Iowa",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5172206491702056,
          "probs": 0.0646525811462757,
          "win": 0,
          "team": "Iowa",
          "round": "Elite Eight"
        },
        {
          "expected": 0.42463494253620315,
          "probs": 0.0326642263489387,
          "win": 0,
          "team": "Iowa",
          "round": "Final Four"
        },
        {
          "expected": 0.3370280346459285,
          "probs": 0.0160489540307585,
          "win": 0,
          "team": "Iowa",
          "round": "National Championship"
        },
        {
          "expected": 1.7046948031923423,
          "probs": 0.8523474015961712,
          "win": 1,
          "team": "Tennessee",
          "round": "First Round"
        },
        {
          "expected": 1.0392176369237962,
          "probs": 0.34640587897459874,
          "win": 1,
          "team": "Tennessee",
          "round": "Second Round"
        },
        {
          "expected": 0.8918171436509006,
          "probs": 0.17836342873018013,
          "win": 1,
          "team": "Tennessee",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6858551064785142,
          "probs": 0.08573188830981428,
          "win": 0,
          "team": "Tennessee",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5744162978761407,
          "probs": 0.04418586906739544,
          "win": 0,
          "team": "Tennessee",
          "round": "Final Four"
        },
        {
          "expected": 0.45773871353911066,
          "probs": 0.021797081597100507,
          "win": 0,
          "team": "Tennessee",
          "round": "National Championship"
        },
        {
          "expected": 0.29530519680765766,
          "probs": 0.14765259840382883,
          "win": 0,
          "team": "Colgate",
          "round": "First Round"
        },
        {
          "expected": 0.28561832521830066,
          "probs": 0.09520610840610022,
          "win": 0,
          "team": "Colgate",
          "round": "Second Round"
        },
        {
          "expected": 0.27346126290770867,
          "probs": 0.05469225258154173,
          "win": 0,
          "team": "Colgate",
          "round": "Sweet 16"
        },
        {
          "expected": 0.2572020411015611,
          "probs": 0.032150255137695136,
          "win": 0,
          "team": "Colgate",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2152393268883297,
          "probs": 0.016556871299102285,
          "win": 0,
          "team": "Colgate",
          "round": "Final Four"
        },
        {
          "expected": 0.16940262301522754,
          "probs": 0.008066791572153693,
          "win": 0,
          "team": "Colgate",
          "round": "National Championship"
        },
        {
          "expected": 1.8623037329981895,
          "probs": 0.9311518664990948,
          "win": 1,
          "team": "North Carolina",
          "round": "First Round"
        },
        {
          "expected": 1.0681206711564384,
          "probs": 0.3560402237188128,
          "win": 1,
          "team": "North Carolina",
          "round": "Second Round"
        },
        {
          "expected": 0.8918577868365163,
          "probs": 0.17837155736730326,
          "win": 1,
          "team": "North Carolina",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7276880157963207,
          "probs": 0.09096100197454009,
          "win": 1,
          "team": "North Carolina",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5737684782543425,
          "probs": 0.04413603678879558,
          "win": 0,
          "team": "North Carolina",
          "round": "Final Four"
        },
        {
          "expected": 0.46670326501472903,
          "probs": 0.02222396500070138,
          "win": 0,
          "team": "North Carolina",
          "round": "National Championship"
        },
        {
          "expected": 0.13769626700181048,
          "probs": 0.06884813350090524,
          "win": 0,
          "team": "Iona",
          "round": "First Round"
        },
        {
          "expected": 0.149569164284528,
          "probs": 0.04985638809484266,
          "win": 0,
          "team": "Iona",
          "round": "Second Round"
        },
        {
          "expected": 0.13307005287999826,
          "probs": 0.02661401057599965,
          "win": 0,
          "team": "Iona",
          "round": "Sweet 16"
        },
        {
          "expected": 0.1234576931746014,
          "probs": 0.015432211646825175,
          "win": 0,
          "team": "Iona",
          "round": "Elite Eight"
        },
        {
          "expected": 0.097875816388864,
          "probs": 0.007528908952989539,
          "win": 0,
          "team": "Iona",
          "round": "Final Four"
        },
        {
          "expected": 0.0891863329889937,
          "probs": 0.004246968237571129,
          "win": 0,
          "team": "Iona",
          "round": "National Championship"
        },
        {
          "expected": 0.7464869520055273,
          "probs": 0.37324347600276364,
          "win": 0,
          "team": "Utah St",
          "round": "First Round"
        },
        {
          "expected": 0.8893342961097241,
          "probs": 0.29644476536990805,
          "win": 0,
          "team": "Utah St",
          "round": "Second Round"
        },
        {
          "expected": 0.6246822110299006,
          "probs": 0.12493644220598013,
          "win": 0,
          "team": "Utah St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5179614424911825,
          "probs": 0.06474518031139781,
          "win": 0,
          "team": "Utah St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.40381525703750215,
          "probs": 0.031062712079807858,
          "win": 0,
          "team": "Utah St",
          "round": "Final Four"
        },
        {
          "expected": 0.3354899241268493,
          "probs": 0.01597571067270711,
          "win": 0,
          "team": "Utah St",
          "round": "National Championship"
        },
        {
          "expected": 1.2535130479944727,
          "probs": 0.6267565239972364,
          "win": 1,
          "team": "Washington",
          "round": "First Round"
        },
        {
          "expected": 0.8929758684493095,
          "probs": 0.2976586228164365,
          "win": 0,
          "team": "Washington",
          "round": "Second Round"
        },
        {
          "expected": 0.6292145629792506,
          "probs": 0.12584291259585012,
          "win": 0,
          "team": "Washington",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5214383241321359,
          "probs": 0.06517979051651698,
          "win": 0,
          "team": "Washington",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4191384776675434,
          "probs": 0.0322414213590418,
          "win": 0,
          "team": "Washington",
          "round": "Final Four"
        },
        {
          "expected": 0.3377324132604633,
          "probs": 0.01608249586954587,
          "win": 0,
          "team": "Washington",
          "round": "National Championship"
        },
        {
          "expected": 1.4031118847255273,
          "probs": 0.7015559423627636,
          "win": 1,
          "team": "Auburn",
          "round": "First Round"
        },
        {
          "expected": 0.8487246039387648,
          "probs": 0.2829082013129216,
          "win": 0,
          "team": "Auburn",
          "round": "Second Round"
        },
        {
          "expected": 0.8161965643033537,
          "probs": 0.16323931286067075,
          "win": 0,
          "team": "Auburn",
          "round": "Sweet 16"
        },
        {
          "expected": 0.631026859664764,
          "probs": 0.0788783574580955,
          "win": 0,
          "team": "Auburn",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5085699172324598,
          "probs": 0.039120762864035374,
          "win": 0,
          "team": "Auburn",
          "round": "Final Four"
        },
        {
          "expected": 0.40911850839765196,
          "probs": 0.019481833733221522,
          "win": 0,
          "team": "Auburn",
          "round": "National Championship"
        },
        {
          "expected": 0.5968881152744727,
          "probs": 0.29844405763723636,
          "win": 0,
          "team": "New Mexico St",
          "round": "First Round"
        },
        {
          "expected": 0.7421811962418536,
          "probs": 0.24739373208061788,
          "win": 0,
          "team": "New Mexico St",
          "round": "Second Round"
        },
        {
          "expected": 0.5811670633358001,
          "probs": 0.11623341266716003,
          "win": 0,
          "team": "New Mexico St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4660688185545981,
          "probs": 0.05825860231932476,
          "win": 0,
          "team": "New Mexico St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3615778505745718,
          "probs": 0.0278136808134286,
          "win": 0,
          "team": "New Mexico St",
          "round": "Final Four"
        },
        {
          "expected": 0.2967243858907433,
          "probs": 0.014129732661463966,
          "win": 0,
          "team": "New Mexico St",
          "round": "National Championship"
        },
        {
          "expected": 1.5590094848935803,
          "probs": 0.7795047424467901,
          "win": 1,
          "team": "Kansas",
          "round": "First Round"
        },
        {
          "expected": 1.0132109658076642,
          "probs": 0.33773698860255474,
          "win": 1,
          "team": "Kansas",
          "round": "Second Round"
        },
        {
          "expected": 0.8262039356771217,
          "probs": 0.16524078713542434,
          "win": 0,
          "team": "Kansas",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6398550435256852,
          "probs": 0.07998188044071065,
          "win": 0,
          "team": "Kansas",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5290571319476562,
          "probs": 0.04069670245751202,
          "win": 0,
          "team": "Kansas",
          "round": "Final Four"
        },
        {
          "expected": 0.4362302187946985,
          "probs": 0.02077286756165231,
          "win": 0,
          "team": "Kansas",
          "round": "National Championship"
        },
        {
          "expected": 0.44099051510641973,
          "probs": 0.22049525755320987,
          "win": 0,
          "team": "Northeastern",
          "round": "First Round"
        },
        {
          "expected": 0.39588323401171743,
          "probs": 0.1319610780039058,
          "win": 0,
          "team": "Northeastern",
          "round": "Second Round"
        },
        {
          "expected": 0.4976078229580587,
          "probs": 0.09952156459161174,
          "win": 0,
          "team": "Northeastern",
          "round": "Sweet 16"
        },
        {
          "expected": 0.36122377122836885,
          "probs": 0.045152971403546106,
          "win": 0,
          "team": "Northeastern",
          "round": "Elite Eight"
        },
        {
          "expected": 0.27721006832967554,
          "probs": 0.02132385140997504,
          "win": 0,
          "team": "Northeastern",
          "round": "Final Four"
        },
        {
          "expected": 0.22993164776401231,
          "probs": 0.010949126084000586,
          "win": 0,
          "team": "Northeastern",
          "round": "National Championship"
        },
        {
          "expected": 1.3533681637746269,
          "probs": 0.6766840818873134,
          "win": 1,
          "team": "Iowa St",
          "round": "First Round"
        },
        {
          "expected": 0.8373588874723221,
          "probs": 0.2791196291574407,
          "win": 0,
          "team": "Iowa St",
          "round": "Second Round"
        },
        {
          "expected": 0.6944565120148949,
          "probs": 0.13889130240297898,
          "win": 0,
          "team": "Iowa St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5837295108088189,
          "probs": 0.07296618885110236,
          "win": 0,
          "team": "Iowa St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4670719125912712,
          "probs": 0.035928608660867015,
          "win": 0,
          "team": "Iowa St",
          "round": "Final Four"
        },
        {
          "expected": 0.3707131161376707,
          "probs": 0.017653005530365272,
          "win": 0,
          "team": "Iowa St",
          "round": "National Championship"
        },
        {
          "expected": 0.6466318362253731,
          "probs": 0.32331591811268656,
          "win": 0,
          "team": "Ohio St",
          "round": "First Round"
        },
        {
          "expected": 0.7685081059466659,
          "probs": 0.2561693686488886,
          "win": 0,
          "team": "Ohio St",
          "round": "Second Round"
        },
        {
          "expected": 0.6359525099016639,
          "probs": 0.12719050198033277,
          "win": 0,
          "team": "Ohio St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.47508420679732,
          "probs": 0.059385525849665,
          "win": 0,
          "team": "Ohio St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3772375030757796,
          "probs": 0.02901826946736766,
          "win": 0,
          "team": "Ohio St",
          "round": "Final Four"
        },
        {
          "expected": 0.30438707612740645,
          "probs": 0.01449462267273364,
          "win": 0,
          "team": "Ohio St",
          "round": "National Championship"
        },
        {
          "expected": 1.6273113030342272,
          "probs": 0.8136556515171136,
          "win": 1,
          "team": "Houston",
          "round": "First Round"
        },
        {
          "expected": 1.0373463470836992,
          "probs": 0.3457821156945664,
          "win": 1,
          "team": "Houston",
          "round": "Second Round"
        },
        {
          "expected": 0.8168960560724445,
          "probs": 0.1633792112144889,
          "win": 0,
          "team": "Houston",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6831427034646655,
          "probs": 0.0853928379330832,
          "win": 0,
          "team": "Houston",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5486681334081042,
          "probs": 0.04220524103139263,
          "win": 0,
          "team": "Houston",
          "round": "Final Four"
        },
        {
          "expected": 0.44120453767629736,
          "probs": 0.021009739889347494,
          "win": 0,
          "team": "Houston",
          "round": "National Championship"
        },
        {
          "expected": 0.3726886969657728,
          "probs": 0.1863443484828864,
          "win": 0,
          "team": "Georgia St",
          "round": "First Round"
        },
        {
          "expected": 0.356786659497313,
          "probs": 0.11892888649910432,
          "win": 0,
          "team": "Georgia St",
          "round": "Second Round"
        },
        {
          "expected": 0.4233455252906368,
          "probs": 0.08466910505812736,
          "win": 0,
          "team": "Georgia St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.31010583820624554,
          "probs": 0.03876322977578069,
          "win": 0,
          "team": "Georgia St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.23973839388663898,
          "probs": 0.018441414914356843,
          "win": 0,
          "team": "Georgia St",
          "round": "Final Four"
        },
        {
          "expected": 0.2086203561934838,
          "probs": 0.00993430267588018,
          "win": 0,
          "team": "Georgia St",
          "round": "National Championship"
        },
        {
          "expected": 1.385827142855928,
          "probs": 0.692913571427964,
          "win": 1,
          "team": "Wofford",
          "round": "First Round"
        },
        {
          "expected": 0.8786911384230722,
          "probs": 0.2928970461410241,
          "win": 0,
          "team": "Wofford",
          "round": "Second Round"
        },
        {
          "expected": 0.7613319242378075,
          "probs": 0.1522663848475615,
          "win": 0,
          "team": "Wofford",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5875278680382295,
          "probs": 0.07344098350477869,
          "win": 0,
          "team": "Wofford",
          "round": "Elite Eight"
        },
        {
          "expected": 0.47027092531993686,
          "probs": 0.036174686563072066,
          "win": 0,
          "team": "Wofford",
          "round": "Final Four"
        },
        {
          "expected": 0.3784338753164888,
          "probs": 0.01802066072935661,
          "win": 0,
          "team": "Wofford",
          "round": "National Championship"
        },
        {
          "expected": 0.6141728571440721,
          "probs": 0.30708642857203605,
          "win": 0,
          "team": "Seton Hall",
          "round": "First Round"
        },
        {
          "expected": 0.7966247964019956,
          "probs": 0.2655415988006652,
          "win": 0,
          "team": "Seton Hall",
          "round": "Second Round"
        },
        {
          "expected": 0.5248928079818848,
          "probs": 0.10497856159637695,
          "win": 0,
          "team": "Seton Hall",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4337442748862783,
          "probs": 0.05421803436078479,
          "win": 0,
          "team": "Seton Hall",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3553922140433035,
          "probs": 0.027337862618715656,
          "win": 0,
          "team": "Seton Hall",
          "round": "Final Four"
        },
        {
          "expected": 0.2869895046814202,
          "probs": 0.013666166889591439,
          "win": 0,
          "team": "Seton Hall",
          "round": "National Championship"
        },
        {
          "expected": 1.738615741282133,
          "probs": 0.8693078706410665,
          "win": 1,
          "team": "Kentucky",
          "round": "First Round"
        },
        {
          "expected": 1.055339867813387,
          "probs": 0.35177995593779565,
          "win": 1,
          "team": "Kentucky",
          "round": "Second Round"
        },
        {
          "expected": 0.8939595645800389,
          "probs": 0.17879191291600777,
          "win": 1,
          "team": "Kentucky",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6907235417779272,
          "probs": 0.0863404427222409,
          "win": 0,
          "team": "Kentucky",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5550188657335497,
          "probs": 0.04269375890258075,
          "win": 0,
          "team": "Kentucky",
          "round": "Final Four"
        },
        {
          "expected": 0.4570852505872814,
          "probs": 0.021765964313680067,
          "win": 0,
          "team": "Kentucky",
          "round": "National Championship"
        },
        {
          "expected": 0.26138425871786697,
          "probs": 0.13069212935893348,
          "win": 0,
          "team": "Abilene Chr",
          "round": "First Round"
        },
        {
          "expected": 0.26934419736154525,
          "probs": 0.08978139912051508,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Second Round"
        },
        {
          "expected": 0.24916509992062877,
          "probs": 0.04983301998412575,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Sweet 16"
        },
        {
          "expected": 0.24722208745285845,
          "probs": 0.030902760931607307,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Elite Eight"
        },
        {
          "expected": 0.17697098744798478,
          "probs": 0.013613152880614213,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Final Four"
        },
        {
          "expected": 0.1538801806517147,
          "probs": 0.0073276276500816515,
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
          "expr": "'probability of winning match: ' + format(100*datum.probs, ',.2f')",
          "as": "probstip"
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
          "expr": "'probability of winning match: ' + format(100*datum.probs, ',.2f')",
          "as": "probstip"
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
              "tooltip": {"signal": "''+datum[\"probstip\"]"},
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
              "tooltip": {"signal": "''+datum[\"probstip\"]"},
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
