#!/bin/bash
# Author: Rob Trew, https://github.com/RobTrew/txtquery-tools
# Ver: 0.2
# Gets emoji clockface (stdout|clipboard) with specified time (to nearest preceding half hour)
# Call at command line with *on or two* integer parameters ($1 for hours, $2 for minutes)
# e.g. chmod +x emotime.sh; emotime.sh 16 30

# As this is a lossy representation, and optimism can prove double-edged, it operates in two modes:
# Specified time: (to nearest *preceding* half hour) (don't show appointments as later than they are)
# System time: (to nearest *following* half hour) (don't overstate how much sand remains in the glass)

HRS=$1; MINS=$2
ERRFORWARD=false #(if current time err forward, if scheduling, err earlier)
if [[ -z $HRS ]]; then HRS=$(date +"%I"); ERRFORWARD=true; fi
if [[ -z $MINS ]]; then MINS=$(date +"%M"); ERRFORWARD=true; fi
JSC="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
EMOTIME=$("$JSC" -e "
function emoTime(dteJS) {
	var lngBase=0x1F54F, lngHour=(dteJS.getHours() % 12), lngMins=dteJS.getMinutes(),
		iHourCode, iFullCode;
	if (lngHour) iHourCode=lngBase+lngHour; else iHourCode=lngBase+12;

	// Note: any second offset of 12 takes us to the block of corresponding half hour icons
	if ($ERRFORWARD) {
		if (lngMins >= 45) { // move on at quarter to and quarter past
			iFullCode=iHourCode+1;
		} else if (lngMins >= 15) {
			iFullCode=iHourCode+12; // jump to matching half hour glyph
		} else iFullCode=iHourCode;
	} else {
		// only move on at the full half hour
		if (lngMins >= 30) iFullCode=iHourCode+12; else iFullCode=iHourCode;
	}
	return asUnicode(iFullCode);
}
function asUnicode(c) {
	var lngClear = c - 0x10000;
	return String.fromCharCode( (lngClear >> 10) + 0xD800) +
		String.fromCharCode( (lngClear & 0x3FF) + 0xDC00);
}
dteJS = new Date(); dteJS.setHours($HRS, $MINS);
print(emoTime(dteJS));")
echo "$EMOTIME"
echo "$EMOTIME" | pbcopy
