#!/bin/sh

rm -f 0004-initial-focus-*.json
rm -f 0004-focus-*.json
rm -f 0009-full-focus-*.json

if test "$1" = "clean"
then
  exit
fi

while read blockid alpha delta
do

  suffix=$(printf '%02d' $blockid)

  cat <<EOF >0004-initial-focus-$suffix.json
{
  "project": {
    "identifier": "0004",
    "name": "focusing"
  },
  "identifier": "$blockid",
  "name": "initial focusing and pointing correction",
  "visits": [
    {
      "identifier": "1000",
      "name": "initial focusing near $alpha $delta",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "initialfocusvisit",
      "estimatedduration": "10m"
    }
  ],
  "constraints": {
    "maxskybrightness": "nauticaltwilight",
    "minha": "-2h",
    "maxha": "+2h",
    "minmoondistance": "30d",
    "minfocusdelay": "3600"
  },
  "persistent": "true"
}
EOF

  cat <<EOF >0004-initial-full-focus-$suffix.json
{
  "project": {
    "identifier": "0004",
    "name": "focusing"
  },
  "identifier": "$blockid",
  "name": "initial full focusing",
  "visits": [
    {
      "identifier": "1000",
      "name": "initial focusing near $alpha $delta",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "initialfocusvisit",
      "estimatedduration": "10m"
    },
    {
      "identifier": "1002",
      "name": "initial focusing near $alpha $delta",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "fullfocusvisit 1000 4",
      "estimatedduration": "10m"
    }
  ],
  "constraints": {
    "maxskybrightness": "nauticaltwilight",
    "minha": "-2h",
    "maxha": "+2h",
    "minmoondistance": "30d",
    "minfocusdelay": "3600"
  },
  "persistent": "true"
}
EOF

  cat <<EOF >0004-focus-$suffix.json
{
  "project": {
    "identifier": "0004",
    "name": "focusing"
  },
  "identifier": "$blockid",
  "name": "focusing",
  "visits": [
    {
      "identifier": "1001",
      "name": "focusing near $alpha $delta",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "focusvisit",
      "estimatedduration": "10m"
    }
  ],
  "constraints": {
    "maxskybrightness": "nauticaltwilight",
    "minha": "-2h",
    "maxha": "+2h",
    "minmoondistance": "30d",
    "minfocusdelay": "1800"
  },
  "persistent": "true"
}
EOF

  cat <<EOF >0004-full-focus-$suffix.json
{
  "project": {
    "identifier": "0004",
    "name": "focusing"
  },
  "identifier": "$blockid",
  "name": "focusing",
  "visits": [
    {
      "identifier": "1001",
      "name": "focusing near $alpha $delta",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "focusvisit",
      "estimatedduration": "10m"
    },
    {
      "name": "full focus near $alpha $delta",
      "identifier": "1002",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "fullfocusvisit 1000 4",
      "estimatedduration": "10m"
    }
  ],
  "constraints": {
    "maxskybrightness": "nauticaltwilight",
    "minha": "-2h",
    "maxha": "+2h",
    "minmoondistance": "30d",
    "minfocusdelay": "1200"
  },
  "persistent": "true"
}
EOF

done <<EOF
0  00h +45d
1  01h +45d
2  02h +45d
3  03h +45d
4  04h +45d
5  05h +45d
6  06h +45d
7  07h +45d
8  08h +45d
9  09h +45d
10 10h +45d
11 11h +45d
12 12h +45d
13 13h +45d
14 14h +45d
15 15h +45d
16 16h +45d
17 17h +45d
18 18h +45d
19 19h +45d
20 20h +45d
21 21h +45d
22 22h +45d
23 23h +45d
EOF
