#!/bin/bash

if [ -f ./log.txt ]; then
    rm log.txt
fi

if [ -f ./fsm.btor2 ]; then
    rm fsm.btor2
fi

if [ -f ./*.vcd ]; then
    rm *.vcd
fi

# generate the btor
echo "Generating BTOR2 using yosys"
# prefer local version
if [ -f /mnt/data/liyf/Computer-Architecture/model_checking/oss-cad-suite/bin/yosys ]; then
    YOSYS=/mnt/data/liyf/Computer-Architecture/model_checking/oss-cad-suite/bin/yosys
elif [ `which yosys` ]; then
    YOSYS=yosys
else
    echo "Could not find Yosys. Needed to generate BTOR2"
    exit 1
fi

$YOSYS -q -s test_fm.ys

# run pono
echo ""
echo "Running pono"
# prefer local version
if [ -f /mnt/data/liyf/Computer-Architecture/model_checking/oss-cad-suite/bin/pono ]; then
    PONO=/mnt/data/liyf/Computer-Architecture/model_checking/oss-cad-suite/bin/pono
elif [ `which pono` ]; then
    PONO=pono
else
    echo "Could not find Pono."
    exit 1
fi

$PONO -v 1 -k 50 --print-wall-time --vcd counterexample.vcd ./fsm.btor2 2>&1 | tee log.txt

# Set the timeout variable
# MAX_TIME=$((60*60*2)) # In seconds
# timeout=0
# start_time=$(date +%s%N)
# /usr/bin/time -v $PONO -v 1 -k 50 --print-wall-time --vcd counterexample.vcd ./fsm.btor2 2>&1 | tee log.txt &
# sleep 2
# # Get the PID of $PONO process
# pid=$(ps -eo pid,command | grep "pono -v 1 -k" | grep -v "grep" | awk '{print $1}')


# while [ $timeout -eq 0 ] && ps -p $pid > /dev/null; do
#     # Check if there is a timeout
#     now=$(date +%s%N)
#     elapsed_time=$(expr $now - $start_time)
#     if [[ $elapsed_time -ge $MAX_TIME*1000000000 ]]; then
#         echo "Timeout, killing process $pid!"
#         timeout=1
#         kill $pid
#         break
#     fi

#     sleep 0.1 # Monitoring interval
# done
# end_time=$(date +%s%N)
# run_time=$(echo "$end_time - $start_time" | bc -l)
# run_time_sec=$(echo "scale=3;$run_time/1000000000" | bc)
# echo "Total time consumption: $run_time_sec sec" >> log.txt

# if [ $timeout -eq 0 ]; then 
#     # Convert memory usage from KB to MB and add to log.txt
#     mem_usage_kb=$(grep "Maximum resident set size" log.txt | awk '{print $6}')
#     mem_usage_mb=$(echo "scale=2; $mem_usage_kb / 1024" | bc)

#     # Append the MB value to the log file
#     sed -i "/Maximum resident set size/ s/$/ ,(mbytes): $mem_usage_mb/" log.txt
# fi
# wait