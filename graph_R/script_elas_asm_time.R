#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Elasticity_asm_time"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
tab.m <- melt(tab, id.vars="Cores")
tab_all=tab.m[tab.m$variable != "Ideal.scaling",]
tab_ideal=tab.m[tab.m$variable == "Ideal.scaling",]
tab_all$variable = factor(tab_all$variable)

tab_all$value = as.double(tab_all$value/(10**10))
tab_ideal$value = as.double(tab_ideal$value/(10**10))

p <- ggplot(tab_all, aes(x=as.factor(Cores), y=value))
p <- p + geom_bar(aes(fill=variable),position=position_dodge(), stat="identity")
p <- p + scale_x_discrete(breaks=c(1,2,4,6,8,12))
p <- p + labs(x="Cores", y="Cycles (10e+10)")
p <- p + scale_colour_manual(name="", values=c("black"), labels=c("Ideal Scaling"))
p <- p + scale_fill_brewer(name="", labels=c("Pure MPI", "D&C", "Coloring"))
p <- p + geom_line(data=tab_ideal, aes(x=as.factor(Cores), y=value, group=1, color=variable), size=1)
p <- p + geom_point(data=tab_ideal, aes(x=as.factor(Cores), y=value, group=1, color=variable), size=2.2)
p <- p + theme_bw() + theme(legend.position="none")

pdf(paste(f,".pdf",sep=""), width=4, height=2.5)
print(p)
dev.off()
