#!/bin/bash
Date1=$1
Date2=$2
D1= date -d "$Date1" +'%Y-%m-%d'
D2= date -d "$Date2" +'%Y-%m-%d'
((D3=$D2-$D1))
echo $D3
