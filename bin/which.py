#!/bin/env python

import sys
try:
    print __import__(sys.argv[1]).__file__
except ImportError:
    print sys.argv[0], ": no", sys.argv[1], " in ", sys.path
except AttributeError:
    print sys.argv[1], "is a built-in module"
