#@ File        (label = "Input directory", style = "directory") srcFile
#@ String    (label = "File name contains", value = "") containString
#@ boolean (label = "Overwrite already processed files", value = False) overwriteExistingFiles

# See also Process_Folder.ijm for a version of this code
# in the ImageJ 1.x macro language.

import os
from ij import IJ, ImagePlus

def run(ignore_folders):
    ext = ".oif"
    srcDir = srcFile.getAbsolutePath()
    for root, directories, filenames in os.walk(srcDir):
        if root in ignore_folders:
            continue
        # Remove ignore_folders from walk
        directories[:] = [d for d in directories if os.path.join(root,d) not in ignore_folders]
        # Remove .oif.files folders from walk
        directories[:] = [d for d in directories if os.path.splitext(d)[-1] != ".files"]
        for filename in filenames:
            # Check for file extension
            if not filename.endswith(ext):
                continue
            # Check for file name pattern
            if containString not in filename:
                continue
            # Check if file has been converted before
            if not overwriteExistingFiles:
                new_filename = os.path.splitext(os.path.basename(filename))[0] + ".tif"
                saveDir = os.path.join(root, "tiffs")
                saveFile = os.path.join(saveDir, new_filename)
                # print "checking if file exists:", saveFile
                if os.path.exists(saveFile):
                    print(new_filename + " exists")
                    continue
            process(root, filename)

def process(currentDir, fileName):
    print("Processing:")

    # Opening the image
    print("Open image file " + fileName)
    imp = IJ.openImage(os.path.join(currentDir, fileName))

    # Saving the image
    saveDir = os.path.join(currentDir, "tiffs")
    if not os.path.exists(saveDir):
        os.makedirs(saveDir)
    print("Saving to " + saveDir)
    IJ.saveAs(imp, "Tiff", os.path.join(saveDir, fileName))
    imp.close()

ignore_folders = [r"Z:\2PImaging\Kerstin\202212_tryouts",
                  r"Z:\2PImaging\Jorin\Practice",
                  r"Z:\2PImaging\Jorin\Prelim",
                  r"Z:\2PImaging\Kerstin\HD009\20230215_brain2",]
run(ignore_folders)
print("macro complete")
