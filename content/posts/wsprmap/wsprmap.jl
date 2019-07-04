## Daven Amin
## 10/13/18
## exploration of localizing WSPR reports in julia

using TranscodingStreams, CodecZlib

function maidenhead_ll(maiden)
    ## https://en.wikipedia.org/wiki/Maidenhead_Locator_System

    ## work in ASCII
    ascii_maiden = Base.Unicode.uppercase(ascii(strip(maiden)))

    lon = (ascii_maiden[1] - 'A')*20 - 180
    lat = (ascii_maiden[2] - 'A')*10 - 90

    lon = lon + (parse(Int64,ascii_maiden[3]))*2
    lat = lat + (parse(Int64,ascii_maiden[4]))

    if (length(ascii_maiden) >= 6)
        lon = lon + (((ascii_maiden[5] - 'A')*5)/60)
        lat = lat + (((ascii_maiden[6] - 'A')*2.5)/60)
    end
    return (lon, lat)
end


## let's get the list of unique callsigns reporting records
data = Dict{Tuple{String,String,Float64,String},
            Tuple{Float64,Float64,Int64}}()
headernames = ["id","time","rcallsign","rgrid","snr","freq",
               "tcallsign","tgrid","power","drift","distance",
               "azimuth","band","version","code"]
floc = "/home/daven/Downloads/wsprspots-2018-09.csv.gz"

open(GzipDecompressorStream, floc) do stream
    for line in eachline(stream)
        row = Dict(zip(headernames, split(line, ",")))
        key = (row["rcallsign"],
               row["tcallsign"],
               round(parse(Float64,row["freq"]),digits=3),
               row["rgrid"],)
        ## compute running mean and variance of SNR using welford's algorithm
        (prevmean, prevvar, prevcount) = get(data, key, (0,0,0))
        snr = parse(Float64,row["snr"])
        newcount = prevcount + 1
        newmean = prevmean + ((snr - prevmean)/newcount)
        newvar = prevvar + (newcount > 1 ?
                            ((snr - prevmean)^2)/newcount - prevvar/prevcount :
                            0)
        data[key] = (newmean,
                     newvar,
                     newcount)
    end
end


## go through data and get the counts for tcallsigns
tcallcounts = Dict{String, Int64}()
for (dinfo, dvalues) in data
    tcallcounts[dinfo[2]] = get(tcallcounts,dinfo[2],0) + 1
end

## try to crunch the first one
selected_tcall = first(collect(keys(tcallcounts))[
    sortperm(collect(values(tcallcounts)),
             rev=true)])

crunch = Vector{Tuple{Tuple{Float64,Float64},Float64}}()

sdata = filter(((r,t,f,g),(m,v,c)) -> t == selected_tcall, data)

for (dinfo, dvalues) in sdata
    (rcall, tcall, freq, rgrid) = dinfo
    (snrmean, snrvar, snrcount) = dvalues
    push!(crunch, (maidenhead_ll(rgrid),snrmean))
end    
