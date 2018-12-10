# lighthouse

Chrome Lighthouse in Docker

## Usage

```nohighlight

docker run --rm -ti \
    -v $PWD:/out \
    -v $PWD/dev-shm:/dev/shm \
    quay.io/giantswarm/lighthouse \
    http://example.com/ \
        --no-enable-error-reporting \
        --output=json \
        --output-path=/out/lighthouse.json \
        --chrome-flags="--headless --no-sandbox"
```

Mounting a volume to `/dev/shm` is recommended to prevent the process from dying for a lack of available shared memory.
