import sys
import Checks
import cProfile, pstats, StringIO

output = {}
val = 0
for line in sys.stdin:

    numbers = line.split(" ")

    if val == 0:
        range = numbers[0]
        val += 1
        continue


    numberFirst = int(numbers[0])
    numberSecond = int(numbers[1])

    if numberFirst in output and output[numberFirst] != numberSecond:
        output[numberFirst].append(numberSecond)
    else:
        output[numberFirst] = [numberSecond]


#start profiler
pf = cProfile.Profile();
pf.enable();
isOnetoOne = Checks.CheckOne2One(output, int(range))
isOnto = Checks.CheckOnto(output, int(range))
isReflex = Checks.CheckReflex(output, int(range))
isSym = Checks.CheckSym(output, int(range))
isTrans = Checks.CheckTrans(output, int(range))
Checks.CheckFunc(output, int(range), isOnto, isOnetoOne)
if isReflex and isSym and isTrans:
    Checks.PrintPart(output, int(range))

#end profiler, print data
pf.disable()
s = StringIO.StringIO()
sortby = 'cumulative'
ps = pstats.Stats(pf, stream=s).sort_stats(sortby)
ps.print_stats()
print s.getvalue()
