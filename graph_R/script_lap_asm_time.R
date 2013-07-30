#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Laplacian_asm_time"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
tab.m <- melt(tab, id.vars="Cores")
tab_all=tab.m[tab.m$variable != "Ideal.scaling",]
tab_ideal=tab.m[tab.m$variable == "Ideal.scaling",]
tab_all$value = as.double(tab_all$value/(10**9))
tab_ideal$value = as.double(tab_ideal$value/(10**9))

p <- ggplot(tab_all, aes(x=as.factor(Cores), y=value))
p <- p + geom_bar(data=tab_all, aes(fill=variable), position=position_dodge(), stat="identity")
p <- p + scale_fill_manual(name="", values=c("#99CCFF","#338888","#005555"), labels=c("Ref", "D&C", "Coloring"))
p <- p + geom_line(data=tab_ideal, aes(x=as.factor(Cores), y=value, group=1, color=variable), size=0.5)
p <- p + scale_color_manual(name="", values=c("black"), labels=c("Ideal Scaling"))
p <- p + scale_x_discrete(breaks=c(1,2,4,6,8,12))
p <- p + labs(x="Cores", y="Giga Cycles")
p <- p + theme_bw() + theme(legend.position="none")

pdf(paste(f,".pdf",sep=""), width=4, height=2.5)
print(p)
dev.off()
