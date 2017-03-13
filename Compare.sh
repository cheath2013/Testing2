#!/bin/bash
USAGE="Usage: $0 nums..."
if [ "$#" == "0" ]; then
echo "$USAGE"
exit 1
fi

TESTSITE=cheath2013@cs-scompute.cs.fit.edu
TESTPATH=/home/fit.edu/kgallagher/public_html/sampleprogs/
ORACLEPATH=/home/fit.edu/kgallagher/public_html/oracles/

GENERATORS=(
              func
              reflex
              onetoone
              onto
              sym
              trans
              # ref.sym
              # ref.trans
          )
TARGETS=(
             CheckFunc
             CheckReflex
             CheckOne2One
             CheckOnto
             CheckSym
             CheckTrans
        )

echo "Beggining Tests....."
printf "\n"
numDiffs=0

#
for ((II=0; II < ${#GENERATORS[@]}; ++II)) do
  # Runs generator against oracle first sampleprogs | oracle
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | ssh $TESTSITE $ORACLEPATH${GENERATORS[II]} > server.txt

  # Then runs generator against each matching function in Checks.py
  # python -c 'import filename; filename.functionname()' calls a specific function from a python script
    if [[ "$II" -eq 0 ]]; then
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | python -c 'import Checks; Checks.CheckFunc()' > program.txt
    fi
    if [[ "$II" -eq 1 ]]; then
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | python -c 'import Checks; Checks.CheckReflex()' > program.txt
    fi
    if [[ "$II" -eq 2 ]]; then
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | python -c 'import Checks; Checks.CheckOne2One()' > program.txt
    fi
    if [[ "$II" -eq 3 ]]; then
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | python -c 'import Checks; Checks.CheckOnto()' > program.txt
    fi
    if [[ "$II" -eq 4 ]] || [[ "$II" -eq 6 ]]; then
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | python -c 'import Checks; Checks.CheckSym()' > program.txt
    fi
    if [[ "$II" -eq 5 ]] || [[ "$II" -eq 7 ]]; then
      ssh $TESTSITE $TESTPATH${GENERATORS[II]} $1 $2 | python -c 'import Checks; Checks.CheckTrans()' > program.txt
    fi

    # Display server and program output
    echo "Server output----->" $(<server.txt)
    echo "Program output---->" $(<program.txt)

    # If there is a difference, display the difference in form of server out-------> program out
    DIFF=$(diff -B "server.txt" "program.txt")
    if [ "$DIFF" != "" ]
    then
    numDiffs=$((numDiffs+1))
    echo "A difference was detected: ", $DIFF
  else
    echo "No Differences detected in output of" ${GENERATORS[II]} "and" ${TARGETS[II]}
    fi

    printf "\n"

  done
  echo "Testing run with arguments " $1 "and" $2
  echo "Total number of differences found:" $numDiffs

  #if there are no differences, show example diff output
  if [[ "$numDiffs" -eq 0 ]]; then
    echo " "
    echo "Sample Difference output:"
    echo " "
    ssh $TESTSITE $TESTPATH${GENERATORS[0]} $1 $2 | python -c 'import Checks; Checks.CheckOnto()' > program.txt
    DIFF=$(diff -B "server.txt" "program.txt")
    echo "Difference detected", $DIFF
  fi
