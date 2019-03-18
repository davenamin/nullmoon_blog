---
title: "march madness"
date: 2019-03-17T22:33:58-04:00
draft: true
slug: marchmadness
---

I've been participating in a March Madness bracket league for a couple
of years now. It's been a lot of fun! Unfortunately I don't know the
first thing about 'bucketball' or who plays it.


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
        {"expected": 2, "win": 1, "team": "Duke", "round": "First Round"},
        {
          "expected": 1.4999999999999996,
          "win": 1,
          "team": "Duke",
          "round": "Second Round"
        },
        {
          "expected": 1.2499999218812927,
          "win": 1,
          "team": "Duke",
          "round": "Sweet 16"
        },
        {
          "expected": 0.9991811049410654,
          "win": 1,
          "team": "Duke",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7943516066730855,
          "win": 1,
          "team": "Duke",
          "round": "Final Four"
        },
        {
          "expected": 0.6376283067851353,
          "win": 0,
          "team": "Duke",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "N Dakota St",
          "round": "First Round"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "N Dakota St",
          "round": "Second Round"
        },
        {"expected": 0, "win": 0, "team": "N Dakota St", "round": "Sweet 16"},
        {
          "expected": 0,
          "win": 0,
          "team": "N Dakota St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.05051258053359689,
          "win": 0,
          "team": "N Dakota St",
          "round": "Final Four"
        },
        {
          "expected": 0.02037159846149188,
          "win": 0,
          "team": "N Dakota St",
          "round": "National Championship"
        },
        {
          "expected": 0.9448428379152509,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "First Round"
        },
        {
          "expected": 0.7500000000000002,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Second Round"
        },
        {
          "expected": 0.6250051196540154,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5000043828525833,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4570344210488413,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "Final Four"
        },
        {
          "expected": 0.36840604972204877,
          "win": 0,
          "team": "VA Commonwealth",
          "round": "National Championship"
        },
        {
          "expected": 1.055157162084749,
          "win": 1,
          "team": "UCF",
          "round": "First Round"
        },
        {
          "expected": 0.7500000000000002,
          "win": 0,
          "team": "UCF",
          "round": "Second Round"
        },
        {
          "expected": 0.6250051812227052,
          "win": 0,
          "team": "UCF",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5000044356590336,
          "win": 0,
          "team": "UCF",
          "round": "Elite Eight"
        },
        {
          "expected": 0.45703506462737753,
          "win": 0,
          "team": "UCF",
          "round": "Final Four"
        },
        {
          "expected": 0.3684166317675104,
          "win": 0,
          "team": "UCF",
          "round": "National Championship"
        },
        {
          "expected": 2,
          "win": 1,
          "team": "Mississippi St",
          "round": "First Round"
        },
        {
          "expected": 0.7500238646745129,
          "win": 0,
          "team": "Mississippi St",
          "round": "Second Round"
        },
        {
          "expected": 0.93748969948795,
          "win": 0,
          "team": "Mississippi St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5988495145068101,
          "win": 0,
          "team": "Mississippi St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5069860389896811,
          "win": 0,
          "team": "Mississippi St",
          "round": "Final Four"
        },
        {
          "expected": 0.44490754603425453,
          "win": 0,
          "team": "Mississippi St",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Liberty", "round": "First Round"},
        {
          "expected": 0.75,
          "win": 0,
          "team": "Liberty",
          "round": "Second Round"
        },
        {"expected": 0.3125, "win": 0, "team": "Liberty", "round": "Sweet 16"},
        {
          "expected": 0.24942495645486096,
          "win": 0,
          "team": "Liberty",
          "round": "Elite Eight"
        },
        {
          "expected": 0.20186605686295275,
          "win": 0,
          "team": "Liberty",
          "round": "Final Four"
        },
        {
          "expected": 0.14370313322871717,
          "win": 0,
          "team": "Liberty",
          "round": "National Championship"
        },
        {
          "expected": 2,
          "win": 1,
          "team": "Virginia Tech",
          "round": "First Round"
        },
        {
          "expected": 1.499976135325487,
          "win": 1,
          "team": "Virginia Tech",
          "round": "Second Round"
        },
        {
          "expected": 0.9375000777540365,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7967426183325675,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Elite Eight"
        },
        {
          "expected": 0.647556881044063,
          "win": 0,
          "team": "Virginia Tech",
          "round": "Final Four"
        },
        {
          "expected": 0.5166070555957876,
          "win": 0,
          "team": "Virginia Tech",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "St Louis", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "St Louis", "round": "Second Round"},
        {"expected": 0.3125, "win": 0, "team": "St Louis", "round": "Sweet 16"},
        {
          "expected": 0.125,
          "win": 0,
          "team": "St Louis",
          "round": "Elite Eight"
        },
        {
          "expected": 0.10153783929741499,
          "win": 0,
          "team": "St Louis",
          "round": "Final Four"
        },
        {
          "expected": 0.08203131538243616,
          "win": 0,
          "team": "St Louis",
          "round": "National Championship"
        },
        {
          "expected": 1.9999999999999973,
          "win": 1,
          "team": "Maryland",
          "round": "First Round"
        },
        {
          "expected": 0.7501278386032909,
          "win": 0,
          "team": "Maryland",
          "round": "Second Round"
        },
        {
          "expected": 0.9211235379331535,
          "win": 0,
          "team": "Maryland",
          "round": "Sweet 16"
        },
        {
          "expected": 0.737476833702838,
          "win": 0,
          "team": "Maryland",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5113661088614417,
          "win": 0,
          "team": "Maryland",
          "round": "Final Four"
        },
        {
          "expected": 0.45200531552300866,
          "win": 0,
          "team": "Maryland",
          "round": "National Championship"
        },
        {
          "expected": 2.6645352591003757e-15,
          "win": 0,
          "team": "Belmont",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Belmont",
          "round": "Second Round"
        },
        {
          "expected": 0.3175194139632914,
          "win": 0,
          "team": "Belmont",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3750000001459487,
          "win": 0,
          "team": "Belmont",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2668048108692719,
          "win": 0,
          "team": "Belmont",
          "round": "Final Four"
        },
        {
          "expected": 0.24131863401499987,
          "win": 0,
          "team": "Belmont",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "LSU", "round": "First Round"},
        {
          "expected": 1.4998721613967092,
          "win": 1,
          "team": "LSU",
          "round": "Second Round"
        },
        {
          "expected": 0.9375129666864774,
          "win": 0,
          "team": "LSU",
          "round": "Sweet 16"
        },
        {
          "expected": 0.828224867007502,
          "win": 0,
          "team": "LSU",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6512363593624001,
          "win": 0,
          "team": "LSU",
          "round": "Final Four"
        },
        {
          "expected": 0.5193471639552505,
          "win": 0,
          "team": "LSU",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Yale", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "Yale", "round": "Second Round"},
        {"expected": 0.3125, "win": 0, "team": "Yale", "round": "Sweet 16"},
        {
          "expected": 0.2505750435451391,
          "win": 0,
          "team": "Yale",
          "round": "Elite Eight"
        },
        {
          "expected": 0.15954843591672624,
          "win": 0,
          "team": "Yale",
          "round": "Final Four"
        },
        {
          "expected": 0.14341731525315632,
          "win": 0,
          "team": "Yale",
          "round": "National Championship"
        },
        {
          "expected": 1.9999999999976175,
          "win": 1,
          "team": "Louisville",
          "round": "First Round"
        },
        {
          "expected": 0.750000000447844,
          "win": 0,
          "team": "Louisville",
          "round": "Second Round"
        },
        {
          "expected": 0.6413797187244272,
          "win": 0,
          "team": "Louisville",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6637016733519874,
          "win": 0,
          "team": "Louisville",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5054791855275614,
          "win": 0,
          "team": "Louisville",
          "round": "Final Four"
        },
        {
          "expected": 0.4399529864165924,
          "win": 0,
          "team": "Louisville",
          "round": "National Championship"
        },
        {
          "expected": 2.382538610845586e-12,
          "win": 0,
          "team": "Minnesota",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Minnesota",
          "round": "Second Round"
        },
        {
          "expected": 0.6199805860367381,
          "win": 0,
          "team": "Minnesota",
          "round": "Sweet 16"
        },
        {
          "expected": 0.37500000811028245,
          "win": 0,
          "team": "Minnesota",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3040342620548865,
          "win": 0,
          "team": "Minnesota",
          "round": "Final Four"
        },
        {
          "expected": 0.2656925797375278,
          "win": 0,
          "team": "Minnesota",
          "round": "National Championship"
        },
        {
          "expected": 2,
          "win": 1,
          "team": "Michigan St",
          "round": "First Round"
        },
        {
          "expected": 1.499999999552156,
          "win": 1,
          "team": "Michigan St",
          "round": "Second Round"
        },
        {
          "expected": 1.2499837766559125,
          "win": 1,
          "team": "Michigan St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.8758145613893815,
          "win": 0,
          "team": "Michigan St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7536024851611917,
          "win": 0,
          "team": "Michigan St",
          "round": "Final Four"
        },
        {
          "expected": 0.6005849460175443,
          "win": 0,
          "team": "Michigan St",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Bradley", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "Bradley", "round": "Second Round"},
        {"expected": 0, "win": 0, "team": "Bradley", "round": "Sweet 16"},
        {
          "expected": 0.125,
          "win": 0,
          "team": "Bradley",
          "round": "Elite Eight"
        },
        {
          "expected": 0.05078125,
          "win": 0,
          "team": "Bradley",
          "round": "Final Four"
        },
        {
          "expected": 0.0410045277822039,
          "win": 0,
          "team": "Bradley",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Gonzaga", "round": "First Round"},
        {"expected": 1.5, "win": 1, "team": "Gonzaga", "round": "Second Round"},
        {
          "expected": 1.249999959080618,
          "win": 1,
          "team": "Gonzaga",
          "round": "Sweet 16"
        },
        {
          "expected": 0.9997210485972287,
          "win": 1,
          "team": "Gonzaga",
          "round": "Elite Eight"
        },
        {
          "expected": 0.779255881821259,
          "win": 0,
          "team": "Gonzaga",
          "round": "Final Four"
        },
        {
          "expected": 0.6348772232782621,
          "win": 0,
          "team": "Gonzaga",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "F Dickinson",
          "round": "First Round"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "F Dickinson",
          "round": "Second Round"
        },
        {"expected": 0, "win": 0, "team": "F Dickinson", "round": "Sweet 16"},
        {
          "expected": 0,
          "win": 0,
          "team": "F Dickinson",
          "round": "Elite Eight"
        },
        {
          "expected": 0.00026866946640311017,
          "win": 0,
          "team": "F Dickinson",
          "round": "Final Four"
        },
        {
          "expected": 0.008654411592639792,
          "win": 0,
          "team": "F Dickinson",
          "round": "National Championship"
        },
        {
          "expected": 1.9953946709045705,
          "win": 1,
          "team": "Syracuse",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Syracuse",
          "round": "Second Round"
        },
        {
          "expected": 0.6249992164810965,
          "win": 0,
          "team": "Syracuse",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4985843700679579,
          "win": 0,
          "team": "Syracuse",
          "round": "Elite Eight"
        },
        {
          "expected": 0.355515257910595,
          "win": 0,
          "team": "Syracuse",
          "round": "Final Four"
        },
        {
          "expected": 0.3396097128206705,
          "win": 0,
          "team": "Syracuse",
          "round": "National Championship"
        },
        {
          "expected": 0.0046053290954295445,
          "win": 0,
          "team": "Baylor",
          "round": "First Round"
        },
        {"expected": 0.75, "win": 0, "team": "Baylor", "round": "Second Round"},
        {
          "expected": 0.6246550777922388,
          "win": 0,
          "team": "Baylor",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3943109879982951,
          "win": 0,
          "team": "Baylor",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3542742490457993,
          "win": 0,
          "team": "Baylor",
          "round": "Final Four"
        },
        {
          "expected": 0.27119795799214386,
          "win": 0,
          "team": "Baylor",
          "round": "National Championship"
        },
        {
          "expected": 1.99999999999811,
          "win": 1,
          "team": "Marquette",
          "round": "First Round"
        },
        {
          "expected": 0.7500021749462777,
          "win": 0,
          "team": "Marquette",
          "round": "Second Round"
        },
        {
          "expected": 0.9374999045505827,
          "win": 0,
          "team": "Marquette",
          "round": "Sweet 16"
        },
        {
          "expected": 0.5000344277927495,
          "win": 0,
          "team": "Marquette",
          "round": "Elite Eight"
        },
        {
          "expected": 0.46101885112876756,
          "win": 0,
          "team": "Marquette",
          "round": "Final Four"
        },
        {
          "expected": 0.4064947984459123,
          "win": 0,
          "team": "Marquette",
          "round": "National Championship"
        },
        {
          "expected": 1.8900436771218665e-12,
          "win": 0,
          "team": "Murray St",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Murray St",
          "round": "Second Round"
        },
        {
          "expected": 0.3128458011765185,
          "win": 0,
          "team": "Murray St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3747652365786012,
          "win": 0,
          "team": "Murray St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.29360394402775447,
          "win": 0,
          "team": "Murray St",
          "round": "Final Four"
        },
        {
          "expected": 0.2523355084983673,
          "win": 0,
          "team": "Murray St",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Florida St", "round": "First Round"},
        {
          "expected": 1.4999978250537223,
          "win": 1,
          "team": "Florida St",
          "round": "Second Round"
        },
        {
          "expected": 0.9375000409189451,
          "win": 0,
          "team": "Florida St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.740963959275093,
          "win": 0,
          "team": "Florida St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6288987146419095,
          "win": 0,
          "team": "Florida St",
          "round": "Final Four"
        },
        {
          "expected": 0.5092453125300006,
          "win": 0,
          "team": "Florida St",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Vermont", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "Vermont", "round": "Second Round"},
        {"expected": 0.3125, "win": 0, "team": "Vermont", "round": "Sweet 16"},
        {
          "expected": 0.24999999999991473,
          "win": 0,
          "team": "Vermont",
          "round": "Elite Eight"
        },
        {
          "expected": 0.1971792572201314,
          "win": 0,
          "team": "Vermont",
          "round": "Final Four"
        },
        {
          "expected": 0.14353363793595514,
          "win": 0,
          "team": "Vermont",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Buffalo", "round": "First Round"},
        {
          "expected": 0.7500013046325836,
          "win": 0,
          "team": "Buffalo",
          "round": "Second Round"
        },
        {
          "expected": 0.6667322866629708,
          "win": 0,
          "team": "Buffalo",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7513493605785323,
          "win": 0,
          "team": "Buffalo",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6059484661081859,
          "win": 0,
          "team": "Buffalo",
          "round": "Final Four"
        },
        {
          "expected": 0.4667231972815765,
          "win": 0,
          "team": "Buffalo",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Arizona St", "round": "First Round"},
        {
          "expected": 0.75,
          "win": 0,
          "team": "Arizona St",
          "round": "Second Round"
        },
        {
          "expected": 0.31250016140943815,
          "win": 0,
          "team": "Arizona St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.2502629054981376,
          "win": 0,
          "team": "Arizona St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.25418734234267715,
          "win": 0,
          "team": "Arizona St",
          "round": "Final Four"
        },
        {
          "expected": 0.19963620131314946,
          "win": 0,
          "team": "Arizona St",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Texas Tech", "round": "First Round"},
        {
          "expected": 1.4999986953674163,
          "win": 1,
          "team": "Texas Tech",
          "round": "Second Round"
        },
        {
          "expected": 1.0476179427099628,
          "win": 0,
          "team": "Texas Tech",
          "round": "Sweet 16"
        },
        {
          "expected": 0.8750871590213547,
          "win": 0,
          "team": "Texas Tech",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7142458741076839,
          "win": 0,
          "team": "Texas Tech",
          "round": "Final Four"
        },
        {
          "expected": 0.5763677182614487,
          "win": 0,
          "team": "Texas Tech",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "N Kentucky", "round": "First Round"},
        {
          "expected": 0,
          "win": 0,
          "team": "N Kentucky",
          "round": "Second Round"
        },
        {
          "expected": 0.3124999992675528,
          "win": 0,
          "team": "N Kentucky",
          "round": "Sweet 16"
        },
        {
          "expected": 0.12500000000008543,
          "win": 0,
          "team": "N Kentucky",
          "round": "Elite Eight"
        },
        {
          "expected": 0.15234352867566414,
          "win": 0,
          "team": "N Kentucky",
          "round": "Final Four"
        },
        {
          "expected": 0.09037788826852874,
          "win": 0,
          "team": "N Kentucky",
          "round": "National Championship"
        },
        {
          "expected": 1.9999999999996594,
          "win": 1,
          "team": "Nevada",
          "round": "First Round"
        },
        {
          "expected": 0.7500046090406467,
          "win": 0,
          "team": "Nevada",
          "round": "Second Round"
        },
        {
          "expected": 0.895771233243541,
          "win": 0,
          "team": "Nevada",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7576805101556585,
          "win": 0,
          "team": "Nevada",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6104490367810844,
          "win": 0,
          "team": "Nevada",
          "round": "Final Four"
        },
        {
          "expected": 0.485119985298276,
          "win": 0,
          "team": "Nevada",
          "round": "National Championship"
        },
        {
          "expected": 3.4061642395499803e-13,
          "win": 0,
          "team": "Florida",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Florida",
          "round": "Second Round"
        },
        {
          "expected": 0.6249998385908744,
          "win": 0,
          "team": "Florida",
          "round": "Sweet 16"
        },
        {
          "expected": 0.48207650034978156,
          "win": 0,
          "team": "Florida",
          "round": "Elite Eight"
        },
        {
          "expected": 0.35522425591304685,
          "win": 0,
          "team": "Florida",
          "round": "Final Four"
        },
        {
          "expected": 0.2832386644555989,
          "win": 0,
          "team": "Florida",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Michigan", "round": "First Round"},
        {
          "expected": 1.4999953909593533,
          "win": 1,
          "team": "Michigan",
          "round": "Second Round"
        },
        {
          "expected": 1.1398785373832125,
          "win": 1,
          "team": "Michigan",
          "round": "Sweet 16"
        },
        {
          "expected": 0.87516353408661,
          "win": 0,
          "team": "Michigan",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7162659019514331,
          "win": 0,
          "team": "Michigan",
          "round": "Final Four"
        },
        {
          "expected": 0.5794295074445206,
          "win": 0,
          "team": "Michigan",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Montana", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "Montana", "round": "Second Round"},
        {
          "expected": 7.324472278691374e-10,
          "win": 0,
          "team": "Montana",
          "round": "Sweet 16"
        },
        {
          "expected": 0.125,
          "win": 0,
          "team": "Montana",
          "round": "Elite Eight"
        },
        {
          "expected": 0.10158738202711282,
          "win": 0,
          "team": "Montana",
          "round": "Final Four"
        },
        {
          "expected": 0.0820276649008094,
          "win": 0,
          "team": "Montana",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Virginia", "round": "First Round"},
        {
          "expected": 1.5,
          "win": 1,
          "team": "Virginia",
          "round": "Second Round"
        },
        {
          "expected": 1.2499999975237799,
          "win": 1,
          "team": "Virginia",
          "round": "Sweet 16"
        },
        {
          "expected": 0.9997856084632647,
          "win": 1,
          "team": "Virginia",
          "round": "Elite Eight"
        },
        {
          "expected": 0.8106696133664252,
          "win": 1,
          "team": "Virginia",
          "round": "Final Four"
        },
        {
          "expected": 0.6490040990986022,
          "win": 1,
          "team": "Virginia",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Gardner Webb",
          "round": "First Round"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Second Round"
        },
        {"expected": 0, "win": 0, "team": "Gardner Webb", "round": "Sweet 16"},
        {
          "expected": 0,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Elite Eight"
        },
        {
          "expected": 0.050781250000046275,
          "win": 0,
          "team": "Gardner Webb",
          "round": "Final Four"
        },
        {
          "expected": 0.0410267222493642,
          "win": 0,
          "team": "Gardner Webb",
          "round": "National Championship"
        },
        {
          "expected": 0.00025024051828492766,
          "win": 0,
          "team": "Mississippi",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Mississippi",
          "round": "Second Round"
        },
        {
          "expected": 0.6249999994802301,
          "win": 0,
          "team": "Mississippi",
          "round": "Sweet 16"
        },
        {
          "expected": 0.3814610782217189,
          "win": 0,
          "team": "Mississippi",
          "round": "Elite Eight"
        },
        {
          "expected": 0.36560722978055615,
          "win": 0,
          "team": "Mississippi",
          "round": "Final Four"
        },
        {
          "expected": 0.2932130472786092,
          "win": 0,
          "team": "Mississippi",
          "round": "National Championship"
        },
        {
          "expected": 1.999749759481715,
          "win": 1,
          "team": "Oklahoma",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Oklahoma",
          "round": "Second Round"
        },
        {
          "expected": 0.625000002446061,
          "win": 0,
          "team": "Oklahoma",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4997596468193448,
          "win": 0,
          "team": "Oklahoma",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4568128589109389,
          "win": 0,
          "team": "Oklahoma",
          "round": "Final Four"
        },
        {
          "expected": 0.3295406322390758,
          "win": 0,
          "team": "Oklahoma",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Wisconsin", "round": "First Round"},
        {
          "expected": 1.477776648408574,
          "win": 1,
          "team": "Wisconsin",
          "round": "Second Round"
        },
        {
          "expected": 0.9375000023155957,
          "win": 0,
          "team": "Wisconsin",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7501854098622458,
          "win": 0,
          "team": "Wisconsin",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6047303868113065,
          "win": 0,
          "team": "Wisconsin",
          "round": "Final Four"
        },
        {
          "expected": 0.4956182617635202,
          "win": 0,
          "team": "Wisconsin",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Oregon", "round": "First Round"},
        {
          "expected": 0.7499999985688265,
          "win": 0,
          "team": "Oregon",
          "round": "Second Round"
        },
        {
          "expected": 0.31250000052017934,
          "win": 0,
          "team": "Oregon",
          "round": "Sweet 16"
        },
        {
          "expected": 0.2500036507903858,
          "win": 0,
          "team": "Oregon",
          "round": "Elite Eight"
        },
        {
          "expected": 0.20342047616236503,
          "win": 0,
          "team": "Oregon",
          "round": "Final Four"
        },
        {
          "expected": 0.18462629947725184,
          "win": 0,
          "team": "Oregon",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Kansas St", "round": "First Round"},
        {
          "expected": 0.7722233515914261,
          "win": 0,
          "team": "Kansas St",
          "round": "Second Round"
        },
        {
          "expected": 0.9374999977141539,
          "win": 0,
          "team": "Kansas St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7496917492204997,
          "win": 0,
          "team": "Kansas St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5665341307230457,
          "win": 0,
          "team": "Kansas St",
          "round": "Final Four"
        },
        {
          "expected": 0.46140158377845375,
          "win": 0,
          "team": "Kansas St",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "UC Irvine", "round": "First Round"},
        {
          "expected": 1.4311735130334569e-9,
          "win": 0,
          "team": "UC Irvine",
          "round": "Second Round"
        },
        {
          "expected": 0.3125,
          "win": 0,
          "team": "UC Irvine",
          "round": "Sweet 16"
        },
        {
          "expected": 0.24999999999991396,
          "win": 0,
          "team": "UC Irvine",
          "round": "Elite Eight"
        },
        {
          "expected": 0.20312498590130262,
          "win": 0,
          "team": "UC Irvine",
          "round": "Final Four"
        },
        {
          "expected": 0.18441619662613581,
          "win": 0,
          "team": "UC Irvine",
          "round": "National Championship"
        },
        {
          "expected": 1.9999999999999565,
          "win": 1,
          "team": "Villanova",
          "round": "First Round"
        },
        {
          "expected": 0.7500001085496076,
          "win": 0,
          "team": "Villanova",
          "round": "Second Round"
        },
        {
          "expected": 0.9323504112549663,
          "win": 0,
          "team": "Villanova",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6253192470221981,
          "win": 0,
          "team": "Villanova",
          "round": "Elite Eight"
        },
        {
          "expected": 0.541501812317809,
          "win": 0,
          "team": "Villanova",
          "round": "Final Four"
        },
        {
          "expected": 0.39938810386995666,
          "win": 0,
          "team": "Villanova",
          "round": "National Championship"
        },
        {
          "expected": 4.3520742565306136e-14,
          "win": 0,
          "team": "St Mary's CA",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Second Round"
        },
        {
          "expected": 0.3125009721974664,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Sweet 16"
        },
        {
          "expected": 0.37500281306168015,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Elite Eight"
        },
        {
          "expected": 0.3000133446752193,
          "win": 0,
          "team": "St Mary's CA",
          "round": "Final Four"
        },
        {
          "expected": 0.2153341428265448,
          "win": 0,
          "team": "St Mary's CA",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Purdue", "round": "First Round"},
        {
          "expected": 1.4999998914503925,
          "win": 1,
          "team": "Purdue",
          "round": "Second Round"
        },
        {
          "expected": 0.9382285394486001,
          "win": 0,
          "team": "Purdue",
          "round": "Sweet 16"
        },
        {
          "expected": 0.8747983981688104,
          "win": 0,
          "team": "Purdue",
          "round": "Elite Eight"
        },
        {
          "expected": 0.670879393336847,
          "win": 0,
          "team": "Purdue",
          "round": "Final Four"
        },
        {
          "expected": 0.5537339047982841,
          "win": 0,
          "team": "Purdue",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Old Dominion",
          "round": "First Round"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Old Dominion",
          "round": "Second Round"
        },
        {
          "expected": 0.3125,
          "win": 0,
          "team": "Old Dominion",
          "round": "Sweet 16"
        },
        {
          "expected": 0.1250000000000937,
          "win": 0,
          "team": "Old Dominion",
          "round": "Elite Eight"
        },
        {
          "expected": 0.15233126387508564,
          "win": 0,
          "team": "Old Dominion",
          "round": "Final Four"
        },
        {
          "expected": 0.12304304092701154,
          "win": 0,
          "team": "Old Dominion",
          "round": "National Championship"
        },
        {
          "expected": 1.999999313709054,
          "win": 1,
          "team": "Cincinnati",
          "round": "First Round"
        },
        {
          "expected": 0.7500000000051856,
          "win": 0,
          "team": "Cincinnati",
          "round": "Second Round"
        },
        {
          "expected": 0.6301495877149157,
          "win": 0,
          "team": "Cincinnati",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6249872301033179,
          "win": 0,
          "team": "Cincinnati",
          "round": "Elite Eight"
        },
        {
          "expected": 0.4711565579059337,
          "win": 0,
          "team": "Cincinnati",
          "round": "Final Four"
        },
        {
          "expected": 0.37207942224446927,
          "win": 0,
          "team": "Cincinnati",
          "round": "National Championship"
        },
        {
          "expected": 6.862909460725319e-7,
          "win": 0,
          "team": "Iowa",
          "round": "First Round"
        },
        {"expected": 0.75, "win": 0, "team": "Iowa", "round": "Second Round"},
        {
          "expected": 0.6249990297861451,
          "win": 0,
          "team": "Iowa",
          "round": "Sweet 16"
        },
        {
          "expected": 0.49379185292521016,
          "win": 0,
          "team": "Iowa",
          "round": "Elite Eight"
        },
        {
          "expected": 0.413197302122496,
          "win": 0,
          "team": "Iowa",
          "round": "Final Four"
        },
        {
          "expected": 0.30931475019191357,
          "win": 0,
          "team": "Iowa",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Tennessee", "round": "First Round"},
        {
          "expected": 1.4999999999948144,
          "win": 1,
          "team": "Tennessee",
          "round": "Second Round"
        },
        {
          "expected": 1.2492714595979062,
          "win": 1,
          "team": "Tennessee",
          "round": "Sweet 16"
        },
        {
          "expected": 0.8752133153413155,
          "win": 0,
          "team": "Tennessee",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7462346890007783,
          "win": 0,
          "team": "Tennessee",
          "round": "Final Four"
        },
        {
          "expected": 0.6002038747506586,
          "win": 0,
          "team": "Tennessee",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Colgate", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "Colgate", "round": "Second Round"},
        {"expected": 0, "win": 0, "team": "Colgate", "round": "Sweet 16"},
        {
          "expected": 0.125,
          "win": 0,
          "team": "Colgate",
          "round": "Elite Eight"
        },
        {
          "expected": 0.10156249928515189,
          "win": 0,
          "team": "Colgate",
          "round": "Final Four"
        },
        {
          "expected": 0.06152702456281376,
          "win": 0,
          "team": "Colgate",
          "round": "National Championship"
        },
        {
          "expected": 2,
          "win": 1,
          "team": "North Carolina",
          "round": "First Round"
        },
        {
          "expected": 1.5,
          "win": 1,
          "team": "North Carolina",
          "round": "Second Round"
        },
        {
          "expected": 1.249998619871535,
          "win": 1,
          "team": "North Carolina",
          "round": "Sweet 16"
        },
        {
          "expected": 0.9970074398065675,
          "win": 1,
          "team": "North Carolina",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7614161381043121,
          "win": 0,
          "team": "North Carolina",
          "round": "Final Four"
        },
        {
          "expected": 0.6197668946596919,
          "win": 0,
          "team": "North Carolina",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Iona", "round": "First Round"},
        {"expected": 0, "win": 0, "team": "Iona", "round": "Second Round"},
        {"expected": 0, "win": 0, "team": "Iona", "round": "Sweet 16"},
        {"expected": 0, "win": 0, "team": "Iona", "round": "Elite Eight"},
        {"expected": 0, "win": 0, "team": "Iona", "round": "Final Four"},
        {
          "expected": 0.011989614945868327,
          "win": 0,
          "team": "Iona",
          "round": "National Championship"
        },
        {
          "expected": 0.23060073289322847,
          "win": 0,
          "team": "Utah St",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Utah St",
          "round": "Second Round"
        },
        {
          "expected": 0.6249985820804927,
          "win": 0,
          "team": "Utah St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.4999935584542259,
          "win": 0,
          "team": "Utah St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.356627316357999,
          "win": 0,
          "team": "Utah St",
          "round": "Final Four"
        },
        {
          "expected": 0.30389756559772557,
          "win": 0,
          "team": "Utah St",
          "round": "National Championship"
        },
        {
          "expected": 1.7693992671067715,
          "win": 1,
          "team": "Washington",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Washington",
          "round": "Second Round"
        },
        {
          "expected": 0.6249997962102455,
          "win": 0,
          "team": "Washington",
          "round": "Sweet 16"
        },
        {
          "expected": 0.49999910460932107,
          "win": 0,
          "team": "Washington",
          "round": "Elite Eight"
        },
        {
          "expected": 0.38821312750937026,
          "win": 0,
          "team": "Washington",
          "round": "Final Four"
        },
        {
          "expected": 0.3118839183879305,
          "win": 0,
          "team": "Washington",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Auburn", "round": "First Round"},
        {
          "expected": 0.7548383575536006,
          "win": 0,
          "team": "Auburn",
          "round": "Second Round"
        },
        {
          "expected": 0.9375000098285169,
          "win": 0,
          "team": "Auburn",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7499793779554028,
          "win": 0,
          "team": "Auburn",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6080209678407819,
          "win": 0,
          "team": "Auburn",
          "round": "Final Four"
        },
        {
          "expected": 0.47746734652159156,
          "win": 0,
          "team": "Auburn",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "New Mexico St",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "New Mexico St",
          "round": "Second Round"
        },
        {
          "expected": 0.312501621711615,
          "win": 0,
          "team": "New Mexico St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.38277836393972076,
          "win": 0,
          "team": "New Mexico St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.26706479155385027,
          "win": 0,
          "team": "New Mexico St",
          "round": "Final Four"
        },
        {
          "expected": 0.20944233004522878,
          "win": 0,
          "team": "New Mexico St",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Kansas", "round": "First Round"},
        {
          "expected": 1.4951616424463994,
          "win": 1,
          "team": "Kansas",
          "round": "Second Round"
        },
        {
          "expected": 0.9375013702975952,
          "win": 0,
          "team": "Kansas",
          "round": "Sweet 16"
        },
        {
          "expected": 0.7515881756494931,
          "win": 0,
          "team": "Kansas",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6599344563255273,
          "win": 0,
          "team": "Kansas",
          "round": "Final Four"
        },
        {
          "expected": 0.5382011612537734,
          "win": 0,
          "team": "Kansas",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Northeastern",
          "round": "First Round"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Northeastern",
          "round": "Second Round"
        },
        {
          "expected": 0.3125,
          "win": 0,
          "team": "Northeastern",
          "round": "Sweet 16"
        },
        {
          "expected": 0.24999999991623992,
          "win": 0,
          "team": "Northeastern",
          "round": "Elite Eight"
        },
        {
          "expected": 0.15234363937551804,
          "win": 0,
          "team": "Northeastern",
          "round": "Final Four"
        },
        {
          "expected": 0.12321096650041409,
          "win": 0,
          "team": "Northeastern",
          "round": "National Championship"
        },
        {
          "expected": 1.999999999996355,
          "win": 1,
          "team": "Iowa St",
          "round": "First Round"
        },
        {
          "expected": 0.7500000020029298,
          "win": 0,
          "team": "Iowa St",
          "round": "Second Round"
        },
        {
          "expected": 0.6544674468281625,
          "win": 0,
          "team": "Iowa St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6250033080017171,
          "win": 0,
          "team": "Iowa St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.49779210574170796,
          "win": 0,
          "team": "Iowa St",
          "round": "Final Four"
        },
        {
          "expected": 0.3762099824870882,
          "win": 0,
          "team": "Iowa St",
          "round": "National Championship"
        },
        {
          "expected": 3.645084234449314e-12,
          "win": 0,
          "team": "Ohio St",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Ohio St",
          "round": "Second Round"
        },
        {
          "expected": 0.624672316351273,
          "win": 0,
          "team": "Ohio St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.36575673926383745,
          "win": 0,
          "team": "Ohio St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.2959805942202408,
          "win": 0,
          "team": "Ohio St",
          "round": "Final Four"
        },
        {
          "expected": 0.23027221818979832,
          "win": 0,
          "team": "Ohio St",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Houston", "round": "First Round"},
        {
          "expected": 1.4999999979970702,
          "win": 1,
          "team": "Houston",
          "round": "Second Round"
        },
        {
          "expected": 0.9411064557764686,
          "win": 0,
          "team": "Houston",
          "round": "Sweet 16"
        },
        {
          "expected": 0.8734597195186675,
          "win": 0,
          "team": "Houston",
          "round": "Elite Eight"
        },
        {
          "expected": 0.6989558752322662,
          "win": 0,
          "team": "Houston",
          "round": "Final Four"
        },
        {
          "expected": 0.5558370676861161,
          "win": 0,
          "team": "Houston",
          "round": "National Championship"
        },
        {"expected": 0, "win": 0, "team": "Georgia St", "round": "First Round"},
        {
          "expected": 0,
          "win": 0,
          "team": "Georgia St",
          "round": "Second Round"
        },
        {
          "expected": 0.3125,
          "win": 0,
          "team": "Georgia St",
          "round": "Sweet 16"
        },
        {
          "expected": 0.12500000008376008,
          "win": 0,
          "team": "Georgia St",
          "round": "Elite Eight"
        },
        {
          "expected": 0.10157511084870109,
          "win": 0,
          "team": "Georgia St",
          "round": "Final Four"
        },
        {
          "expected": 0.11470400391441242,
          "win": 0,
          "team": "Georgia St",
          "round": "National Championship"
        },
        {
          "expected": 1.9999999999999996,
          "win": 1,
          "team": "Wofford",
          "round": "First Round"
        },
        {
          "expected": 0.7500000002248419,
          "win": 0,
          "team": "Wofford",
          "round": "Second Round"
        },
        {
          "expected": 0.908032560442895,
          "win": 0,
          "team": "Wofford",
          "round": "Sweet 16"
        },
        {
          "expected": 0.6250290466098614,
          "win": 0,
          "team": "Wofford",
          "round": "Elite Eight"
        },
        {
          "expected": 0.5208888642791808,
          "win": 0,
          "team": "Wofford",
          "round": "Final Four"
        },
        {
          "expected": 0.3922188962529207,
          "win": 0,
          "team": "Wofford",
          "round": "National Championship"
        },
        {
          "expected": 4.440892098500626e-16,
          "win": 0,
          "team": "Seton Hall",
          "round": "First Round"
        },
        {
          "expected": 0.75,
          "win": 0,
          "team": "Seton Hall",
          "round": "Second Round"
        },
        {
          "expected": 0.3128276836487931,
          "win": 0,
          "team": "Seton Hall",
          "round": "Sweet 16"
        },
        {
          "expected": 0.25147226931036726,
          "win": 0,
          "team": "Seton Hall",
          "round": "Elite Eight"
        },
        {
          "expected": 0.25384724800163,
          "win": 0,
          "team": "Seton Hall",
          "round": "Final Four"
        },
        {
          "expected": 0.1907812505461023,
          "win": 0,
          "team": "Seton Hall",
          "round": "National Championship"
        },
        {"expected": 2, "win": 1, "team": "Kentucky", "round": "First Round"},
        {
          "expected": 1.499999999775158,
          "win": 1,
          "team": "Kentucky",
          "round": "Second Round"
        },
        {
          "expected": 1.246393536952408,
          "win": 1,
          "team": "Kentucky",
          "round": "Sweet 16"
        },
        {
          "expected": 0.877932896880818,
          "win": 0,
          "team": "Kentucky",
          "round": "Elite Eight"
        },
        {
          "expected": 0.7280007197187881,
          "win": 0,
          "team": "Kentucky",
          "round": "Final Four"
        },
        {
          "expected": 0.59485774286466,
          "win": 0,
          "team": "Kentucky",
          "round": "National Championship"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Abilene Chr",
          "round": "First Round"
        },
        {
          "expected": 0,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Second Round"
        },
        {"expected": 0, "win": 0, "team": "Abilene Chr", "round": "Sweet 16"},
        {
          "expected": 0.125,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Elite Eight"
        },
        {
          "expected": 0.050781250714819016,
          "win": 0,
          "team": "Abilene Chr",
          "round": "Final Four"
        },
        {
          "expected": 0.061523437468487256,
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
}
// Embed the visualization in the container with id `vis`
vegaEmbed("#vis", vlSpec,
          {"actions": false, "hover": false});
</script>
