#!/bin/bash
# reencodes mp3 using tags from the file
# requires id3info, mpg321, lame

# handle no inputs
if [ "$#" = "0" ]; then
    echo "Usage: `basename $0` {mp3 file}";
	E_BADARGS=65
    exit $E_BADARGS
fi


#enable/disable debug mode
debug=1
echo "Debug mode: $debug"
if [ "$debug" = "1" ]; then
    echo "debug mode on "
fi

#get file details
echo "Working on: $@";





echo -n "Artist: "
read Artist
echo -n "Title: "
read Title

mp3Filename=${Artist}" - "${Title}".mp3"
echo "filename string: $mp3Filename";

set -x
#convert mp3 to wav
mpg321 "$@" --wav temp.wav

#lameString+=--replay-gain-accurate
#convert wav to mp3
lame -v --ta "$Artist" --tt "$Title" --replaygain-fast temp.wav "$mp3Filename"
set +x

#clean up
rm temp.wav
mkdir converted
mv "$@" converted/

echo "done"


