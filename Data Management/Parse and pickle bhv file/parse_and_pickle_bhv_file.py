# parse_and_pickle_bhv_file.py

import pickle
from pathlib import Path
import json
from unityvr.preproc import logproc as lp
from unityvr.analysis import posAnalysis

BHV_FOLDER = Path(r"Z:\Live Fly Imaging data\unity\raw data")
PICKLE_FOLDER = Path(r"Z:\Live Fly Imaging data\unity\pickles")

def parse_and_pickle(path):
    # Parse behavior file
    # uvr.posDf starts with columns: frame, time, dt, x, y, angle, dx, dy, dxattempt, dyattempt
    try:
        uvr = lp.constructUnityVRexperiment(str(path.parent), path.name)
    except json.decoder.JSONDecodeError:
        print(f"Failed to read {path}, json is broken")
        return
    uvr.posDf = posAnalysis.computeVelocities(uvr.posDf) # Adds columns: vT, vR, vT_filt, vR_filt
    uvr.posDf = posAnalysis.position(uvr, derive=True) # Adds columns: ds, s, dTh, radangle

    # Pickle uvr object
    pickle_path = Path(PICKLE_FOLDER, path.with_suffix(".pickle").name)
    with open(pickle_path, "wb") as file:
        pickle.dump(uvr, file)

def main():
    # For bhv file in bhv folder(s)
    # If bhv file has not been parsed and pickled
    # Parse bhv file and pickle.

    parsed_files = [path.stem for path in PICKLE_FOLDER.rglob("*")]

    for path in BHV_FOLDER.rglob("*"):
        if not path.is_file():
            continue
        if path.stem in parsed_files:
            continue
        if (path.stat().st_size / (2**10)) < 200:
            # Skip files smaller than 200 KiloBytes
            continue
        parse_and_pickle(path)

if __name__ == "__main__":
    main()
