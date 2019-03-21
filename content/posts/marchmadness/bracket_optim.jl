## Daven Amin
## 1/25/2019
## first cut at Flux, JuMP script to optimize bracket predictions

## we want to fit a penalized logistic regression model
## to predict match scores using team rankings as predictors


###########################################################################
## fit a PCA to create rank predictors

using DataFrames, CSV
using MultivariateStats, StatsModels

#rdatapath = "massey/ratings_012619.txt"
#rdata = CSV.File(rdatapath, normalizenames=true, delim='\t',
#                 ignorerepeated=true, allowmissing=:auto) |> DataFrame


rdatapath = "massey/ratings_031719.csv"
rdata = CSV.File(rdatapath, normalizenames=true, delim=',',
                 ignorerepeated=true, allowmissing=:auto) |> DataFrame

## going to run a PCA, just want the names and rankings, drop the stats
deletecols!(rdata,2:8)                 

## drop columns with missing values
deletecols!(rdata, findall([any(ismissing.(x[2])) for x in eachcol(rdata)]))

## generate the formula with names of rankings
rankingtypes = collect(names(rdata)[2:end])
pcaform = @eval @formula(Team ~ 1+$(rankingtypes...))

## form a model matrix to feed to PCA
modelmatrix = ModelMatrix(ModelFrame(pcaform, rdata))
mm = modelmatrix.m[:,2:end]

