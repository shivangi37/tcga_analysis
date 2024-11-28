args <- commandArgs(trailingOnly=TRUE)
files <- strsplit(args[1]," ")[[1]]
diseases <- strsplit(args[2],"_and_")[[1]]
output_filename <- args[3]
data1 <- read.table(files[1],sep="\t",header=FALSE)
library(ggplot2)
data2 <- read.table(files[2],sep="\t",header=FALSE)
col1 <- data1[[1]]
col2 <- data2[[1]]

data <- data.frame(disease=factor(c(rep(diseases[1],length(col1)),rep(diseases[2],length(col2)))), tpm=c(col1,col2))

a1 <- length(col1)
a2 <- length(col2)


test_result <- wilcox.test(col1,col2)
p_value <- test_result$p.value
annotation_text <- paste0("n(",diseases[1],") = " , a1, ", n(" , diseases[2],") = ", a2, "\n", "p = ", format(p_value, digit=2, scientific=TRUE))


p <- ggplot(data,aes(x=disease,y=tpm)) + geom_boxplot(notch=TRUE) + labs(title="Lung Adenocarcinoma",x="Disease Condition",y="Log2 (TPM + 1)") + annotate("text",x=1.5,y=max(data$tpm) * 1.05, label=annotation_text, size=4, hjust=0.5)

ggsave(filename=output_filename,plot=p)

