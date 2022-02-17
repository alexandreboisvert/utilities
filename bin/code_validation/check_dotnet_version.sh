#!/bin/bash

current_version=$(curl \
  --max-time 10 \
  --user-agent mozilla \
  --silent \
  'https://github.com/dotnet/core/releases/latest' \
| \
perl \
  -nE 'if (m/href=".*v([0-9]+\.[0-9]+\.[0-9]+)"/) { print $1 }')

if [[ -z "$current_version" ]]
then
  echo "[ FAIL ] dotnet: failure to get latest version from github"
  exit 1
fi

# not using --version, for 6.0.2 it gives back 6.0.200
local_version=$(dotnet --info \
| \
perl \
  -nE 'if (m#Microsoft.NETCore.App ([0-9]+\.[0-9]+\.[0-9]+)#) {print $1}')

if [[ "$local_version" == "$current_version" ]]
then
  echo "[  OK  ] dotnet current = $current_version, local = $local_version"
  exit 0
else
  echo "[ FAIL ] dotnet current = $current_version local = $local_version"
  exit 1
fi

