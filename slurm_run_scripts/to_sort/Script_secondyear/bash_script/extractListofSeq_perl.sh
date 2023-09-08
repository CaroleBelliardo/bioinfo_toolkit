#!/bin/bash
usage () { echo 'Usage:' $0 ' [-l "list seq id"] [-f "fasta"] [-o "output"] '; }


while getopts ":l:f:o:" opt; do # : after args
  case ${opt} in
    l ) l=${OPTARG} ;;
    f ) f=${OPTARG} ;;
    o ) o=${OPTARG} ;;
    \? ) usage ;; # 
    *)  echo Unknown option: $OPTARG.;;
#    h ) echo usage; exit;; # echo "Usage: cmd [-l] [-f] [-o] " ;;
 #   \? ) echo "Unknown option: -$OPTARG" ; exit 1;;  
  esac
done

if ((OPTIND == 1))
then
    echo "No options specified, see -h option for usage"
fi

shift "$((OPTIND-1))" # removes all the options that have been parsed by getopts


perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' ${l} ${f} > ${o}

echo  ${o} 'ok!' >> extractListSeq.log
