#!/bin/bash
#######################################################################
#                                                                     #
#   Bash_login file                                                   #
#                                                                     #
#   commands to perform from the bash shell at login time             #
#   (sourced from .bash_profile)                                      #
#                                                                     #
#######################################################################

if [[ "$PS1" == '' ]]; then
    return
fi

## Settings prelude...
export BASHRC_debug=1

[[ -z $BASHRC_debug ]] && export BASHRC_debug=0

#settings="${HOME}/.bashrc-settings"
#if [[ -e ${settings} ]]; then
#    settings="`sed 's/#.*$//' ${settings} | awk 'NF > 0'`"
#    function getSetting() {
#        name="$1"
#        default="$2"
#        result="`echo ${settings} | grep "^${name}" | cut -d'=' -f2-`"
#        [[ "x$result" = 'x' ]] && result="${default}"
#        echo $result
#    }
#
#    export BASHRC_debug="`getSetting debug 0`"
#
#    (( $BASHRC_debug >= 1 )) && echo "BASHRC_debug=$BASHRC_debug"
#    unset getSetting
#fi



## Meat
(( $BASHRC_debug >= 2 )) && echo "Running ~/.bashrc ..."


## Berkeley EECS stuff
# Set the Class MASTER variable and source the class master version of .cshrc
[[ -z ${MASTER} ]] && export MASTER=${LOGNAME%-*}
[[ -z ${MASTERDIR} ]] && export MASTERDIR=$(eval echo ~${MASTER})

if [[ -d ${MASTERDIR}/adm/bashrc.d/ ]]; then
    (( $BASHRC_debug >= 1)) && echo ">> Loading Berkeley EECS master rc's..."

    # Set up class wide settings
    ## Disabled, because of a bug in their script, borking the which command
    ## under Solaris
    for file in ${MASTERDIR}/adm/bashrc.d/* ; do
        [[ -x ${file} ]] &&
            . "${file}"
    done 2>/dev/null #&1 | grep quota

    [[ ! -e ${MASTERDIR}/grading/register/${LOGNAME} ]] &&
        [[ -x /share/b/grading/bin/register ]] &&
        /share/b/grading/bin/register
fi

## Set up local settings
(( $BASHRC_debug >= 1 )) && echo ">> Loading local rc's..."
if [[ -d ~/.bashrc.d ]]; then
    for file in ~/.bashrc.d/* ; do
        if [[ -x ${file} ]] && [[ -f ${file} ]]; then
            (( $BASHRC_debug >= 3 )) && echo "Running ${file} ..."
            (( $BASHRC_debug >= 4 )) &&
                time . "$file" ||
                . "${file}"
        fi
    done
fi



## Settings finale...
unset BASHRC_debug
export CHAIMLEIBSDOTFILES=1

