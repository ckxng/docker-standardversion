![Docker Image CI](https://github.com/ckxng/docker-standardversion/workflows/Docker%20Image%20CI/badge.svg)[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/ckxng/standardversion)](https://hub.docker.com/r/ckxng/standardversion)

# docker-standardversion

Docker wrapper around [conventional-changelog/standard-version](https://github.com/conventional-changelog/standard-version).

# Using this container

## .versionrc

### NodeJS Default Config

If `.versionrc` is not provided, then standard-version will read `package.json` to determine the current version and repo URL. Standard Version will also update the version in `package.json`.

### NodeJS Custom Config

Standard Version will detect your repo URLs from your `package.json` if they are specified.

Custom files can be managed by Standard Version by specifying _bumpFiles_ in `.versionrc`. (If _bumpFiles_ are provided in this way, then `package.json` will not be updated unless it is listed - so don't forget it!)

    {
      "bumpFiles": [
        {
          "filename": "version.txt",
          "type": "plain-text"
        },
        {
          "filename": "package.json",
          "type": "json"
        }
      ]
    }

### Other Projects

If you do not have a `package.json` file, or if your repository URLs are nonstandard, you may specify that information in `.versionrc`. As shown above, you may also specify a list of files to be updated with the current version number. (Version numbers are read from _packageFiles_ and written to _bumpFiles_.)

    {
      "commitUrlFormat": "https://github.com/USER/REPO/commit/{{hash}}",
      "compareUrlFormat": "https://github.com/USER/REPO/compare/{{previousTag}}...{{currentTag}}",
      "issueUrlFormat": "https://github.com/USER/REPO/issues/{{id}}",
      "userUrlFormat": "https://github.com/{{user}}",
      "packageFiles": [
        {
          "filename": "metadata.json",
          "type": "plain-text"
        }
      ],
      "bumpFiles": [
        {
          "filename": "metadata.json",
          "type": "json"
        }
      ]
    }

See the [Conventional Changelog Spec](https://github.com/conventional-changelog/conventional-changelog-config-spec/blob/master/versions/2.1.0/README.md) for more details on the above URL parameters.

## Running

    docker -v '/path/to/gitrepo:/repo' ckxng/standardversion

# GitHub Actions

See `.github/workflows/version.yml` for an example of using this container from within a GitHub action.

# Copying

See LICENSE for details.
