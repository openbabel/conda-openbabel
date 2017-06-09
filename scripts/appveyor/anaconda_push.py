import os
import glob
import subprocess
import traceback

token = os.environ['ANACONDA_TOKEN']
branch = os.environ['APPVEYOR_REPO_BRANCH']
cmd = ['anaconda', '-t', token, 'upload', '--force']
cmd.extend(glob.glob('*.tar.bz2'))

if branch == 'master':  # Upload only from master branch
    try:
        subprocess.check_call(cmd)
    except subprocess.CalledProcessError:
        traceback.print_exc()
