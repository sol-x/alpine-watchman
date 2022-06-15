# watchman apk for alpine

To build the image:

```
./build.zsh node:14.15.4-alpine watchman-4.9.0-r2.apk
```

The first argument is the docker image in which to build the apk and the second argument is the location to copy the apk to in the local filesystem. The arguments can be omitted in which case the defaults shown above are used.
