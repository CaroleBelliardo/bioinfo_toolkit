import multiprocessing as mp

def parrallelize(func, jobL) :
    pool = mp.Pool(70)
    for i, _ in enumerate(pool.imap_unordered(func, jobL), 1):
        progress(i, 1, len(jobL))

