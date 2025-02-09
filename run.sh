#!/bin/bash

# Default settings
CHARACTERS="characters/Artist.json,characters/BusinessPerson.json,characters/CharityWorker.json,characters/Dictator.json,characters/Gamer.json,characters/PoliticalActivist.json,characters/Scientist.json,characters/SportsCoach.json,characters/StayAtHomeMom.json,characters/TravelEnthusiast.json"
OUTPUT_LOG="run_output.log"
PID_FILE="run.pid"

# Check if -d flag is provided
use_nohup=false

while getopts "d" opt; do
    case $opt in
        d)
            use_nohup=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
    esac
done

if [ "$use_nohup" = true ]; then
    # Run with nohup
    nohup pnpm start --characters="$CHARACTERS" > "$OUTPUT_LOG" 2>&1 &
    echo $! > "$PID_FILE"
    echo "Started in background. PID: $(cat $PID_FILE)"
    echo "Output is being logged to $OUTPUT_LOG"
else
    # Run normally
    pnpm start --characters="$CHARACTERS"
fi
