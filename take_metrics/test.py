import subprocess
import time

pid = int(subprocess.check_output(["./take_metrics","-pid"]))
print(pid)

fgc_start = int(subprocess.check_output(["./take_metrics","-fgc"]))
print 'start at -', fgc_start

for i in range(6):
        fgc_count = int(subprocess.check_output(["./take_metrics","-fgc"]))

        if fgc_count > fgc_start:
                print'FGC is growth -', fgc_count

                fgc_diff = fgc_count - fgc_start
                print 'FGC diff is:', fgc_diff
        else:
                print fgc_start, '=', fgc_count

        time.sleep(5)

print 'Done. Now FGC is:', fgc_count

