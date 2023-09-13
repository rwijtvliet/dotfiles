apps=""
while read line
do
  [[ $line =~ ^#.* ]] && continue
  echo $line
  apps+=" $line"
done <<< "$(cat part2)"
echo $apps
