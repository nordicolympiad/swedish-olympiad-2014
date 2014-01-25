#!/usr/bin/env python

import sys

if "sample" in sys.argv:
  for line in sys.stdin.readlines():
    verdict, score = line.split()
    if verdict != "AC":
      print verdict, 0
      exit()
  print "AC 0"
else:
  total_score = 0
  wa = 0
  tle = 0
  rte = 0
  for line in sys.stdin.readlines():
    verdict, score = line.split()
    if verdict == "WA":
      wa += 1
    elif verdict == "TLE":
      tle += 1
    elif verdict == "RTE":
      rte += 1
    total_score += float(score)
  if total_score:
    score = int(total_score)
    if score < 25:
        score = 0
    elif 25 <= score < 50:
        score = 10*(score - 25)/25
    elif 50 <= score < 90:
        score = 10 + 90*(score - 50)/40
    else:
        score = 100
    print "AC", score
  else:
    if rte:
      print "RTE 0"
    elif tle:
      print "TLE 0"
    else:
      print "WA 0"