## fit the PCA and get the first principal component for each team
combpca = fit(PCA, mm')
combrank = MultivariateStats.transform(combpca, mm')[1, :]

## final output: hash table of team name to covariate
ranklookup = Dict(zip(map(strip, rdata[:Team]), combrank))


###########################################################################
## get scores to fit the penalized regression
using LinearAlgebra
using Flux
using Flux.Tracker
using Flux.Optimise
using Flux: @epochs

sdatapath = "massey/scores_031719.csv"
sdata = CSV.File(sdatapath, normalizenames=true, delim=',',
                 ignorerepeated=true, allowmissing=:auto,
                 header=["days","date","team1","home1","score1",
                         "team2","home2","score2"]) |> DataFrame

tdatapath = "massey/teams_031719.csv"
tdata = CSV.File(tdatapath, normalizenames=true, delim=',',
                 ignorerepeated=true, allowmissing=:auto,
                 header=["teamix","teamname"]) |> DataFrame

tdict = Dict(zip(tdata[:teamix],tdata[:teamname]))

## create a logistic regression model matrix using covariates from prev step
teamcov(x) = ranklookup[replace(strip(tdict[x]), "_"=>" ")]
#map(teamcov, sdata[:team1])
#map(teamresp, zip(sdata[:score1],sdata[:score2]))
rank1 = map(teamcov, sdata[:team1])
rank2 = map(teamcov, sdata[:team2])

## did the higher ranked team win? (data ordered such that rank1 won the game)
Y = (rank1 .> rank2)
## got bit by this AGAIN. reorder X so that first column is always ranked higher.
X = reduce(hcat,(Y[x] ? [rank1[x],rank2[x]] : [rank2[x],rank1[x]] for x in 1:nrow(sdata)))
#X = reduce(vcat,(rank1',rank2'))
#X = reduce(hcat,(ones(length(rank1)),rank1,rank2))

## debugging
##plot(map(x -> haskey(ranklookup, strip(x)), sdata[:Team]))

## penalized logistic regression... in flux
#w1 = param(1)
#w2 = param(1)
#b = param(1)
#W = param(ones(2))
#pred(w::AbstractVector{T},
#     x::AbstractArray{T,2}) where {T} = 1 ./ (1 .+ exp.(-(w' * x')))


logit(x) = 1 / (1+exp(-x))
#W = Dense(2,1,logit)
#loss(x,y) = sum(Flux.binarycrossentropy.(W(x)',y,ϵ=eps()))

W = Dense(2,1)
#loss(x,y) = sum(Flux.logitbinarycrossentropy.(W(x)',y))
loss(x,y) = sum(Flux.logitbinarycrossentropy.(W(x)',y)) + norm(W.W) + norm(W.b)


##loss(x,y) = sum((y' .- pred(W,x)) .^ 2)
#loss(x,y) = Flux.logitcrossentropy(pred(W,x[:,2:3])',y)
opt = ADAM()
##opt = Descent()
##ps = params((w1,w2,b))
ps = params(W)
d = [(X,Y)]

##grads = gradient(loss, W,X,Y) 
grads = gradient(()->loss(X,Y), ps)

#@epochs 100_000 Flux.train!(loss,ps,d,opt)
@epochs 50_000 Flux.train!(loss,ps,d,opt)

## final output: W,
## called like `logit.(W([<rank1>,<rank2>]))[].data`


###########################################################################
## maybe a good idea to stick with a pre-made cross validation routine...
using GLMNet
using Distributions

Ymod = hcat([x ? [0,1] : [1,0] for x in Y]...)'
## grab nfolds from basketballmonster.com, which suggests 82 games per week
cv = glmnetcv(Matrix(X'), Matrix(Ymod), Binomial(); nfolds=div(length(Y),82))

## https://github.com/JuliaStats/GLMNet.jl/issues/5
minloss, index = findmin(cv.meanloss)
lambda_mse = findfirst(cv.meanloss .<= minloss+cv.stdloss[index]...)
## final output: cv,
## called like `logit(GLMNet.predict(cv.path,[<rank1>,<rank2>]')[argmin(cv.meanloss)])`
## or `logit(GLMNet.predict(cv.path,[<rank1>,<rank2>]')[lambda_mse])`

###########################################################################
## we want to get the expected probability of winning per matchup

# make an expected value matrix - N*M, N teams, M rounds
roundvals = [2,3,5,8,13,21]
rounds = length(roundvals)
teams = 2^rounds

roundnames = ["First Round", "Second Round",
              "Sweet 16", "Elite Eight",
              "Final Four", "National Championship"]

##debugging

#teamnames = collect(keys(ranklookup))[1:teams]

#teamordering = sortperm(collect(values(ranklookup)), order=Base.Order.Reverse)
#teamnames = collect(keys(ranklookup))[teamordering][1:teams]

## get the teamnames. these have to be in a specific order.
## the winner of teams 1:32 will play winner of 33:64 for championship,
## winner of 1:16 will play winner of 17:32 for semifinals (etc...)
#teamnames = []
bdatapath = "massey/bracket_031719.csv"
bdata = CSV.File(bdatapath, normalizenames=true, delim=',') |> DataFrame
teamnames = collect(map(strip, bdata[:Team]))

win_probability(team1,team2) = logit(GLMNet.predict(cv.path,
                                                    [team1,team2]')[lambda_mse])
                                                    ##[team1,team2]')[argmin(cv.meanloss)])

expected_probs = zeros(rounds,teams)
calculated_pairs = Set()
for round in 1:rounds
    block_size = 2^round
    blocks = div(teams,block_size)
    ## each team per block plays the equivalent of the previous block size
    ## (so the total rounds is the previous block size squared)
    rounds_per_block = (block_size/2)^2
    for block in 1:blocks
        for i in 1:block_size
            for j in i+1:block_size
                ## for each i,j team pair in this block
                ## check to see if they've played, and if not,
                ## calculate their win probabilities and accumulate
                team_matchup = Pair(i+( (block-1)*block_size),
                                    j+( (block-1)*block_size))
                if !(team_matchup in calculated_pairs)
                    push!(calculated_pairs, team_matchup)
                    team1_score = ranklookup[teamnames[team_matchup.first]]
                    team2_score = ranklookup[teamnames[team_matchup.second]]

                    reverse_teams = team1_score < team2_score

                    team1_prob = reverse_teams ?
                        (1 - win_probability(team2_score,team1_score)) :
                        win_probability(team1_score,team2_score)
                    team2_prob = 1-team1_prob

                    ## normalize with rounds_per_block
                    expected_probs[round,team_matchup.first] += team1_prob/rounds_per_block
                    expected_probs[round,team_matchup.second] += team2_prob/rounds_per_block
                end
            end
        end
    end
end

## now factor in the fibonacci round scoring
expected_pts = roundvals .* expected_probs

###########################################################################
## we have binary decision variables - N*M, N teams, M rounds

using JuMP
using GLPK

model = Model(with_optimizer(GLPK.Optimizer))

#teams = 8
#rounds = Int(log2(teams))

@variable(model, wins[1:rounds,1:teams], Bin)

## teams can't win more than the max rounds
for j in 1:teams
    @constraint(model, sum(wins[1:rounds, j]) <= rounds)
end

## rounds have fixed number of winners
for i in 1:rounds
    @constraint(model, sum(wins[i, 1:teams]) == div(teams, 2^i))
end

## teams that win have to have won in the previous round
for i in 2:rounds
    for j in 1:teams
        @constraint(model, wins[i-1,j] - wins[i,j] >= 0)
    end
end

## only one team can win per matchup
for i in 1:rounds
    println("I: ", i)
    for j in 1:2^i:teams
        end_j = j+(2^i-1)
        println("\t J: [",j,",",end_j,"]")
        @constraint(model, sum(wins[i,j:end_j]) == 1)
    end
end

## objective: maximize bracket points!
@objective(model, Max, sum(wins[i,j]*expected_pts[i,j] for i in 1:rounds for j in 1:teams))

optimize!(model)

## what are the predictions?
termination_status(model)

primal_status(model)
dual_status(model)

objective_value(model)

for j in 1:teams
    println("Team(", j,"): ", teamnames[j])
    for i in 1:rounds
        println("\t round: ", i, " win: ", value(wins[i,j]))
    end
end

using PyPlot
winmatrix = [[value(wins[i,j]) for j in 1:teams] for i in 1:rounds];
fig, (ax1,ax2) = subplots(2,1, sharex=true, sharey=true)
winplot = ax1.imshow(winmatrix, aspect="auto");
winplot.axes.set_xticks(0:teams-1);
winplot.axes.set_xticklabels(teamnames);
winplot.axes.set_yticks(0:rounds-1);
winplot.axes.set_yticklabels(roundnames);
expplot = ax2.imshow(expected_pts, aspect="auto")
plt.setp(ax1.get_xticklabels(), rotation=45, ha="right",
         rotation_mode="anchor");
plt.setp(ax2.get_xticklabels(), rotation=45, ha="right",
         rotation_mode="anchor");

using ROC
testpr = [win_probability(X[:,x]...) for x in 1:length(Y)]
testpr2 = [logit.(W([X[1,x],X[2,x]]))[].data for x in 1:length(Y)]
testroc = roc(testpr, Y)
testroc2 = roc(testpr2, Y)
AUC(testroc)
AUC(testroc2)

plot(testroc.FPR,testroc.TPR,label="glmnetcv")
plot(testroc2.FPR,testroc2.TPR,label="flux")

using VegaLite
## kind of ugly, but i just want the JavaScript
ixs = CartesianIndices(expected_pts)
vdata = DataFrame(
    team=[teamnames[ixs[i][2]] for i in 1:length(ixs)],
    round=[roundnames[ixs[i][1]] for i in 1:length(ixs)],
    expected=[expected_pts[ixs[i]] for i in 1:length(ixs)],
    win=[value(wins[ixs[i]]) for i in 1:length(ixs)],
    probs=[expected_probs[ixs[i]] for i in 1:length(ixs)]
)

@vlplot(
    repeat={
        column=[:win, :expected],
        scale=[:quantize, :quantile],
    }
) + 
    @vlplot(mark=:rect,
       data=vdata,
       transform=[
           {calculate="'probability of winning match: ' + format(100*datum.probs, ',.2f')", as="probstip"}
       ],
        enc={
            y={
                field=:team,
                sort=teamnames
            },
            x={
                field=:round,
                sort=roundnames
            },
            color={
                field={repeat=:column},
                typ=:quantitative,
                scale={
                    typ={repeat=:scale},
                },
                legend={title="Expected Bracket Points"}
            },
            tooltip={
                field=:probstip,
                typ=:ordinal,
            },
        }
            )
