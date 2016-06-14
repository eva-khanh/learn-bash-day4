total=5
if [ -f log_total.log ]; then
	> log_total.log
fi
for res in *.gz
do
	zcat < $res >> log_total.log
done

echo "================================================"
echo "===== 1.The number of unique user in total ====="
echo "================================================"
TOTAL=$(cut -f 3 log_total.log | sort | uniq | wc -l)
echo "Total : " $TOTAL " users"

echo "====================================================="
echo "===== 2.The number of unique user for each days ====="
echo "====================================================="
for ((i=1; i<=total; i++))
do
	DAY=$(zcat < result.day$i.log.gz | cut -f 3 | sort | uniq | wc -l)
	echo "day " $i ": " $DAY " users"
done

echo "========================================================"
echo "===== 3.The number of unique user for each regions ====="
echo "========================================================"
COUNTRY=$(cut -f 2 log_total.log | sort | uniq)
for c in $COUNTRY
do
	REGION=$(grep -o $c log_total.log | wc -l)
	echo $c " has " $REGION " users"
done
sleep 5