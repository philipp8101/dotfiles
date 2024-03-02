cpumax=$(sensors |awk '/Core/{if (0+substr($3,2,2)>0+max) a=substr($3,2,2)} END{print a}')
gpu=$(nvidia-smi -q|awk '/GPU Current Temp/{print $5}')
echo "%{F#6e738d}CPU:%{F-}$cpumax°C %{F#6e738d}GPU:%{F-}$gpu°C"
