def concatFile(repo):  # cat repo ; rm tmp file
    if len(os.listdir(repo)) != 0:
        str1 = "cat " + repo + "/* > " + repo + ".fna; rm -r " + repo
    else:
        str1 = "rm -r " + repo
    content = os.popen(str1).read()

