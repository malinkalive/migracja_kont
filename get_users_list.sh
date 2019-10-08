#!/bin/bash

PASSWORDS=tmp/passwords.txt
SSHA=tmp/ssha.txt
rm -rf $SSHA
for i in `cat $PASSWORDS`; 
do 
	dlugosc_hasla="$(wc -c <<<$i)"
	dlugosc="${dlugosc_hasla}"
		if [ $dlugosc -eq 53 ]; 
		then 
			echo $i | base64 -d | sed 's/$/\n/g' >> $SSHA
		else 
			echo $i | sed 's/=/==/g' | base64 -d | sed 's/$/\n/g' >> $SSHA
		fi
done

echo "klonuje do gita"
scp $0 karol@10.0.0.26:/home/karol/migrate
ssh karol@10.0.0.26 bash -c 'cd /home/karol/ ; cd migrate && git add . && git commit -m "update" && git push'
