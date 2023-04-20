#!/usr/bin/env python
# coding: utf-8
"""rename_oif.py
This script prompts the user to rename an oif file.

This script prompts the user to select an oif file and type a new name. Then renames the .oif file and its corresponding folder.
.oif files are stored with an acompanying folder of the same name with .files appended. The file stores metadata while the folder stores the raw image data.
When renaming an .oif file and .oif.files folder, there is metadata in the file that needs to be updated to refer to the new folder name.
"""

import os
from pathlib import Path
import tkinter as tk
from tkinter import filedialog, simpledialog

def select_file():
    """Prompt user to select a file

    Returns:
        Path | None: Path to user selected file
    """
    root = tk.Tk()
    root.withdraw()
    root.attributes("-topmost", 1)
    filetypes = [('oif files', '*.oif')]
    file_nm = filedialog.askopenfilename(title="Select files", filetypes=filetypes)

    if file_nm == "":
        return None
    return Path(file_nm)

def get_new_name(old_name):
    """Prompt user for a new name, using the old name as the initial value

    Args:
        old_name (str): old name that is being updated

    Returns:
        str: new name given by user
    """
    root = tk.Tk()
    root.withdraw()
    root.attributes("-topmost", 1)
    pad = " " * 50
    prompt_text = "Enter new name of .oif file"
    new_name = simpledialog.askstring("Input", pad+prompt_text+pad, initialvalue=old_name)
    return new_name

def rename_oif_file(old_oif_path, new_name):
    """Rename an oif file and its corresponding folder

    Args:
        old_oif_path (Path): Path to oif file
        new_name (str): New name of oif file and its corresponding folder

    Raises:
        RuntimeError: Raised if old_oif_path is not a file or if the new name will overwrite a file
    """
    # Set variables
    old_oif_files_path = old_oif_path.with_suffix(".oif.files")

    new_oif_path = old_oif_path.with_name(new_name).with_suffix(".oif")
    new_oif_files_path = old_oif_files_path.with_name(new_name).with_suffix(".oif.files")

    old_name = old_oif_path.stem

    # Check if path to file exists
    if not (old_oif_path.exists() or old_oif_files_path.exists()):
        if not old_oif_path.exists() and old_oif_files_path.exists():
            error_text = f".oif path does not exist:\n{old_oif_path}"
        elif old_oif_path.exists() and not old_oif_files_path.exists():
            error_text = f".oif.files path does not exist:\n{old_oif_files_path}"
        else:
            error_text = (".oif and .oif.files paths do not exist:\n"
                          + f"{old_oif_path}\n{old_oif_files_path}")
        raise RuntimeError(error_text)

    # Check if new name is valid
    if new_oif_path.exists() or new_oif_files_path.exists():
        if new_oif_path.exists() and not new_oif_files_path.exists():
            error_text = ("An oif file already exists with the name:\n"
                          f"{new_oif_path}")
        elif not new_oif_path.exists() and new_oif_files_path.exists():
            error_text = ("An oif folder already exists with the name:\n"
                          f"{new_oif_files_path}")
        else:
            error_text = ("An oif file and folder already exists with the name:\n"
                          f"{new_oif_files_path}")
        raise RuntimeError(error_text)

    ## update .oif metadata
    # Read file
    with open(old_oif_path, "r", encoding="utf16") as oif:
        data = oif.readlines()
    # Edit data
    for index, line in enumerate(data):
        if old_name in line:
            data[index] = line.replace(old_name, new_name)
    # Write data to file
    with open(old_oif_path, "w", encoding="utf16") as oif:
        oif.writelines(data)

    ## Rename .oif.files
    os.rename(old_oif_path, new_oif_path)
    os.rename(old_oif_files_path, new_oif_files_path)

def main():
    """Prompt user to select oif file and new name for it then rename it."""
    file_nm = select_file()
    if file_nm is None:
        print("Canceled file selection")
        return
    new_name = get_new_name(file_nm.stem)
    if new_name is None:
        print("Canceled new name selection")
        return

    rename_oif_file(file_nm, new_name)

if __name__ == "__main__":
    main()
