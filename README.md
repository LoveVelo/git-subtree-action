# git-subtree-action
The source for the git-subtree github action.

## About
This repository contains the source code for the git-subtree action that allows you to easily keep a git subtree in sync
using the actions pipeline.

## Usage

### Action Inputs
| Input        | Description                                                                                                                         |
| ------------ | -------------------------------------------------------------------------------------                                               |
| repo         | Child repository to sync the subtree to (eg. owner/repository.)                                                                     |
| path         | Path prefix in parent repo to split into child subtree (eg. src/PackageName.)                                                       |
| deploy_key   | Deployment (public) SSH key for pushing to child repo (use deployment tokens for single repos or bot accounts for multi-repos/orgs.)|
| branch       | Branch of child subtree repository (default is branch or tag ref that triggered the workflow.)                                      |


### Workflow Examples
This example uses a matrix to sync a list of namespaces into child subtree repos.

```yaml
name: subtree-matrix

on: [push]

jobs:
  sync-downstream:

    runs-on: ubuntu-latest

    strategy:
      fail-fast: false
      matrix:
        path:
          - command
          - database
          - support

    name: Update downstream ${{ matrix.path }} package

    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - uses: nxtlvlsoftware/git-subtree-action@1.1
        with:
          repo: 'nxtlvlsoftware/${{ matrix.path }}'
          path: 'src/${{ matrix.path }}'
          deploy_key: ${{ secrets.DOWNSTREAM_GITHUB_DEPLOY_KEY }}
```
