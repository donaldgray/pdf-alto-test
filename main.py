import glob
import subprocess
from subprocess import PIPE

from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfinterp import resolve1


input_dir = "/home/input/"
output_dir = "/home/output/"

pdfs = [pdf for pdf in glob.glob(f"{input_dir}/*.pdf")]

for pdf in pdfs:
    try:
        file = open(pdf, 'rb')
        parser = PDFParser(file)
        document = PDFDocument(parser)

        pages = int(resolve1(document.catalog['Pages'])['Count'])
        print(f"Processing {pdf}, which has {pages} pages")
        for i in range(1, pages + 1):
            print(f"Processing page {i}")
            output = f"{output_dir}{pdf.split('/')[-1]}-{i}.xml"
            command = f"/home/pdfalto/pdfalto/pdfalto -readingOrder -noImage -f {i} -l {i} {pdf} {output}"
            subprocess.run(command, shell=True, check=True, stdout=PIPE, stderr=PIPE)
    except subprocess.CalledProcessError as e:
        raise e

    print(f"Done processing {pdf}")
