#!/bin/bash
#wget https://get.station307.com/bqYhPsJLgKf/online_retail.csv
#yes you can either add #!/usr/bin/awk to the first line, or use awk -f yourfile.awk ... to read in the file

#Clean Up
#look for anything that has C
#take these out
#grep -E '^C' online_retail.csv > /tmp/1
sed -i -e '/^C/d' ./online_retail.csv

# delete anything that has POST
sed -i -e '/,POST,/d' ./online_retail.csv

#delete anything that starts with Australia
sed -i -e '/Australia$/d' ./online_retail.csv
#Delete any discounts
  #sed -i -e '/D[0-9]*,D/d' online_retail.csv > /tmpt/5

#A table with Country, Gross Sales, and Items Under $2.00

# Patterns....{  code if matched   }
# ideas:
# Match a country  with pattern, then calculate per line data with that country

# syntax would be
# something == something (tally up the gross sales for that line)
# then out put the report
#
#echo | awk -f solution.awk online_retail.csv

awk -F "," '
BEGIN{
      printf("%-20s%-20s%-20s\n", "Country", "Gross Sales", "Items Under $2.00");
      printf("------------------------------------------------------------\n");
      getline;
      Francegrosssales=0;
      Franceitems=0;
      Netherlandsgrosssales=0;
      Netherlandsitems=0;
      UKgrosssales=0;
      UKitems=0;
      Germanygrosssales=0;
      Germanyitems=0;
      Norwaygrosssales=0;
      Norwayitems=0;
}

#this line is for France
#Calculate the Gross Sales
$8=="France"{
  Francegrosssales += ($4*$6);

#items less than $2.00
if ($6 < 2.00) {
  Franceitems += 1;
 }
}

#this line is for Netherlands
$8=="Netherlands"{
  Netherlandsgrosssales += ($4*$6);

#items less than $2.00
if ($6 < 2.00) {
  Netherlandsitems += 1;
 }
}

#this line is for the UK
$8=="United Kingdom"{
  UKgrosssales += ($4*$6);

#items less than $2.00
if ($6 < 2.00) {
  UKitems += 1;
 }
}

#this line is for Germany
$8=="Germany"{
  Germanygrosssales += ($4*$6);

#items less than $2.00
if ($6 < 2.00) {
  Germanyitems += 1;
 }
}

#this line is for Norway
$8=="Norway"{
  Norwaygrosssales += ($4*$6);

#items less than $2.00
if ($6 < 2.00) {
  Norwayitems += 1;
 }
}


END {
    printf("%-20s%-20f%-20d\n", "France", Francegrosssales, Franceitems);
    printf("%-20s%-20f%-20d\n", "Netherlands", Netherlandsgrosssales, Netherlandsitems);
    printf("%-20s%-20f%-20d\n", "United Kingdom", UKgrosssales, UKitems);
    printf("%-20s%-20f%-20d\n", "Germany", Germanygrosssales, Germanyitems);
    printf("%-20s%-20f%-20d\n", "Norway", Norwaygrosssales, Norwayitems);
}' online_retail.csv
