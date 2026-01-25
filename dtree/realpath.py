#!/usr/bin/env python3
import sys
from pathlib import Path
print(Path(sys.argv[1]).resolve().absolute())
