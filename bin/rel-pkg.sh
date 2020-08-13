#!/usr/bin/env bash

# --- Config

version=0.14
stage="post"

if [ $stage = "pre" ]
then
  branch=pkg-branch-pre-v$version
  dep_branch=release-$version
else
  branch=pkg-branch-post-v$version
  dep_branch=master
fi

# --- Script

echo "🐎 sync"
git ns sync
echo "🐎 checkout $branch"
git ns checkout $branch 

# tomles is https://github.com/n3wscott/tomles
tomles update knative.dev/pkg -b $dep_branch -f ./Gopkg.toml
tomles update knative.dev/test-infra -b $dep_branch -f ./Gopkg.toml
tomles update knative.dev/serving -b $dep_branch -f ./Gopkg.toml
tomles update knative.dev/eventing -b $dep_branch -f ./Gopkg.toml

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

echo '🐎 ./hack/update-deps.sh --upgrade'
./hack/update-deps.sh --upgrade

echo '🐎 ./hack/update-codegen.sh'
./hack/update-codegen.sh

git add . 

git commit -m "Updating pkg to latest."

echo '🐎💨 pushing'
git push

if [ $stage = "pre" ]
then

echo "✨Done✨ Now use the following PR template:
====================================
[WIP] Updating pkg to latest for $version release.
====================================
## Proposed Changes

- Prepping for $version release.
- Update knative.dev/pkg to latest from branch $dep_branch.

**Release Note**

\`\`\`release-note
NONE
\`\`\`

/cc mattmoor 
------------------------------------
"

else

echo "✨Done✨ Now use the following PR template:
====================================
Updating pkg to $dep_branch post $version release.
====================================
## Proposed Changes

- Move pkg/test-infra back to $dep_branch post $version release.
- Update to latest from branch $dep_branch.

**Release Note**

\`\`\`release-note
NONE
\`\`\`

/cc mattmoor 
------------------------------------
"
fi

git ns open