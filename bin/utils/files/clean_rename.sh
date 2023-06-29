#!/usr/bin/env bash

# Rename each provided file with a more "acceptable" name

if [[ -z "$1" ]]
then
  echo "provide a list of files"
  echo 'Replace all the characters that are not "[:alnum:].-/" with "_"'
  echo '(the "+" sign is also replaced'
  echo 'If the name is OK do not attempt the mv command'
  exit 1
fi

for current_name in "$@"
do
  # Important to have . and / in the regex, without it the results
  # could be incorrect.
  new_name=$(echo -n "${current_name}" | tr -c '[:alnum:].\-/' '_')
  new_name=$(echo -n "${new_name}" | tr '\+' '_')
  if [[ "${new_name}" == "${current_name}" ]]
  then
    echo "clean name already: ${current_name}"
  else
    mv -v "${current_name}" "${new_name}"
  fi
done
