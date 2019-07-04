---
title: "Buble Pi"
date: 2019-07-03T07:42:36-04:00
draft: false
---

[Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)s at
[Micro Center](https://www.microcenter.com/) are $5. That's bonkers!

Two weeks ago my friend introduced me to Micro Center. This has been
both eye-opening and wallet-emptying. I now own several Raspberry Pi
Zero W computers. I plan to use them reinvigorate the Churby project,
among other things. As a warm-up, I managed to start (and complete!)
a _side-project_ to put a [Spotify
Connect](https://www.spotify.com/us/connect/) client in my
bedroom. Meet **buble**:

{{<img buble_front>}}a Raspberry Pi Zero W{{</img>}}
{{<img buble_back>}}a PCM5102 I2S Board{{</img>}}

It still looks like Frankenstein's project, but it works well and so
far has been rock solid. I might 3D print an enclosure for it at some
point.


This project was still a fair bit outside of my comfort zone. The
whole thing is enabled by
[librespot](https://github.com/librespot-org/librespot), a
reverse-engineered implementation of the Spotify Connect client
protocol. Librespot is incredibly easy to get started with - you clone
the project, run the build commands from the README, and that's
it. There are two areas where this got tricky: connecting audio
hardware to the Zero W, and getting librespot to work with Alpine
Linux on the Zero W.

## I2S audio on the Zero W ##

A while ago I purchased a cheap PCM5102 I2S Digital to Analog
Converter module off of Amazon. They're probably even cheaper on
Ebay. This project was a good opportunity to put it to use - the
Raspberry Pi Zero W doesn't have a 3.5mm jack that can be used for
audio. It also just-so-happens that these boards use the same hardware
as the first version of the [Hifiberry](https://www.hifiberry.com), an
audio board for Raspberry Pis. Since device tree overlay support for
that board has been included in the Raspberry Pi kernel for some time,
the main impediment to using the board is connecting it, then changing
a couple of lines in the `config.txt` file. No real software trickery.

There are
[several](https://sorokin.engineer/posts/en/dac_raspberry_pi_pcm5102.html)
[guides](https://blog.sengotta.net/connecting-a-pcm5102a-breakout-board-to-a-raspberry-pi/)
that talk about how to connect the Pi and the breakout board. If you
have no idea what I2S is (like me), the key is to recognize is that
not all of the pins on the breakout need to be connected to the Pi -
several of them must be connected to ground.

The community around Raspberry Pi products is their most compelling
feature. For example, the breakout board I used is connected very
similarly to [this audio
board](https://pinout.xyz/pinout/raspiaudio_audio), with just one
extra pin. The [pinout](https://pinout.xyz) site is a fantastic
resource.

Here is a simple schematic of how the two boards are connected. Image
credit for the Raspberry Pi pinout to https://pinout.xyz.

{{<img buble_schematic>}}a wiring diagram{{</img>}}

The only other thing needed to enable to board is to set the following
flags in the `config.txt` file, or wherever the Raspberry Pi firmware
looks for parameters:

```
dtparam=i2s=on

# MAKE SURE THIS IS COMMENTED, NOT ENABLED
# Enable audio (loads snd_bcm2835)
#dtparam=audio=on

# Enable hardware watchdog
dtparam=watchdog=on

dtoverlay=hifiberry-dac
```

The process to enable this audio board was likely a lot more
complicated before support for this I2S DAC was upstreamed. Most of
the time I spent was just hunting down how to connect the thing
correctly.

## getting librespot onto Alpine Linux ##

If you wanted to use
[Raspbian](https://www.raspberrypi.org/downloads/raspbian/), the
[Debian](https://www.debian.org/) derivative operating system
distributed by the Raspberry Pi Foundation, you're pretty much good to
go. You connect and enable the board, then follow the instructions to build and run librespot on the device.

But why stop there? I've had issues with Raspberry Pis over the years
chewing through SD cards - I tend to treat the Pis as appliances that
I can unplug at will which has this small side effect of corrupting
the file system. Putting lots of write cycles on the SD card, due to
checking out and compiling software, is probably not great either. The
same friend who introduced me to Micro Center suggested looking into
[Alpine Linux](https://www.alpinelinux.org/).

Alpine is pretty cool. It's small and runs entirely in RAM. Thanks to
Raspberry Pi's ubiquity, the project distributes a version built
specifically for the Pi. I had previously encountered Alpine when
working with [Docker](https://www.docker.com/). It's a great choice
for an operating system that mostly stays out of the way.

There's just one caveat. Alpine does not use
[glibc](https://www.gnu.org/software/libc/). It uses something called
[musl](https://www.musl-libc.org/) instead.

For the layperson-who-knows-just-enough-to-be-dangerous, installing
packages on GNU/Linux distributions seems like magic. You learn a
couple of commands to type in at the shell and you're given a
searchable list of packages to install, delete, or upgrade. Even if
you're compiling software from source, chances are the instructions
will tell you exactly what packages you need to install beforehand,
and will be something along the lines of "run `./configure && make &&
make install`". Congratulations, welcome to the world of
[hackers](https://media.giphy.com/media/FnGJfc18tDDHy/giphy.gif) (I
fall into this camp myself!)

But what if the software (librespot) you want to build requires
packages ([rustc, cargo](https://www.rust-lang.org/)) that aren't in
the list of packages available to your operating system (Alpine)?
Worse, what if the packages and software you need can't be compiled in
a straightforward manner on the device you want to run them on because
it doesn't have enough RAM and horsepower to get the job done?

Time to wade into the world of cross-compiling...

A big disclaimer up front: I probably did much of this the "wrong
way". I have no prior experience with Rust, musl, or Alpine, and I
have the faintest glimmer of exposure to gcc and make.

But these steps worked!

### building an ARM cross-compiler for muslc ###

Fortunately, this isn't the first time folk to want to build a
cross-compiler targeting the Raspberry Pi running Alpine Linux. Whew!
Building a cross-compiler was absurdly easy (after figuring out the
right configuration settings) using
[musl-cross-make](https://github.com/richfelker/musl-cross-make).

After checking out the project from GitHub, I copied the example and
enabled the relevant settings in `config.mak`.


```
TARGET = arm-linux-musleabihf

BINUTILS_VER = 2.32
GCC_VER = 8.3.0
MUSL_VER = 1.1.22
GMP_VER = 6.1.2 
MPC_VER = 1.1.0
MPFR_VER = 3.1.5
ISL_VER = 0.18
LINUX_VER = 4.19.36

GCC_CONFIG += --with-arch=armv6 --with-float=hard --with-fpu=vfpv2

```

I got these version numbers searching for the
[packages](https://pkgs.alpinelinux.org/packages?name=*linux-headers*&branch=v3.10)
that are distributed with the version of Alpine I've installed on the
Pi, 3.10. Older versions of these libraries will be automatically
downloaded by musl-cross-make, but instead of looking for the hashes
and trying to do it the "right way", I just downloaded the versions I
wanted to the `sources` folder following the process that the Makefile
takes (i.e. looking for relevant URLs in the `Makefile`, navigating
there in my browser, and downloading the version corresponding to
what's distributed in my version of Alpine.)

Then to build a cross-compiler toolchain targeting ARM and musl, run
`make` and `make install`
[#hackers](https://media.giphy.com/media/26tPnAAJxXTvpLwJy/giphy.gif).

This dumps the cross-compiler into the
`build/local/arm-linux-musleabihf/output` directory. All is
well. However, the next step needs to not only to cross-compile source
code, but also link it against libraries installed on the Pi. So I had
to grab `alsa-lib` and `alsa-lib-dev` from the Alpine package
repository (the relevant packages are shown
[here](https://pkgs.alpinelinux.org/packages?name=*alsa-lib*&branch=v3.10&arch=armhf)),
and the
[`musl`](https://pkgs.alpinelinux.org/packages?name=*musl*&branch=v3.10&arch=armhf)
package that these depend on. After finding an Alpine package mirror
and downloading these three libraries, I extracted all of them to the
`build/local/arm-linux-musleabihf/output` directory (I extracted the
shared object libraries from the `musl` package directly to the
`build/local/arm-linux-musleabihf/output/usr/lib` folder so that all
relevant libraries would be in the right spot. Again, not doing things
the "right way".)

To avoid an error in the next step about a missing `libc`, I put a
symlink called `libc.so` pointing at the musl library. Specifically, I
ran `ln -s libc.musl-armhf.so.1 libc.so` in the
`build/local/arm-linux-musleabihf/output/usr/lib` folder.

### building Rust for ARM and musl###

There are some pretty helpful instructions
[here](https://github.com/japaric/rust-cross) that I found useful to
get my bearings. Again, thanks to this being a solved problem, Rust
already has a target for cross-compiling binaries targeting ARM and
musl (from
[here](https://github.com/rust-lang/rust/tree/1.35.0/src/librustc_target/spec)). The
last step already built the cross-compiler toolchain that will be used
to link everything at the end. So I installed
[rustup](https://rustup.rs/) and added it and the cross-compiler
toolchain from the last step to my PATH.


```
curl https://sh.rustup.rs -sSf | sh
source ~/.cargo/env
rustup target add arm-unknown-linux-musleabihf
export PATH=~/musl-cross-make/build/local/arm-linux-musleabihf/output/bin:~/.cargo/bin:$PATH
```

To enable cross-compiling, I added the following to my
`~/.cargo/config` file:

```
[target.arm-unknown-linux-musleabihf]
linker = "arm-linux-musleabihf-gcc"
```

Now to build librespot! At the time of writing, the
[ALSA](https://alsa-project.org/) Rust bindings used in librespot
wouldn't compile for ARM, so I had to bump the version. Specifically,
I needed to change alsa version in `playback/Cargo.toml` from 0.2.1 to
0.2.2.

I also ran into a strange error where the built binaries wouldn't
actually run on the Pi. Most frustrating. After stumbling upon
https://github.com/librespot-org/librespot/issues/328 I added the
`-crt-static` flag mentioned to the build command and was good to go.

From the `librespot` root directory, I ran (substituting the
appropriate path for the `musl-cross-make` directory):

```
RUSTFLAGS='-L <PATH_TO_CROSS_COMPILER>/musl-cross-make/build/local/arm-linux-musleabihf/output/usr/lib -L <PATH_TO_CROSS_COMPILER>/musl-cross-make/build/local/arm-linux-musleabihf/output/arm-linux-musleabihf/lib -C target-feature=-crt-static' PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --target=arm-unknown-linux-musleabihf --no-default-features --features "alsa-backend"
```

The resulting binary is in created at
`target/arm-unknown-linux-musleabihf/release/librespot`. It's not a
static binary, so I needed to install `alsa-lib` and `libgcc` on the
Pi.

### setting up librespot as a service ###

I sent the binary to the Pi via SFTP and put it on the SD card to
persist between reboots (to do this, I remounted the SD card
filesystem using `mount /dev/mmcblk0p1 -o rw,remount`). The last step
(after testing the binary to make sure it worked!) was to create an
[initscript](https://wiki.alpinelinux.org/wiki/Writing_Init_Scripts)
to set up the Pi to run librespot on startup. I ran into a different
[helpfile](https://github.com/OpenRC/openrc/blob/master/supervise-daemon-guide.md)
showing how to manage a process that runs in the foreground, so my
initscript (`/etc/init.d/librespot`) looks like:

```
#!/sbin/openrc-run

supervisor=supervise-daemon

command="/media/mmcblk0p1/librespot"
command_args="-n "buble" -b 320 --enable-volume-normalisation --initial-volume 50"

depend() {
  need networking
}

```

I ran `rc-update add librespot default` to enable running the service
at boot, then `lbu include /etc/init.d/librespot` and `lbu_commit -d`
to make sure the initscript and changes would persist.

That's it! Lots of hours but I have a slightly stronger grasp of
cross-compiling and how to make better use of the Raspberry Pi Zero W
as a headless appliance.
