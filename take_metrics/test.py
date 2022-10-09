import subprocess
import time

print 'Taking info...'

pid = int(subprocess.check_output(["./take_metrics","-pid"]))
fgc_start = int(subprocess.check_output(["./take_metrics","-fgc"]))
print '{0:8} {1:3} {2:8} {3:3}'.format('Service PID:', pid, 'FGC count:', fgc_start)

print 'Look jstat'
print '{0:8} {1:8} {2:8}'.format('EDEN','OLD','FGC')

eden_count = str(subprocess.check_output(["./take_metrics","-eden"])).strip()
old_count = str(subprocess.check_output(["./take_metrics","-old"])).strip()


for i in range(1):
        fgc_count = int(subprocess.check_output(["./take_metrics","-fgc"]))

        if fgc_count > fgc_start:
                fgc_diff = fgc_count - fgc_start

        print '{0:8} {1:8} {2:3}'.format(eden_count, old_count, fgc_count)
        time.sleep(5)

print 'Done. Now FGC is:', fgc_count


class_list = subprocess.check_output(["./take_metrics","-jmap"])
print '\n', class_list
