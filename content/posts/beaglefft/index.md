---
title: "FFTW on the beagle"
date: 2018-08-11T14:09:00-04:00
slug: beagle-fftw
draft: true
status: "another stab at radio"
---

I've had my [Beaglebone Black](https://beagleboard.org/black) hooked
up to an [RTL-SDR](https://osmocom.org/projects/rtl-sdr/wiki/Rtl-sdr)
dongle for some time now -- a couple of years ago, I had posted about
running `rtl_power` on the board to capture local spectrum.

I'm trying to learn a bit of [Julia](https://julialang.org/) at home
and saw that it can interface with
[FFTW](http://www.fftw.org). There's also a build for ARM devices! I
thought it might be fun to see how far I could get implementing a
FFTW-based spectrum analyzer in Julia (and of course someone has
already paved the way, at least with using FFTW within `rtl_power`,
see [here](https://github.com/AD-Vega/rtl-power-fftw)...)

Getting FFTW to compile on the Beagle wasn't as straightforward as I
hoped, and I went down a few ratholes. The version in the Debian
repository is slightly out of date, and when compiling the source I
found out that some extra steps are needed to enable a cycle counter,
including needing to set some register value in kernel space! That's
pretty daunting and well out of my wheelhouse, but fortunately there's
already a working kernel module on
[GitHub](https://github.com/thoughtpolice/enable_arm_pmu). I compiled
the module and verified that it passed the included tests (whew!) then
put the contents of the load script into `rc.local` to always load it
on boot. But when I compiled FFTW to use this method
(`--enable-armv7a-pmccntr`) it would just hang. Hunting around, I
found [a previous FFTW fork aimed at
ARM](http://www.vesperix.com/arm/fftw-arm/source/index.html) which
suggested that just using the `--with-slow-timer` option is 'good
enough'.

The final FFTW configure options I ended up using were:

```
./configure --enable-single --enable-neon --enable-shared --with-slow-timer --enable-threads --with-combined-threads
```

Oh, and I needed to build the double precision version as well. That's
nearly the same configure command, and another make cycle (unless
there's a way to do it all in one shot, I was burning more time on
this step than I originally expected to):

```
./configure --enable-shared --with-slow-timer --enable-threads --with-combined-threads
```

**NOTE:** you don't need to do this at all since Julia's
[FFTW.jl](https://github.com/JuliaMath/FFTW.jl) will automatically
grab built binaries (and on ARM, they seem to have been created with
the same (or nearly the same) flags as above. I just stubbornly wanted
to use my built versions after spending a bunch of time trying to make
them in the first place!

Fortunately things started to pick up from here. Julia's `ccall`
ability is pretty nifty:

```
julia> ccall((:rtlsdr_get_device_count, :librtlsdr), Int32, ())
1

julia> unsafe_string(ccall((:rtlsdr_get_device_name, :librtlsdr), Cstring, (Int32,), 0))
"Generic RTL2832U OEM"

```

Let's see if we can get some data out of the RTL-SDR.

