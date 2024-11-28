import sys
disease_dict={}
disease=sys.argv[1]
a=disease.split("_")
disease_mod=" ".join(a)

for line in sys.stdin:
	l=line.strip().split("\t")
	if len(l)==8:
		if l[7]==disease_mod :
			disease_dict[l[0]]=l[1]
for directory in disease_dict:
	print(directory + "/" + disease_dict[directory])