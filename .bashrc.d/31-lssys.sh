#/bin/bash

# Shows the machine type and OS.

# I'm using xargs to trim whitespace.

function _round() {
    # Thanks, user85321!
    # From http://askubuntu.com/questions/179898/how-to-round-decimals-using-bc-in-bash
    #if have bc; then
    #    echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
    #else
        printf "%0.$2f" $1
    #fi
}

function _mhz2ghz() {
    # Convert MHz to GHz.
    # Adds the GHz unit at end. Removes mhz units if present.
    cpu_spd_mhz="`echo "$1" | tr -d 'mhzMHZ' | xargs`"
    cpu_spd="`awk -v cpu_spd_mhz=$cpu_spd_mhz "BEGIN { print cpu_spd_mhz/1000 }"`"
    if [[ "$cpu_spd" == [0,.]* ]]; then
        echo "$cpu_spd_mhz MHz"
        return
    fi
    cpu_spd="`_round $cpu_spd 1` GHz"
    echo "$cpu_spd"
}

function _kb2human() {
    # Convert KB to a more human-readable format.
    # Adds the proper unit at the end. Removes previous units if present.
    units=(
        KB
        MB
        GB
        TB
        PB
        EB
        )

    this="`echo "$1" | tr -d 'kbKB' | xargs`"
    next=
    for u in ${units[*]}; do
        next="`awk -v this=$this "BEGIN { print this/1024 }"`"
        if [[ "$next" == [0,.]* ]]; then
            echo "`_round $this 2` $u"
            return
        fi
        this=$next
    done
    echo "`round $this 2` ${units[${#units}]}"
}

function _clean_cpu_brand() {
    [[ "$OSTYPE" == solaris* ]] && sed=gsed || sed=sed
    $sed \
        -e 's/(R)//g' \
        -e 's/(TM)//g' \
        -e 's/CPU//g' \
        -e 's/@.*$//' \
        -e 's/ [0-9.]* *[MGmg][hH]z//g' |
        xargs
}

