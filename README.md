# github_projects

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with github_projects](#setup)
    * [What github_projects affects](#what-github_projects-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with github_projects](#beginning-with-github_projects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Clone (and optinally update) all GitHub projects for a given github user ID

## Module Description

Downloads all the public repositories for a given GitHub user ID.  The [gitim](https://github.com/muhasturk/gitim) script is used to do this and a complete copy of this project is supplied in this module's files directory.

## Setup

### Setup Requirements

* GitHub API usage requires that the user be authenticated against a valid GitHub account
* While this can be done with a password, this is not recommended as passwords may give more access then is required
* Instead, users should generate an [OAuth token]( https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
* Requires the `pip3` python command to be present.  On Ubuntu and Debian systems, this is provided in the `python3-pip` package
* If you get errors about the `pygithub` library being missing despite apparently successful library installation, then you may have a miss-match between your `pip3` and `python3` versions.  Check that the versions match and update the symlink at `/usr/local/bin/python3` if this is the case

### Beginning with github_projects

`github_projects` module needs to be included once to bring in the python dependencies into scope.  The `github_projects::get` defined resource type can then be used to manage a given directory and checkout code from the specified GitHub user.

This is can be done with a hash of Hiera data:

```yaml
profiles::github_projects::get:
    "/home/geoff/github": {
        "github_user": "GeoffWilliams",
        "local_user": "geoff",
        "token": "replace_with_you_oauth_hash",
    }
```

Once data is in Hiera, a simple profile class can both initiate Python and perform the download

```puppet
class profiles::github_projects(
    $get = hiera("profiles::github_projects::get", {}),
) {

  include github_projects
  create_resources("github_projects::get", $get)

}
```
## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

* `github_projects` - Main class used to setup Python dependencies
* `github_projects::get` - Defined resource type for cloning/updating repositories

## Limitations

Needs Python 3, tested on Ubuntu 15.10.  Installs the `pygithub` Python package and requires Internet access to download.  Should work anywhere that `pygithub` does but this hasn't been tested.

## Development

PRs accepted
