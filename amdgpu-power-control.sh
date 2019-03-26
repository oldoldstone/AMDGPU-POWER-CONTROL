#!/bin/bash
set_fan_speed ()
{
  for(( i=0;i<${#speeds[@]};i++)); do
    card=/sys/class/drm/card$i/
    if [ ! -d "$card" ]; then
      continue
    fi
    for monitor in "$card"device/hwmon/hwmon?/ ; do
      fanmax=$(head -1 ${monitor}"pwm1_max")
      if [ $fanmax -gt 0 ] ; then
        pwm1=$(( (${fanmax} * ${speeds[i]})/100))
        sh -c "echo -n 1 >> "$monitor"pwm1_enable"
        cmdstr="echo ${pwm1} >${monitor}pwm1"
        sh -c  "$cmdstr"
        echo "Card$i Fan Speed Set To ${speeds[i]} %"
      else
        echo "Error: Unable To Determine Maximum Fan Speed For Card$i!"
      fi
    done
  done;
}
set_power_cap()
{
  for(( i=0;i<${#caps[@]};i++)); do
    cap=${caps[i]}"000000"
    card=/sys/class/drm/card$i/
    if [ ! -d "$card" ]; then
      continue
    fi
    for monitor in "$card"device/hwmon/hwmon?/ ; do
      cmdstr="echo ${cap} >${monitor}power1_cap"
      sh -c  "$cmdstr"
      echo "Card$i Max Power Set To ${caps[i]} W"
    done
  done;
}
main()
{
  if [[ $EUID -ne 0 ]]; then
   echo "ERROR: This script must be run as root" 
   exit 1
  fi
  IFS=","
  while getopts p:s: flag; do
    case $flag in
      p)
        caps=($OPTARG)
        set_power_cap
        ;;
      s)
        speeds=($OPTARG)
        set_fan_speed
        ;;
      ?)
        exit;
        ;;
    esac
  done
}
main "$@"
