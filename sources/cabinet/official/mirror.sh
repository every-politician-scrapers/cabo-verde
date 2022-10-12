#!/bin/bash

cd $(dirname $0)
rm -rf mirror
mkdir -p mirror

CURLOPTS='-L -c /tmp/cookies -A eps/1.2'

curl $CURLOPTS -o mirror/pm.html https://www.governo.cv/governo/primeiro-ministro/

for url in $(nokogiri -e "puts @doc.css('#menu-interno a[@href=\"https://www.governo.cv/governo/ministerios/\"] + ul li a/@href').map(&:text)" mirror/pm.html); do
  outhtml="mirror/$(basename $url).html"
  echo "$url -> $outhtml"
  curl $CURLOPTS -o $outhtml $url
done

cd ~-
