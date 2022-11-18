# Worxspace – Dev container image for StartupWorx backend development

A Python/Node dev container image that has Google Cloud SDK, `gcloud` CLI and Firebase Tools CLI installed.

This uses the Microsoft `vscode/devcontainers/python` image:
https://github.com/microsoft/vscode-dev-containers/tree/main/containers/python-3

## Build and push

After you've made changes and tested locally:

1. Create a git tag and give it a description:

```
git tag {NEW_VERSION} -a
```

2. Run `build.sh` (which takes the latest git tag for the version number):

```
./build.sh
```
