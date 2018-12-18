#!/bin/bash
SSH_X=f

alias rand32='head -c 4 /dev/random | od -D | awk "{print \$2}" | head -n1'

if ! have jot; then
    function rand() {
    	r=`rand32`
    	if [[ "$1x" = "x" ]]; then
    		echo $r
    	elif [[ "$2x" = "x" ]]; then
    		echo "$(( $r % ($1 + 1) ))"
    	else
    		echo "$(( ($r % ($2 - $1 + 1)) + $1 ))"
    	fi		
    }
else
    function rand() {
        jot -r 1 $1 $2
    }
fi

# stuff that changes every few months

export CSUSER=cs9f-aw
export EEUSER=ee20n-ih

function bhost() {
	if [[ "$1x" = "x" ]]; then
		firstMachine=9
		lastMachine=13
		machineNumber=`rand $firstMachine $lastMachine`
	else
		machineNumber=$1
	fi

	echo "hpse-${machineNumber}.eecs.berkeley.edu"
}

alias cshost='echo "${CSUSER}@`bhost`"'
alias eehost='echo "${EEUSER}@`bhost`"'

if [[ $SSH_X = t ]]; then
    export ssh='ssh -X'
else
    export ssh='ssh'
fi

alias sshcs='"$ssh" "`cshost`"'
alias sshee='"$ssh" "`eehost`"'

