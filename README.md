# lighthouse

Chrome Lighthouse in Docker

## Usage

```nohighlight

docker run --rm \
    -v $PWD:/out \
    -v $PWD/dev-shm:/dev/shm \
    quay.io/giantswarm/lighthouse \
    http://example.com/ \
        --no-enable-error-reporting \
        --output=json \
        --output-path=/out/lighthouse.json \
        --chrome-flags="--headless --no-sandbox"
```

This should result in a `lighthouse.json` file being generated in your directory.

Mounting a volume to `/dev/shm` is recommended to prevent the process from dying for a lack of available shared memory.

For a list of options for `--chrome-flags`, check out [this huge list](https://peter.sh/experiments/chromium-command-line-switches/).

For a list of lighthouse flags, execute

```
docker run --rm \
    -v $PWD/dev-shm:/dev/shm \
    quay.io/giantswarm/lighthouse --help
```
