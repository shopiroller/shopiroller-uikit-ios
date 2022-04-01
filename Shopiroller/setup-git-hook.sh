
count=0
total=34
pstr="[=======================================================================]"

while [ $count -lt $total ]; do
  sleep 0.1 # this is work
  count=$(( $count + 1 ))
  pd=$(( $count * 95 / $total ))
  printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 
1000 / $total) % 10 )) $pstr
done
ln -s -f .hooks/pre-commit ../.git/hooks/pre-commit
git config core.hooksPath $(pwd)/.hooks
sudo chmod +x $(pwd)/.hooks
