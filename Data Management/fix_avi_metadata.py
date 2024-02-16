# fix_avi_metadata.py
# Created: 2024/02/15

from pathlib import Path
import argparse
import ffmpeg

DEFAULT_VIDEO_FOLDER = Path(r"Z:\Live Fly Imaging data\fictrac")

def parse_args():
    """Parse arguments

    Returns:
        Namespace: args object. Access the folder path with args.folder.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--folder','-f', type=str, action='store', help="folder with avi's")
    args = parser.parse_args()
    return args

def get_ffmpeg_duration(video_path):
    """get the duration of a video with ffmpeg probe.

    Args:
        video_path (Path): Path to video file.

    Returns:
        float|None: Duration of the video. returns None if there is no duration metadata.
    """
    # https://stackoverflow.com/questions/3844430/how-to-get-the-duration-of-a-video-in-python
    info = ffmpeg.probe(video_path.as_posix())
    duration = info['format'].get('duration')
    return duration

def fix_avi_metadata(video_path, tempdir):
    """fixes the avi metadata by passing it through ffmpeg

    Args:
        video_path (Path): Path to video file.
        tempdir (Path): Temporary directory to store videos,
                        since there is no in place editing with ffmpeg.
    """
    # Call ffmpeg through cmdline
    new_video_path = Path(tempdir, video_path.name)

    # Fix video metadata
    (ffmpeg
    .input(video_path.as_posix(), fflags="+genpts")
    .output(new_video_path.as_posix(), vcodec="copy")
    .run(overwrite_output=True, quiet=True))

    # Replace old file with new file.
    new_video_path.replace(video_path)

def main():
    """Fixes the metadata of all avi files in the given folder.
    Parses the folder with videos and uses a default folder if none is given.
    Then a temp directory is created to store files during processing.
    Each .avi file that is larger than 100 bytes is healed.
    Then the temp directory is removed.
    """
    args = parse_args()
    try:
        video_folder = Path(args.folder)
    except TypeError:
        video_folder = DEFAULT_VIDEO_FOLDER

    # Create temporary folder
    tempdir = Path(video_folder, "temp")
    tempdir.mkdir(exist_ok=True)

    for video_path in video_folder.rglob("*"):
        if video_path.suffix != ".avi":
            continue
        if video_path.stat().st_size <= 100:
            continue
        try:
            duration = get_ffmpeg_duration(video_path)
        except ffmpeg._run.Error:
            # Skip file if it fails ffprobe
            continue
        if duration is None:
            fix_avi_metadata(video_path, tempdir)

    # Delete temporary folder
    tempdir.rmdir()

if __name__ == "__main__":
    main()
