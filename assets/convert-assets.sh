#!/bin/sh

SVGTOPNG=../../metamodule-plugin-sdk/scripts/SvgToPng.py
RES=../monome-rack/res

PANELFILES="$RES/ansible.svg $RES/teletype.svg \
    $RES/whitewhale.svg $RES/earthsea.svg $RES/meadowphysics.svg \
    $RES/grid-375.svg $RES/grid-735.svg"

SIFAMFILES="$RES/SifamTPN111-blackstripe.svg $RES/SifamTPN111-gray-fg.svg \
    $RES/SifamTPN111.svg $RES/SifamTPN111-bg-nogradient.svg"

for F in $PANELFILES; do
    echo Converting $F
    $SVGTOPNG --input $F --output . --height 240
done

for F in $SIFAMFILES; do
    echo Converting $F
    $SVGTOPNG --input $F --output . --height 25
done

echo Compositing knob PNGs...

gm composite SifamTPN111.png SifamTPN111-bg-nogradient.png _temp1.png
gm composite SifamTPN111-gray-fg.png _temp1.png _temp2.png
gm composite SifamTPN111-blackstripe.png _temp2.png final.png

rm Sifam*.png
rm _temp*.png
mv final.png SifamTPN111.png
