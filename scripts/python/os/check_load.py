#!/usr/bin/env python
#imports
import os

#variables
myhost = os.uname()[1]

print "The system load of %s is." % (myhost)
print os.getloadavg()
