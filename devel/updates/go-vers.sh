#!/usr/bin/sh

# Ensures all Go version declarations have the value
# of the $GO_VERS environment variable

set -e

# return codes
EXIT_VAR_UNDEF=166
EXIT_VAR_INVALID=167

# required commands
SED=sed
GREP=grep

# confirm GO_VERS environment variable set
if [[ -z "$GO_VERS" ]]
then
    >&2 echo "error: variable GO_VERS is undefined. Aborting"
    exit $EXIT_VAR_UNDEF
fi

# confirm GO_VERS value conforms to semantic version
# values used by Go project
IS_VALID=true
VALID_VERS_REGEX='^[0-9]+(\.[0-9]+)*((rc|beta)[0-9]*)?$'
echo $GO_VERS | $GREP -Eq "$VALID_VERS_REGEX" || IS_VALID=false
if [[ "$IS_VALID" = false ]]
then
    >&2 echo "error: GO_VERS value "$GO_VERS" does not conform to a valid semantic version, "$VALID_VERS_REGEX". Aborting"
    exit $EXIT_VAR_INVALID
fi

# perform updates by editing known instances of
# the Go version number in place
"$SED" -i "s/go_vers=.*/go_vers=$GO_VERS/g" Dockerfile
"$SED" -i "s/^go .*/go $GO_VERS/g" go.mod
"$SED" -i "s/go-version: .*/go-version: $GO_VERS/g" .github/workflows/*