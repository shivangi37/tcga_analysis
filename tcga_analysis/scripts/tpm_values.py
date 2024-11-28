import sys
import pandas as pd
import math
gene=sys.argv[1]


for line in sys.stdin:
	l=line.strip().split("\t")
	if len(l)==9:
		if l[1]==gene:
			print(math.log2(float(l[6]) + 1))

