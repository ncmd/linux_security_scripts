#!/bin/bash
cat GeneratedLinks.csv | while read link ; do wget --no-check-certificate --connect-timeout=7 --limit-rate=800k $link ; done

