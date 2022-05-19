#! /bin/bash   
  while getopts d:w: flag
do
    case "${flag}" in
        d)domain=${OPTARG};;
        w)wordlist=${OPTARG};;
    esac
done
  if [[ `wget -S --spider $domain 2>&1 | grep 200` ]]; then
 echo "valid url" 
else 
echo "invalid url"
exit 0
fi
while read word ; do
fuzz=$(echo "$domain/$word")
status=$(curl --write-out %{http_code} --silent --output /dev/null $fuzz)
if [ $status == 200 -o $status == 301 ]; then
    echo $fuzz
    echo $fuzz >> "$domain"_dirs.txt
fi 

done < $wordlist
