# AMDGPU-POWER-CONTROL

Control AMD GPU's max power consumption and fan speeds for every card individually.

## Require

lm_sensors

## Installation

```bash
git clone https://github.com/oldoldstone/amdgpu-power-control
cd amdgpu-power-control
chmod +x amdgpu-power-control.sh
```

## Usage

```bash
sudo ./amdgpu-power-control.sh -p [power1,power2] -s [speed1,speed2]
```

* -p Set max power consumption for every card individually, for example "-p 80,90,100".

* -s Set fan speed in percents for every card individually, for example "-s 50,60,70".

## Examples

```bash
sudo ./amdgpu-power-control.sh -p 100,90 -s 60,50
```

Set your GPU0's max power to 100 W and fan speed to 60 %, and GPU1's max power to 90 W and fan speed to 50 %.

## Notes

This script must be run as root.
