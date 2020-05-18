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
          "type": "json"
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

# Manual Releases

If you are using `.github/workflows/version.yml` or similar (where [skip ci] is recognized), you can manually perform some release actions, in cases where the defaults result in undesireable behaviors.

For example, when promoting a repo from 0.y.z to 1.0.0, you can trigger such a change by adding "BREAKING CHANGE:" to your commit, but doing so would introduce a misleading note into your changelog.  Perhaps you would even like to make some additional notes in the changelog explaining the newly released features.

    docker run -v $(pwd):/repo ckxng/standardversion --skip.commit --skip.tag --release-as major
    vi CHANGELOG.md # make whatever updates you would like to the changelog
    git add .
    git commit -m 'chore(release): 1.0.0 [skip ci]'
    git tag v1.0.0
    git push --follow-tags origin master

# Using [skip ci] in this repo

If a change is made which consists entirely of non-functional updates (such as documentation), append `[skip ci]` to the pull request commit or the push to master.  This will prevent the repo from executing the steps in the GitHub actions which generate a new version.  This prevents GitHub and Docker Hub from getting cluttered with versions that do not actually contain code changes.  If the documentation updates are significant, a bullet point can be added to the existing release in the changelog.

# Copying

See LICENSE for details.
