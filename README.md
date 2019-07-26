[![Docker Repository on Quay](https://quay.io/repository/giantswarm/lighthouse/status "Docker Repository on Quay")](https://quay.io/repository/giantswarm/lighthouse)

# lighthouse

Chrome Lighthouse in Docker, plus a few utilities useful for CI.

## Usage

### Run lighthouse with headless Chrome

```nohighlight
docker run --rm \
    -v $PWD:/out \
    -v $PWD/dev-shm:/dev/shm \
    quay.io/giantswarm/lighthouse \
    lighthouse \
    http://example.com/ \
        --no-enable-error-reporting \
        --output=json \
        --output-path=/out/lighthouse.json \
        --emulated-form-factor desktop \
        --plugins=lighthouse-plugin-greenhouse \
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

### Run lighthouse-ci

This is a useful way to execute lighthouse in CI and fail if the score is below a threshold. See [andreasonny83/lighthouse-ci](https://github.com/andreasonny83/lighthouse-ci) for details.

```nohighlight
docker run --rm \
    -v $PWD:/out \
    -v $PWD/dev-shm:/dev/shm \
    quay.io/giantswarm/lighthouse \
    lighthouse-ci \
    http://example.com/ \
        --report=/out \
        --score=90 \
        --emulated-form-factor desktop \
        --chrome-flags="--headless --no-sandbox"
```

The `--score=90` flag sets a threshold score to pass of 90 in this case. Check [lighthouse-ci](https://github.com/andreasonny83/lighthouse-ci) for more flags.

### Run lighthouse-keeper

This allows to run lighthouse in CI for a GitHub pull request and comment back the result. See [giantswarm/lighthouse-keeper](https://github.com/giantswarm/lighthouse-keeper) for details.

#### compare two lighthouse reports

```nohighlight
docker run --rm \
    -v $PWD:/workdir -w /workdir \
    quay.io/giantswarm/lighthouse \
    lighthouse-keeper compare \
      --input master.json --label master \
      --input thisbranch.json --label "this branch"
```
