#!/bin/sh -l

set -e

# Key scan for github.com
ssh-keyscan github.com > /root/.ssh/known_hosts

# Set ssh key for subtree
echo "${INPUT_DEPLOY_KEY}" >> /root/.ssh/subtree
chmod 0600 /root/.ssh/subtree

# Resolve downstream branch.
# If not set then use the event github ref, if the ref isn't set default to master.
if [ "$INPUT_BRANCH" == "" ]; then
	if [ -z "$GITHUB_REF" ] || [ "$GITHUB_REF" == "" ]; then
		INPUT_BRANCH="master"
	else
		INPUT_BRANCH="$GITHUB_REF"
	fi
fi

git config --global --add safe.directory "*"

# Push to the subtree directory
git subtree push --prefix="${INPUT_PATH}" "git@github.com:${INPUT_REPO}.git" "$INPUT_BRANCH"
