


#!/bin/bash

echo "Hello "
if [ "$#" -ne 2 ]; then
  echo "Error:Only provide two arguments."
  exit 1
fi
i="$1"
o="$2"
echo "Provided Two Arguments.Task 1 Done"
if [ ! -f "$i" ]; then
  echo "Error: Input file '$i' does not exist."
  exit 1
fi
echo "Task 2 done"
awk -F, 'BEGIN{OFS=" "} {print $1, $2, $3, $5, $6, $7, $10, $11}' "$1" > "$2"

echo "Data extracted and appended to '$o' successfully.Task 3 Done."

awk -F',' '$3=="Bachelor\047s" {print $1}' "$i" >> "college_whose_HighestDegree_is_Bachelor’s"

echo "Task 4 Done."

awk -F',' '
  BEGIN {
    OFS = ": "
  }

  NR > 1 {
    admission_rate_sum[$6] += $7
    admission_rate_count[$6]++
  }

  END {
    print "Geography", "Average Admission Rate" >> "average_admission_rate"
    for (geography in admission_rate_sum) {
      average_admission_rate = admission_rate_sum[geography] / admission_rate_count[geography]
      print geography, average_admission_rate >> "average_admission_rate"
    }
  }
' "$i"
echo "Task 5 Done"
awk -F',' '
  BEGIN {
    OFS = ","
  }

  NR > 1 && $16 > 0 {
    college_earnings[$1] = $16
  }

  END {
    print "Top 5 Colleges with Maximum MedianEarnings:" >> "maximum_median_earnings"
    print "College,MedianEarnings" >> "maximum_median_earnings"

   
    for (i = 1; i <= 5; i++) {
      max_earnings = 0
      max_earnings_college = ""

 
      for (college in college_earnings) {
        if (college_earnings[college] > max_earnings) {
          max_earnings = college_earnings[college]
          max_earnings_college = college
        }
      }
      if (max_earnings_college != "") {
        print max_earnings_college, max_earnings >> "maximum_median_earnings"
        delete college_earnings[max_earnings_college]
      }
    }
  }
' "$i"
cat "average_admission_rate" >> "$o"
cat "maximum_median_earnings" >> "$o"
cat "college_whose_HighestDegree_is_Bachelor’s" >> "$o"
