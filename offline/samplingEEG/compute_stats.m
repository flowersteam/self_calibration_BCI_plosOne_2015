function rec = compute_stats(analysisLogs)

rec = Logger();

rec.log_field('nSim', length(analysisLogs.filename))


idReachFirst = find(analysisLogs.timeTarget(:,1) > 0);

rec.log_field('ratioReachedOnce', length(idReachFirst)/length(analysisLogs.timeTarget(:,1)))

rec.log_field('ratioFirstCorrect', mean(analysisLogs.targetCorrect(idReachFirst,1)))

rec.log_field('meanFirstNStep', mean(analysisLogs.timeTarget(idReachFirst,1)))
rec.log_field('stdFirstNStep', std(analysisLogs.timeTarget(idReachFirst,1)))

rec.log_field('meanNCorrect', mean(sum(analysisLogs.correctReach,2)))
rec.log_field('stdNCorrect', std(sum(analysisLogs.correctReach,2)))

rec.log_field('meanNError', mean(sum(analysisLogs.wrongReach,2)))
rec.log_field('stdNError', std(sum(analysisLogs.wrongReach,2)))