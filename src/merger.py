# -*- coding: utf-8 -*-
"""
Created on Wed Jul 30 09:46:37 2025

@author: Paul Namalomba
Comments to be made later
This is the SEQUENTIAL PDF MERGER,
"""

# ===================================================================================
# SEQUENTIAL PDF MERGER - CORE FUNCTIONALITY
# ===================================================================================

# ===================================================================================
# STANDARD LIBRARY AND THIRD-PARTY IMPORTS
# ===================================================================================
import subprocess
import sys
import os
import re
import glob
import pymupdf
import pypdf
from pypdf import PdfReader, PdfWriter, PaperSize
from pathlib import Path
from tkinter import Tk, Button, filedialog, simpledialog


# ===================================================================================
# PDF FILE SORTING FUNCTION
# ===================================================================================
# need to form a key that order the pdfs by number
def tut_and_rev_key(fname):
    # match TUT<main> or TUT<main>-<sub>
    m = re.search(r'\D*(?:\d+\D+)?(\d+)(?:-(\d+))?', fname, re.IGNORECASE)
    if m:
        main = int(m.group(1))
        sub  = int(m.group(2)) if m.group(2) else 0
        return (main, sub)
    return (float('inf'), float('inf'))


# ===================================================================================
# WORKING DIRECTORY SETUP
# ===================================================================================
# Stuff that is standard in all my codes (where is .py located essentially)
fixed_code_path = os.path.dirname(os.path.abspath(__file__))
os.chdir(fixed_code_path)


# ===================================================================================
# SOURCE DIRECTORY SELECTION AND VALIDATION
# ===================================================================================
# Create a Tkinter root window, but hide it as it's not needed for filedialog
root = Tk()
root.withdraw()

# -------------------------------------------------------------------------
# USER INPUT - SOURCE FOLDER SELECTION
# -------------------------------------------------------------------------
# Prompt the user for input using the file explorer to select folder
src_docs_foldername = filedialog.askdirectory(title="Select Folder PDFs to Combine")
if src_docs_foldername == None:
    print("OUT: PDFs not merged! Folder PDFs was not specified")
    sys.exit(0)
else:
    # -------------------------------------------------------------------------
    # SOURCE DIRECTORY PROCESSING AND FILE DISCOVERY
    # -------------------------------------------------------------------------
    # Code to store data about the directory containg the source files
    src_docs_path = os.path.join(src_docs_foldername) # force parse as path
    src_docs_path = Path(src_docs_path).as_posix() # force parse as path in the current OS
    os.chdir(src_docs_path) # change to the directory with the source files
    output_folder_name = str(os.path.basename(src_docs_path)) + " - Merged Outputs" # store name of outputs folder directory
    parent_dir = os.path.dirname(src_docs_path) # name of parent to src_docs_path
    list_of_files = glob.glob("*.pdf", recursive=False) # list of A3 target documents
    list_of_files.sort(key=tut_and_rev_key)

    # ===================================================================================
    # OUTPUT FILE NAME CONFIGURATION
    # ===================================================================================
    # Create a Tkinter root window, but hide it as it's not needed for simpledialog
    root_2 = Tk()
    root_2.withdraw()
    
    # -------------------------------------------------------------------------
    # USER INPUT - OUTPUT FILE NAME SPECIFICATION
    # -------------------------------------------------------------------------
    # Prompt the user for input using a dialog box
    outfile_prompt = simpledialog.askstring(title="User Input",
                                        prompt="Please specify the outfile name (with or without extension): ")
    if not outfile_prompt == None or outfile_prompt == "":
        # -------------------------------------------------------------------------
        # OUTPUT FILE NAME PROCESSING AND VALIDATION
        # -------------------------------------------------------------------------
        outfile_prompt = str(outfile_prompt) # force string
        if outfile_prompt.endswith(".pdf"):
            outfile_prompt = outfile_prompt[:-4]
        else:
            outfile_prompt = outfile_prompt
        output_file_name = "{combined}.pdf".format(combined = outfile_prompt)

        # ===================================================================================
        # PDF MERGING PROCESS
        # ===================================================================================
        merger = PdfWriter()
        
        # -------------------------------------------------------------------------
        # SEQUENTIAL PDF FILE PROCESSING
        # -------------------------------------------------------------------------
        for filename in list_of_files:
            if filename.lower().endswith(".pdf") and filename != output_file_name:
                merger.append(os.path.join(src_docs_path, filename))
        
        # -------------------------------------------------------------------------
        # OUTPUT DIRECTORY CREATION AND FILE WRITING
        # -------------------------------------------------------------------------
        if not os.path.exists(output_folder_name):
            os.mkdir(output_folder_name)
        os.chdir(output_folder_name)
        merger.write(output_file_name)
        merger.close()
        print(f"OUT: PDFs merged into {output_file_name}")
        os.chdir(src_docs_path) # change to the directory with the source files
    else:
        print("OUT: PDFs not merged! outfile name was not specified")
        sys.exit(0)