function lssys() {
    case $OSTYPE in
    darwin*)
        os_arch=$(uname -m)

        profsec=$(system_profiler SPHardwareDataType Hardware SPSoftwareDataType Software)
        ram=$(echo "$profsec" | grep "^ *Memory" | cut -d: -f2 | xargs)

        cpus=$(echo "$profsec" | grep "Number of Processors" | cut -d: -f2 | xargs)
        cpu_cores=$(echo "$profsec" | grep "Total Number of Cores:" | cut -d: -f2 | xargs)
        cpu_cores_per=$(( $cpu_cores / $cpus ))
        cpu_spd=$(echo "$profsec" | grep "Processor Speed" | cut -d: -f2 | xargs)
        cpu_brand=$(sysctl -n machdep.cpu.brand_string | cut -d: -f2 | _clean_cpu_brand)

        os_name=$(echo "$profsec" | grep "System Version" | cut -d: -f2 | cut -d'(' -f1 | xargs)

        kern_name=$(echo "$profsec" | grep "Kernel Version" | cut -d: -f2 | xargs)
        ;;
    linux*)
        os_arch=$(uname -p)
        [ $os_arch = unknown ] && os_arch="`uname -m`"

        ram_kb=$(grep MemTotal /proc/meminfo | grep -o '[[:digit:]]\+')
        ram=$(_kb2human $ram_kb)

        cpusec=$(cat /proc/cpuinfo | sort -u)
        cpus=$(echo "$cpusec" | grep "physical id" | wc -l | xargs)
        [ "${cpus:-0}" -eq 0 ] && cpus=1
        cpu_cores=$(echo "$cpusec" | grep "^processor" | wc -l | xargs)
        cpu_cores_per=$(echo "$cpusec" | grep "siblings" | cut -d: -f2 | xargs)
        cpu_spd_mhz=$(echo "$cpusec" | grep "cpu MHz" | cut -d: -f2 | xargs)
        [ -z "$cpu_spd_mhz" ] && cpu_spd_mhz=$(awk \
            -v cpu_spd_khz=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq) \
            'BEGIN { print cpu_spd_khz/1000 }')
        cpu_spd=$(_mhz2ghz "$cpu_spd_mhz")
        cpu_brand=$(echo "$cpusec" | grep "model name" | cut -d: -f2 | _clean_cpu_brand)

        sourced_release=n
        release_source_candidates=(
            /etc/os-release
            /etc/lsb-release
            )
        release_nonsource_candidates=(
            /etc/system-release
            /etc/release
            /etc/redhat-release
            /etc/centos-release
            )
        for f in ${release_source_candidates[*]}; do
            if [ -e "$f" ] && grep '=' "$f" &>/dev/null; then
                source "$f"
                sourced_release=y
                break
            fi
        done

        if [ "$sourced_release" = y ]; then
            [ -z "$NAME" ] && [ -n "$DISTRIB_ID" ] &&
                NAME="$DISTRIB_ID"

            [ -z "$VERSION" ] && [ -n "$DISTRIB_RELEASE" ] &&
                VERSION="$DISTRIB_RELEASE"

            [ -n "$DISTRIB_CODENAME" ] &&
                ( ! echo "$VERSION" | grep -ri "$DISTRIB_CODENAME" &>/dev/null ) &&
                VERSION="${VERSION} (${DISTRIB_CODENAME})"

            if [ -n "$NAME" ] && [ -n "$VERSION" ]; then
                os_name="${NAME} ${VERSION}"
            elif [ -n "$PRETTY_NAME" ]; then
                os_name="$PRETTY_NAME"
            elif [ -n "$NAME" ] && [ -n "$VERSION_ID" ]; then
                os_name="${NAME} ${VERSION_ID}"
            elif [ -n "$NAME" ]; then
                os_name="$NAME"
            fi
        else  # couldn't *source* a release file containing variables
            for f in ${release_nonsource_candidates[*]}; do
                if [ -e "$f" ]; then
                    os_name=$( head -n1 "$f" | xargs )
                    break
                fi
            done
        fi

        ;;
    cygwin*)
        ram_kb=$(grep MemTotal /proc/meminfo | grep -o '[[:digit:]]\+')
        ram=$(_kb2human "$ram_kb")

        os_arch=$(uname -m)

        sysinfosec=$(echo \
            'os get Caption,CSDVersion,Version /value
            cpu get DeviceID,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed,Name /value
            exit' |
            cmd /c 'wmic' 2>/dev/null |
            grep -r '=')

        cpus="`echo "$sysinfosec" | grep -o "CPU[0-9]\+" | wc -l | xargs`"
        cpu_cores="`echo "$sysinfosec" | grep NumberOfCores | cut -d'=' -f2 | xargs`"
        cpu_lcores="`echo "$sysinfosec" | grep NumberOfLogicalProcessors | cut -d'=' -f2 | xargs`"
        [[ -n $cpus && -n $cpu_cores ]] && 
            cpu_cores_per="$(( $cpu_cores / $cpus ))"
        cpu_spd_mhz="`echo "$sysinfosec" | grep MaxClockSpeed | cut -d'=' -f2 | xargs`"
        cpu_spd="`_mhz2ghz "$cpu_spd_mhz"`"
        cpu_brand="$( echo "$sysinfosec" | grep Name | cut -d'=' -f2 | _clean_cpu_brand )"

        os_major="`echo "$sysinfosec" | grep Caption | cut -d'=' -f2 | xargs`"
        os_sp="`echo "$sysinfosec" | grep CSDVersion | cut -d'=' -f2 | xargs`"
        os_build="`echo "$sysinfosec" | grep '^Version' | cut -d'=' -f2 | xargs`"

        os_name="$os_major"
        [[ -n $os_sp ]] && os_name="$os_name, $os_sp"
        [[ -n $os_build ]] && os_name="$os_name [$os_build]"

        kern_ver="`uname -r | cut -d'(' -f1 | xargs`"
        [[ $os_arch != 'x86_64' ]] && kern_arch='x86' || kern_arch="$os_arch"
        kern_name='Cygwin'
        [[ -n $kern_ver ]] && kern_name="$kern_name $kern_arch $kern_ver"
        ;;
    solaris*)
        # Must explicitly call gtail and gsed.

        os_arch="`uname -p`"

        prtdiagseg="`prtdiag`"

        ram="`echo "$prtdiagseg" | grep 'Memory size:' |
            cut -d' ' -f3- | xargs`"
        #ram_spd="`echo "$prtdiagseg" | grep 'System clock frequency:' |
        #   cut -d' ' -f4- | xargs`"

        cpusec="`echo "$prtdiagseg" |
            gsed -n '/==\+ CPUs/,/==\+/p' |
            grep '^[0-9]' |
            gtail -n1 |
            xargs`"

        cpus="`echo "$cpusec" | cut -d' ' -f1`"
        [[ $cpus != '' ]] && cpus=$(( $cpus + 1 ))

        cpu_spd="`echo "$cpusec" | cut -d' ' -f2-3`"
        [[ $cpu_spd = *[mM][hH][zZ] ]] && cpu_spd="`_mhz2ghz $cpu_spd`"

        cpu_brand="`echo "$cpusec" | cut -d' ' -f5`"

        os_name="`head -n1 /etc/release | xargs |
            ggrep -o '^[^0-9]\+[0-9.]\+' | xargs`"

        #os_date="`gtail -n1 /etc/release | xargs`"

        ;;
    esac


    machine_info=''

    [[ -n ${os_name} ]]         && machine_info="${machine_info}\n  ${os_name}"
    [[ -n ${kern_name} ]]       && machine_info="${machine_info}\n    ${kern_name}"

    cpu_info=''
    [[ -n ${cpus} ]]            && cpu_info="${cpu_info}${cpus}x "
    [[ -n ${cpu_cores_per} ]]   && cpu_info="${cpu_info}${cpu_cores_per}-core "
    [[ -n ${cpu_spd} ]]         && cpu_info="${cpu_info}${cpu_spd} "
    [[ -n ${cpu_brand} ]]       && cpu_info="${cpu_info}${cpu_brand} "

    cpu_total_cores=''
    [[ -n ${cpu_cores} ]]       && cpu_total_cores="${cpu_total_cores}${cpu_cores} cores total"
    [[ -n ${cpu_lcores} ]]      && cpu_total_cores="${cpu_total_cores}, ${cpu_lcores} logical cores"
    [[ -n ${cpu_total_cores} ]] && cpu_info="${cpu_info}\n    (${cpu_total_cores})"

    [[ -n ${cpu_info} ]]        && machine_info="${machine_info}\n  ${cpu_info}"

    [[ -n $ram ]]               && machine_info="${machine_info}\n  ${ram} RAM"
    [[ -n $os_arch ]]           && machine_info="${machine_info}\n  ${os_arch} architecture"

    [[ -n "$cpu_info" ]]        && echo -e "This machine:${machine_info}"
}

