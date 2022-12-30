#!/usr/bin/env bash

totalSeconds=0

# Loop through the arguments
for arg in "$@"
do
  duration=$(echo "$arg" | sed -n 's/\([0-9]\+\).*/\1/p') #Removes s,m,h; keeps digits
  unit=$(echo "$arg" | sed -n 's/[^smh]*\([smh]\).*/\1/p') #Removes digits; keeps s,m,h

  # Convert the duration to seconds
  case $unit in

    s)
      totalSeconds=$((totalSeconds + duration))
    ;;

    m)
      totalSeconds=$((totalSeconds + duration * 60))
    ;;

    h)
      totalSeconds=$((totalSeconds + duration * 3600))
    ;;

    *)
      echo "Error: invalid input format."
      echo "Please use any one of the following formats:"
      echo -e "10s\n30m\n1h 30m 10s"
      exit 1
    ;;

  esac

  # Shift the arguments by 1
  shift
done

ElapsedTime=0
echo -e "\nStopwatch started.\n"

while true
do
  Hours=$((ElapsedTime / 3600))
  Minutes=$(((ElapsedTime % 3600) / 60))
  Seconds=$((ElapsedTime % 60))

  # Format the time as HH:MM:SS
  echo -ne "\r$(printf "%02d:%02d:%02d" $Hours $Minutes $Seconds)"
  # \r moves cursor to front everytime so the output is overwritten
  # %02d ensures its always double digits

  # Sleep for 1 second before continuing the loop
  sleep 1

  ((ElapsedTime++))

  # Check if elapsed time has reached given duration
  if [ "$ElapsedTime" -ge "$totalSeconds" ]
  then
    echo -e "\n\nStopwatch completed.\n"
    /usr/bin/notify-send --urgency=critical --icon=stopwatch "Stopwatch completed." # Notification
    break
  fi

done
