for i in $(find . -name *pdf); do  	 	 	
	outfile=txt/$(echo $(basename $i) | sed 's/pdf//g')txt
	pdf2txt.py -o $outfile $i 
done
