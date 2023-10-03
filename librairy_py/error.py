import pathlib
import sys
import os

def mkdir_exist(repoP):  # creation repertoire
    if not os.path.exists(repoP):
        os.makedirs(repoP)


def file_exist(filepath):  # test if file existe
    file_p = pathlib.Path(filepath)
    if not file_p.exists():
        sys.exit("Error message:\n\n!!! " + filepath + "file not exist !!!\n\n")
    return file_p


def file_exit_func(filepath, func):  # test if file existe
    file_p = pathlib.Path(filepath)
    if file_p.exists():
        print('  !! ' + filepath + ' ok')
        r = func(filepath)
    else:
        sys.exit("Error message:    \n\n!!! " + filepath + "file not exist !!!\n\n")
    return r

