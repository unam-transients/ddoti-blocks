#!/bin/sh

blocks="BLOCKS-alerts"

rm -f $blocks
rm -f 1000-*

if test "$1" = "clean"
then
  exit
fi

echo >$blocks "# This file is automatically generated."
echo >>$blocks "unload * * 1000-*"

expand ALERTS |
sed '
  s/#.*//
  s/  *$//
  s/^  *//
  /^$/d
' |
while read priority precedence repeats name blockidentifier visitidentifier alpha delta
do
  cat <<EOF >1000-$name-$visitidentifier.json
// This file is automatically generated.
{
  "project": {
    "identifier": "1000",
    "name": "GW Alerts"
  },
  "identifier": "$blockidentifier",
  "name": "$name pointing $visitidentifier",
  "priority": "$priority",
  "visits": [
    {
      "identifier": "1000",
      "name": "focusing",
      "targetcoordinates": {
        "type": "equatorial",
        "alpha": "$alpha",
        "delta": "$delta",
        "equinox": "2000"
      },
      "command": "focusvisit",
      "estimatedduration": "1m"
    },
    {
      "identifier": "1000",
      "name": "correcting pointing",
      "targetcoordinates": {
        "type": "equatorial",
        "alpha": "$alpha",
        "delta": "$delta",
        "equinox": "2000"
      },
      "command": "correctpointingvisit",
      "estimatedduration": "1m"
    },
    {
      "identifier": "$visitidentifier",
      "name": "science",
      "targetcoordinates": {
        "type": "equatorial",
        "alpha": "$alpha",
        "delta": "$delta",
        "equinox": "2000"
      },
      "command": "gridvisit 2 9 1 60",
      "estimatedduration": "24m"
    }
  ],
  "constraints": {
    "maxskybrightness": "nauticaltwilight",
    "maxzenithdistance": "72d",
    "minmoondistance": "5d"
  },
  "persistent": "false"
}
EOF
  echo >>$blocks "load $precedence $repeats 1000-$name-$visitidentifier"
done 
