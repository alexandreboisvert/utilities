#!/usr/bin/env bash

# Generate filler text: the infamous "Lorem ipsum"

set -e
set -o pipefail

lorem_text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eleifend ante vitae turpis venenatis, eu placerat nunc tincidunt. Nam sit amet augue malesuada, luctus nisi nec, pharetra erat. Suspendisse vel velit id nibh scelerisque euismod. Nullam sollicitudin, mi nec vehicula sodales, arcu quam rhoncus erat, ut ultricies urna quam sed nunc. Aenean ornare pharetra sollicitudin. Nulla vestibulum nisi ac malesuada commodo. Sed auctor augue sed tortor tempus aliquam. Sed fringilla velit sed convallis malesuada. Morbi ligula nibh, tempor at erat quis, pulvinar tristique justo. Nam nec efficitur tortor."

print_help() {
  echo "Lorem ipsum text generator"
  echo "Options:"
  echo "help : Show this help and exit."
  echo "000  : How many paragraphs of Lorem Ipsum text required.";
}

if [[ -z "$1" ]]
then
  print_help
  exit 1
fi

if [[ "$1" == "help" ]]
then
  print_help
  exit 0
fi

if echo "$1" | grep -q -o -E '^[0-9]+$'
then
  yes "${lorem_text}" | head -n "$1"  
else
  echo "invalid number, see 'help'"
  exit 1
fi
