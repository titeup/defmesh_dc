#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Elasticity_asm_efficiency"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
tab.m <- melt(tab, id.vars="Cores")

print(tab.m)

tab_ideal=tab.m[tab.m$variable == "Ideal.scaling",]

p <- ggplot(tab.m, aes(x=as.factor(Cores), y=value, size=variable ))
p <- p + geom_line(aes(group=variable, color=variable))

p <- p + scale_size_manual(name="", values=c(0.4,1.2,1.2,1.2), labels=c("Ideal Scaling", "Ref", "D&C", "Coloring"))
p <- p + scale_colour_manual(values=c("black","#99CCFF","#338888","#005555"),name="",
							 labels=c("Ideal Scaling","Ref", "D&C", "Coloring"))
p <- p + scale_x_discrete(breaks=c(1,2,4,6,8,12))

p <- p + labs(x="Cores", y="Efficiency")

p <- p + geom_line(data=tab_ideal, aes(x=as.factor(Cores), y=value, group=1), color="black", size=0.4)
p <- p + guides(color = guide_legend(override.aes = list(size = c(0.4,1.2,1.2,1.2))))

p <- p + theme_bw() + theme(legend.key = element_blank())

pdf(paste(f,".pdf",sep=""), width=5, height=2.45)
print(p)
dev.off()
