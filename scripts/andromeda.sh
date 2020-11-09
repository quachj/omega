#!/usr/bin/env bash

# full directory name of the script from where it is being called from.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_DIR/helpers.sh" --source-only

if [ "$#" == "0" ]; then
  echo "$USAGE"
  exit 1
fi

COMMAND=$1
APPNAME=${@: -1}
shift 2

if [[ $COMMAND == "create" ]]
then
  # echo "$COMMAND $APPNAME"
  yarn create react-app $APPNAME
else
  echo "invalid command: $COMMAND"
  echo "available commands [create]"
  exit 1
fi

exit 0

# NOTE:
# long options would need to be implemented for built in getopts.
# by adding colon in front of arguments passed to getopts
# we are telling getopts that we will handle options that are
# not in list. colon after option would require option value
# that is stored in $OPTARG ":crgo:"
while getopts ":crgc:" OPTION; do
  case $OPTION in
  b)
    COLOR=BLUE
    ;;
  r)
    COLOR=RED
    ;;
  c)
    COLOR=$OPTARG
    [[ ! $COLOR =~ BLUE|RED|GREEN ]] && {
      echo "Invalid option: $OPTARG" 1>&2
      exit 1
    }
    ;;
  \?)
    echo "invalid option: $OPTION"
    ;;
  :)
    echo "invalid option: $OPTION"
    ;;
  *)
    echo "invalid option: $OPTION"
    ;;
  esac
  # Shifting processed options
  shift $((OPTIND -1))
done

exit 0;


# echo "$@" # all arguments
# echo "$#" # number of arguments
# echo "$0" # script path
# echo "$1" # $N nth argument
# if [ -z "$1" ] # check empty string


# echo "Last argument only (works with bash/ksh only): ${@: -1}"
# echo "Last argument only (works with bash 3.x+ only): ${!#}"
# echo "Last argument only (works with bash 3.x+ only): $BASH_ARGV"
# echo "Last argument only (works with bash 3.x+ / ksh only): ${@:$#}"
# echo "Last argument only (works with bash 3.x+ only): ${BASH_ARGV[0]}"
# echo -n "Last argument only (portable version): "
# for i in $@; do :; done
# echo "$i"

