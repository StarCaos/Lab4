#!/usr/bin/bash
#wget https://get.station307.com/bqYhPsJLgKf/online_retail.csv
#yes you can either add #!/usr/bin/awk to the first line, or use awk -f yourfile.awk ... to read in the file

#Clean Up
#look for anything that has C
#take these out
#grep -E '^C' online_retail.csv > /tmp/1
sed -i -e '/^C/d' online_retail.csv > /tmp/2

# delete anything that has POST
sed -i -e '/,POST,/d' online_retail.csv > /tmp/3

#delete anything that starts with Australia
sed -i -e '/Australia$/d' online_retail.csv > /tmp/4

#Delete any discounts
  #sed -i -e '/D[0-9]*,D/d' online_retail.csv > /tmpt/5

#A table with Country, Gross Sales, and Items Under $2.00

# Patterns....{  code if matched   }
# ideas:
# Match a country  with pattern, then calculate per line data with that country

# syntax would be
# something == something (tally up the gross sales for that line)
# then out put the report

awk -f solution.awk online_retail.csv
