import sys
import cProfile, pstats, StringIO
import memory_profiler
from memory_profiler import profile


def readInput():
    output = {}
    val = 0
    for line in sys.stdin:

        numbers = line.split(" ")

        if val == 0:
            size = numbers[0]
            val += 1
            continue


        numberFirst = int(numbers[0])
        numberSecond = int(numbers[1])

        if numberFirst in output and output[numberFirst] != numberSecond:
            output[numberFirst].append(numberSecond)
        else:
            output[numberFirst] = [numberSecond]
    return output, size

def PrintPart(output, range):
    counter = 1
    shown = {}
    foundOne = False
    if range > 40:
        size = len(output)
        print "Number of partitions:", size

    else:
        while counter <= range:
            if counter in output:
                for value in output[counter]:
                    if value in shown:
                        continue
                    else:
                        sys.stdout.write(str(value))
                        sys.stdout.write(" ")
                        shown[value] = 1
                        foundOne = True
                if foundOne:
                    print "\n"
                    foundOne = False
            else:
                continue
            counter +=1

            # print "\n"



    #old but useful, keep this
    # counter = 1
    # shown = {}
    # if range > 40:
    #     size = len(output)
    #     print "Number of partitions:", size
    #
    # else:
    #     while counter <= range:
    #         if counter in output:
    #             i = 1
    #             while i <= range:
    #
    #                 if i in output[counter]:
    #                     sys.stdout.write('1 ')
    #                     i+=1
    #                 else:
    #                     sys.stdout.write('0 ')
    #                     i+=1
    #             print counter
    #
    #         else:
    #             i = 0
    #             while i < range:
    #                 sys.stdout.write('0 ')
    #                 i+=1
    #             print counter
    #
    #         counter += 1
@profile
def CheckOne2One(output, range):
#def CheckOne2One():


    print "\n"
    #output, range = readInput()

    for i in output:

        #if a key holds more than one value, not one to one
        if len(output[i]) > 1:
            print "Is not one to one"
            return False
    #if it makes it this far, is one to one

    print "Is one to one"
    return True

@profile
def CheckOnto(output, size):
#def CheckOnto():
    print "\n"
    # output, size = readInput()
    size = int(size)
    found = False
    for count in range (1,size+1):

        #looking for count in only the values, which represents the range
        for key in output:
            if count in output[key]:
                found = True
                break

        if found:
            found = False
            continue
        else:
            print "Is not onto"
            return False

    #if it makes it this far, is onto
    print "Is onto"
    return True

@profile
def CheckReflex(output, size):
# def CheckReflex():
    print "\n"
    # output, size = readInput()

    size = int(size)

    for count in range (1, size+1):
        if count in output and count in output[count]:
            continue
        else:
            print "Is not reflexive"
            isReflex = False
            return False

    isReflex = True
    print "Is reflexive"
    return True
@profile
def CheckSym(output, size):
# def CheckSym():
    print "\n"
    # output, size = readInput()

    for key in output:
            for value in output[key]:
                if value not in output: #if the value is not a key itself, it is not sym
                    print "Is not symmetric"
                    # print output
                    isSymm = False
                    return False
                else:
                    if key in output[value]:#if counter is a value in the dict, is okay
                        continue
                    else:
                        print "Is not symmetric"
                        # print output
                        isSymm = False
                        return False

    isSymm = True
    print "Is symmetric"
    return True
@profile
def CheckTrans(output, size):
# def CheckTrans():
    print "\n"
    # output, size = readInput()

    for a in output:
        #if a == b
        for b in output[a]:
            if b in output:
                #and b == c
                for c in output[b]:
                    #then a == c
                    if c in output[a] or c == a:
                        continue
                    else:
                        print "Is not transitive"
                        isTrans = False
                        return False
            else:
                #a == b, but b !== c
                continue
    isTrans = False
    print "Is transitive"
    return True
@profile
def CheckFunc(output, size, onto, one2one):
# def CheckFunc():
    print "\n"
    # output, size = readInput()

    for i in range (1,4):
        if i in output:
            if len(output[i]) > 1:
                testVal = output[i][0]
                for value in output[i]:
                    if value != testVal:
                        print "Is not a function"
                        return
        else:
            print "Is not a function"
            return

    print "Is function"
    return
