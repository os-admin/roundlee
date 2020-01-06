#!/usr/bin/env bash

function checkParam() {
    echo "enter $0 [-d] <file list>";
    echo "     -d to stdout only";
}

chose=$1;
file="";
isallow=0

case $# in 
    0 ) 
        checkParam;
        exit 1;
    ;;

    1 ) 
        if [ $chose = "-d" ]
        then
            checkParam;
            exit;
        fi
    ;;

    * ) 
        if [ $chose = "-d" ]
        then
            isallow=1;
            shift;
        fi
esac

for f in $*;
do 
    filetype=${f##*.};
    case $filetype in
        js | ts | java | c | cpp ) 
            echo "// $f";
        ;;

        sh )
            echo "# $f";
        ;;
    
        html ) 
            echo "<!-- $f -->";
        ;;

        * )
            echo -e " file '$f' not supported yet! \n";
            exit 1
    esac
    cat $f;
    echo;
    # echo -e "\n";
done |  if [ $isallow -eq 0 ]
        then
            os=`uname -s`;
            case $os in 
                Linux )  
                    xclip -sel c;
                    echo "success";
                ;;
    
                Darwin ) 
                    pbcopy;  
                ;;
    
                * ) 
                    echo -e " OS '$os' not supported yet！\n";
                    exit 1;
            esac
        else 
            cat;
        fi 
