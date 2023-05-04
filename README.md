# lab-tools
 Tiny tools for various lab needs

## Table of Contents
- [Fly Barcode Macros](#fly-barcode-macros)
- [Fiji  Scripts](#fiji--scripts)
  - [Convert\_oif\_to\_tiff.py](#convert_oif_to_tiffpy)
    - [How to run:](#how-to-run)
  - [How to install a Fiji  script:](#how-to-install-a-fiji--script)
- [Rename OIF Files](#rename-oif-files)

## Fly Barcode Macros
Excel macros for printing barcode labels

## Fiji  Scripts
### Convert_oif_to_tiff.py
Python script to convert all oif files in a directory to tiff files. 

#### How to run:
* After [Installing](#how-to-install-a-fiji--script), select the script
![Select script](FIJI%20Scripts/docs/images/select_script_to_run.png "Select script")
* Select folder to run it on
![Run script](FIJI%20Scripts/docs/images/run_script.png "Run script")
* After the script completes there will be a tiff folder in the same directory as every .oif file
![Script results](FIJI%20Scripts/docs/images/script_results.png "Script results")
![Script results tiff folder](FIJI%20Scripts/docs/images/script_results_tiffs.png "Script results tiff folder")

### How to install a Fiji  script:
https://imagej.net/scripting/#adding-scripts-to-the-plugins-menu
* Download script
* Select Plugins > Install
![Install plugin button](Fiji%20Scripts/docs/images/install_plugin_button.png "Install plugin button")
* Select the script
![Select script to install](Fiji%20Scripts/docs/images/select_script_to_install.png "Select script to install")
* Select install location  
  The default install location places it under plugins, you can select a subfolder to place it in another menu.
![Select script location](Fiji%20Scripts/docs/images/select_script_location.png "Select script location")
* After restarting fiji, the script will apear in the menu it was placed in
 ![Script saved in plugins](FIJI%20Scripts/docs/images/script_saved_in_plugins.png "Script saved in plugins")
* If your plugins menu is too long, you can move the script under Plugins > Macros by saving to the Macros folder when selecting the install location

## Rename OIF Files
Python script to rename oif files.  
batch and bash scripts exist to quickly run the script through conda.


oif files are stored with an acompanying folder of the same name with ".files" appended.  
The file stores metadata while the folder stores the raw image data.
When renaming an .oif file and .oif.files folder, there is metadata in the file that needs to be updated to refer to the new folder name.