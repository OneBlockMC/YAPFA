#!/usr/bin/env bash
(
set -e
PS1="$"

function changelog() {
    base=$(git ls-tree HEAD $1 | cut -d' ' -f3 | cut -f1)
    cd $1 && git log --oneline ${base}...ORIGIN/HEAD
}
tuinity=$(changelog Tuinity)
#paper=$(changelog Tuinity/Paper)

updated=""
logsuffix=""
if [ ! -z "$tuinity" ]; then
    logsuffix="$logsuffix\n\nTuinity Changes:\n$tuinity"
    if [ -z "$updated" ]; then updated="Tuinity"; else updated="$updated/Tuinity"; fi
fi
#if [ ! -z "$paper" ]; then
#    logsuffix="$logsuffix\n\nPaper Changes:\n$paper"
#    if [ -z "$updated" ]; then updated="Paper"; else updated="$updated/Paper"; fi
#fi
disclaimer="Upstream has released updates that appears to apply and compile correctly"

if [ ! -z "$1" ]; then
    disclaimer="$@"
fi

log="${UP_LOG_PREFIX}Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"

echo -e "$log"

) || exit 1