from time import process_time


def time(func):
    t1_start = process_time()
    func
    t1_stop = process_time()
    print(f'time : {t1_stop - t1_start}')

def progress(iteration, steps, max_value, no_limit=False):
    if int(iteration) == max_value:
        if no_limit == True:
            sys.stdout.write('\r')
            print("[x] \t%d%%" % (100), end='\r')
        else:
            sys.stdout.write('\r')
            print("[x] \t%d%%" % (100))
    elif int(iteration) % steps == 0:
        sys.stdout.write('\r')
        print("[x] \t%d%%" % (float(int(iteration) / int(max_value)) * 100), end='\r')
        sys.stdout.flush()
    else:
        pass
