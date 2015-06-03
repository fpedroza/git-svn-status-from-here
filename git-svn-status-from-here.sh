#!/bin/bash

# Color Code for tput:
#   0 – Black
#   1 – Red
#   2 – Green
#   3 – Yellow
#   4 – Blue
#   5 – Magenta
#   6 – Cyan    
#   7 – White

for gitdir in `find ./ -name .git -type d`; 
    do 
        workdir=${gitdir%/*};
        echo
        tput smul;  # underline on
        echo $workdir;
        tput rmul;  # underline off

        # get the git commit status line count
        gitstatus=$(git -C $workdir status | wc -l); 
        if [ $gitstatus -gt 2 ]; then
            git -C $workdir status;
        fi

        # todo: first check to see if the directory is even connected to svn
        #git svn info --url
        #Unable to determine upstream SVN information from working tree history

        # get the svn commit status - trim the first line since it's not helpful
        svnstatus=$(git -C $workdir svn dcommit --dry-run | awk '{ if(NR>1) print }');
        if [[ ! -z $svnstatus ]]; then
          echo "- Local commits not yet pushed -";
          tput setaf 1;  # red font on
          echo $svnstatus;
          tput sgr0;  # font reset
        fi
    done
