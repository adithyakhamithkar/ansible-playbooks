#!/usr/bin/env python
#imports
import grp

#variables
groups = grp.getgrall()
for group in groups:
    for user in group[3]:
        print user, group[0]
