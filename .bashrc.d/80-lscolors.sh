## From the OSX ls manpage:
# The value of LSCOLORS describes what color to use for which attribute when 
# colors are enabled with CLICOLOR.  This string is a concatenation of pairs of
# the format fb, where f is the foreground color and b is the background color.
#
# The color designators are as follows:
#       a     black
#       b     red
#       c     green
#       d     brown
#       e     blue
#       f     magenta
#       g     cyan
#       h     light grey
#       A     bold black, usually shows up as dark grey
#       B     bold red
#       C     bold green
#       D     bold brown, usually shows up as yellow
#       E     bold blue
#       F     bold magenta
#       G     bold cyan
#       H     bold light grey; looks like bright white
#       x     default foreground or background
#
# Note that the above are standard ANSI colors.  The actual display may 
# differ depending on the color capabilities of the terminal in use.
#
# The order of the attributes are as follows:
#       1.   directory
#       2.   symbolic link
#       3.   socket
#       4.   pipe
#       5.   executable
#       6.   block special
#       7.   character special
#       8.   executable with setuid bit set
#       9.   executable with setgid bit set
#       10.  directory writable to others, with sticky bit
#       11.  directory writable to others, without sticky bit
#
# The default is "exfxcxdxbxegedabagacad", i.e. blue foreground and default 
# background for regular directories, black foreground and red background for 
# setuid executables, etc.
case $OSTYPE in
darwin*)
    export LSCOLORS=gxfxcxdxbxgeedagacad
    ;;
linux*)
    thisdir="${HOME}/.bashrc.d"
    conf="${thisdir}/_dircolors.conf"
    sh="${thisdir}/_dircolors.sh"
    
    dircolors_cmd="dircolors ${conf}"

    # Create an empty file if it doesn't exist, for diffing.
    [[ -e "$sh" ]] || touch "$sh"
    
    # Update if out of date
    if  [[ "`($dircolors_cmd | diff "$sh" -)`" != '' ]]; then
        #echo "${conf} has changed! Updating..."
        $dircolors_cmd > "$sh"
    fi
    
    # if our sh is different from the default, run it
    if [[ "`dircolors | diff "$sh" -`" != '' ]]; then
        . "$sh"
    fi
    ;;
solaris*)
    thisdir="${HOME}/.bashrc.d"
    conf="${thisdir}/_dircolors.conf"
    sh="${thisdir}/_dircolors.sh"

    if have gdircolors; then
        dircolors_cmd="gdircolors"
    else
        dircolors_cmd="dircolors"
    fi
    
    # Create an empty file if it doesn't exist, for diffing.
    [[ -e "$sh" ]] || touch "$sh"

    # Update if out of date
    if  [[ "`($dircolors $conf | diff "$sh" -)`" != '' ]]; then
        #echo "${conf} has changed! Updating..."
        $dircolors $conf > "$sh"
    fi

    # if our sh is different from the default, run it
    if [[ "`$dircolors | diff "$sh" -`" != '' ]]; then
        . "$sh"
    fi
    ;;
esac


