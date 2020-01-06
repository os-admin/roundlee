#!/usr/bin/env bash

function checkParam() {
    echo "enter recp <file list>";
}

case $# in 
    0 ) 
        checkParam;
        exit 1;
    ;;
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
