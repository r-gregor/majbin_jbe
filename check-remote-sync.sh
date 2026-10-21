#! /usr/bin/env bash

LOCAL_BRANCH=$1
REMOTE_BRANCH="${2:-main}/$1"

if [ x"$(git rev-parse $LOCAL_BRANCH)" != x"$(git rev-parse $REMOTE_BRANCH)" ]
then
    echo "$LOCAL_BRANCH is not in sync with $REMOTE_BRANCH. You may want to rebase (pull) or push first."
else
    echo "$LOCAL_BRANCH and $REMOTE_BRANCH are synced. "
fi

