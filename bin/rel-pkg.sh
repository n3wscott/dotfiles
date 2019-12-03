#!/usr/bin/env bash

# --- Config

version=0.9
#branch=pkg-branch-v$version
branch=wip-pkg-branch-v$version
dep_branch=release-$version
#dep_branch=master

# --- Script

echo "🐎 sync"
git ns sync
echo "🐎 checkout $branch"
git ns checkout $branch 


# TODO: do this later...
# echo "Fixing pkg branch."

# gsed -i '/[[override|]]\n  name = "github.com\/knative\/pkg"/!b;n;n;c\ \ branch = "'"$dep_branch"'"' Gopkg.toml
# gsed '/\[\[(override|constraint)\]\]\n  name = "github.com\/knative\/pkg"/!b;n;n;c\ \ branch = "'"$dep_branch"'"' Gopkg.toml


tomles update knative.dev/pkg -b $dep_branch -f ./Gopkg.toml

IS_DEP_BRANCH=`grep 'knative.dev/pkg' -B1 -A2 Gopkg.toml | \
   grep -E 'override|contraint' -A3 | \
   grep "$dep_branch"`

if [ -z "$IS_DEP_BRANCH" ] 
then
  echo "💥: knative/pkg not set to $dep_branch."
  grep 'knative/pkg' -B1 -A2 Gopkg.toml | \
     grep -E 'override|contraint' -A3
  mate Gopkg.toml
  exit
else 
  echo "✅: knative/pkg set to $dep_branch."
fi

echo '🐎 dep ensure update for knative.dev/pkg'
dep ensure -update knative.dev/pkg

echo '🐎 ./hack/update-codegen.sh'
./hack/update-codegen.sh

git add . 

git commit -m "Updating pkg to latest."

echo '🐎💨 pushing'
git push

echo "✨Done✨ Now use the following PR template:
====================================
[WIP] Updating pkg to latest for $version release.
====================================
## Proposed Changes

- Prepping for $version release. Update knative.dev/pkg to latest from branch $dep_branch.

**Release Note**

\`\`\`release-note
NONE
\`\`\`

/cc @mattmoor 
------------------------------------
"

git ns open