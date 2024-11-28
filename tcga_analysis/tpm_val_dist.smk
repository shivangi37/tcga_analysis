
rule extracting_directory:
	input:
		"{sample}_sample_sheet.tsv"
	output:
		"disease_type_list/{disease}_sample_{sample}_files_list.tsv"
	shell:
		"cat {input} | python scripts/list_file.py {wildcards.disease} > {output}"

rule tpm_dist:
	input:
		Normal_all="disease_type_list/{disease}_sample_{sample}_files_list.tsv"
		
	output:
		"TPM_val_list/{disease}_sample_{sample}_{gene}_TPM_vals.tsv"
	shell:
		"cat {input.Normal_all} | sh scripts/read_file.sh |  python scripts/tpm_values.py {wildcards.gene} > {output}"


def get_tpm_vals(wildcards):

	return ["TPM_val_list/{disease}_sample_{sample}_{gene}_TPM_vals.tsv".format(gene=wildcards.gene,sample=wildcards.sample,disease=c) for c in wildcards.diseases.split("_and_")]

rule boxplot_R:
	input:
		all_tpm=lambda wildcards: get_tpm_vals(wildcards)
		
	output:
		"boxplot_tpm_val/{diseases}_sample_{sample}_{gene}_TPM_boxplot.png"
	shell:
		"Rscript scripts/plot_tpm.R \"{input.all_tpm}\" \"{wildcards.diseases}\" \"{output}\" "
