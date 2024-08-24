

# Save the filename with todays timestamp
today=$(date "+%Y%m%d") #Using command substitution
weather_report="raw_data_$today"

# Download wttr.in weather report for Casablanca
city="casablanca"
curl wttr.in/$city > $weather_report

# Extract lines containing temperature
grep °C $weather_report > temperatures.txt

# Extracting the current temperature
obs_temp=$(head -n 1 temperatures.txt | tr -s " " | xargs | cut -d " " -f 4)

# Extracting temperature for Noon tomorrow
fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | cut -d '+' -f 3 | xargs | cut -c 19-20)

# Storing the local time for Casablanca
hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

#  Removes ANSI color code from the log file
sed -i.bak -E 's/\x1B\[[0-9;]*[mGK]//g' rx_poc.log

echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp" >> rx_poc.log

