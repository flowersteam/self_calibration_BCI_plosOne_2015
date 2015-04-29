#!/bin/bash                                                                                                                             
function runMatlabScriptInWindow {
	tmux send-keys -t matlab:$2 "matlab -nodesktop -nojvm -r $1" C-m
	sleep 10  # just to ensure matlab do not start too close one form the other
	# tmux send-keys -t matlab:$2 "$1" C-m
}

nRun=$2
matlabScript=$1

sup=$(($nRun-1))
for i in $(eval echo {0..$sup})
do
	cnt=$(($i+1))
	if [[ $i -eq 0 ]]
	then
		echo "$cnt/$nRun"
		echo "Starting matlab..."
		echo "$matlabScript"
		tmux start-server
		tmux new-session -d -s matlab -n run$i
		runMatlabScriptInWindow $matlabScript $i
	else
		echo "$cnt/$nRun"
		echo "Starting matlab..."
		tmux new-window -t matlab:$i -n run$i
		runMatlabScriptInWindow $matlabScript $i
	fi
done

tmux select-window -t matlab:run0
tmux attach-session -t matlab

# tmux kill-session -t matlab
# tmux list-window