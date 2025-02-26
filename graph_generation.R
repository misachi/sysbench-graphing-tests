library( ggplot2 )

all_res = read.csv( "out/all_res.data" )
pdf( "out/result_graphs2.pdf" )
print( qplot( time, tps, color=run, data=all_res, xaxs="i" ))
# print( qplot( time, resp_time, color=run, data=all_res, ylim = c(0,500) )) # Removing this as the sysbench(my version) output does not have response time
dev.off()