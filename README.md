# lab-tools
 Tiny tools for various lab needs

## Table of Contents
- [Fly Barcode Macros](#fly-barcode-macros)
- [Rename OIF Files](#rename-oif-files)

## Fly Barcode Macros
Excel macros for printing barcode labels

## Rename OIF Files
Python script to rename oif files.  
batch and bash scripts exist to quickly run the script through conda.


oif files are stored with an acompanying folder of the same name with ".files" appended.  
The file stores metadata while the folder stores the raw image data.
When renaming an .oif file and .oif.files folder, there is metadata in the file that needs to be updated to refer to the new folder name.