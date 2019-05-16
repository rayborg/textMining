#Requirements
#sudo apt install python-pdfminer (https://pypi.org/project/pdfminer/)
#pip install summa  (https://pypi.org/project/summa/)

#Takes a directory as input
#!/bin/bash

for f in *.pdf
do
  echo "Processing $f file..."
  
  #Converts PDF to text
  pdf2txt "$f" > tempFile.txt
 
  echo "" >> output.txt
  echo "" >> output.txt
  echo "*TITLE:$f**" >> output.txt
  
  #Sanitizing file
  #Removes non-alpha characters
  sed -i tempFile.txt -e "s/[^ a-zA-Z']//g" -e 's/ \+/ /' 
  cat tempFile.txt | tr -d "\n\r" > tempFile.txt
    
  cat tempFile.txt
    
  #Removing duplicate lines caused for a number of reasons
  cat tempFile.txt | sort | uniq > tempFile.txt
  
  #Summarizes the output and appends to output.txt
  textrank -t tempFile.txt -r .01 >> output.txt

done
