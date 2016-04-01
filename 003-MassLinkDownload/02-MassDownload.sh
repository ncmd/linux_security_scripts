#!/bin/bash
# Read GeneratedLinks.csv file
# Do a whole loop while reading each line in the file
cat GeneratedLinks.csv | while read link
# While reading each line, use wget to download each link, if the link is HTTPS, ignore certificate and download
# If the connection timeout is 7 seconds, stop
# Limit download rate of each download to 800kbps
do wget --no-check-certificate --connect-timeout=7 --limit-rate=800k $link
done

