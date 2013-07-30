#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Laplacian_solver_time"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
tab.m <- melt(tab, id.vars="Cores")
tab_all=tab.m[tab.m$variable != "Ideal.scaling",]
tab_ideal=tab.m[tab.m$variable == "Ideal.scaling",]

p <- ggplot(tab_all, aes(x=as.factor(Cores), y=value))
p <- p + geom_bar(data=tab_all, aes(fill=variable), position=position_dodge(), stat="identity", show_guide=FALSE)
p <- p + scale_fill_manual(values=c("#99CCFF","#338888"))
p <- p + geom_line(data=tab_all, aes(x=as.factor(Cores), y=value, group=NULL, color=variable, size=variable))
p <- p + geom_line(data=tab_ideal, aes(x=as.factor(Cores), y=value, group=1, color=variable, size=variable))
p <- p + scale_color_manual(name="", values=c("black","#99CCFF","#338888"), labels=c("Ideal Scaling","Ref","D&C"))
p <- p + scale_size_manual(name="", values=c(0.5,1.2,1.2), labels=c("Ideal Scaling","Ref","D&C"))
p <- p + scale_x_discrete(breaks=c(1,2,4,6,8,12))
p <- p + labs(x="Cores", y="Seconds")
p <- p + theme_bw() + theme(legend.key=element_blank())

pdf(paste(f,".pdf",sep=""), width=5.1, height=2.35)
print(p)
dev.off()
