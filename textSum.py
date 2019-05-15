#Python script that uses gensim to summarize a plain text file

from argparse import ArgumentParser
from gensim.summarization import summarize
import os.path
import io

def is_valid_file(parser, arg):
    if not os.path.exists(arg):
        parser.error("The file %s does not exist!" % arg)
    else:
        return open(arg, 'r')  # return an open file handle

#Command line help
parser = ArgumentParser(description="Text summarization")
parser.add_argument("-i", dest="filename", required=True,
                    help="input file with plain text", metavar="Input file to summarize",
                    type=lambda x: is_valid_file(parser, x))
args = parser.parse_args()

#Parse input fields
inputText = args.filename.read()
#Close file
args.filename.close()

#Create output file
outputPath = "Out.txt"

#Summarize text and put into summary
summary = summarize(inputText)

#Write output file
summarized = open(outputPath,'w')
summarized.write(summary)
summarized.close()


