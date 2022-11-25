# CHANGELOG

## 3

- Add `postgres-client` into image so we can connect to DB instances on the same network from the image running as a dev container.
- Expose port 9150 so we can authenticate Firebase tools
- Updated `build.sh` script to set builder back to `default` after building with multi-platform builder.
