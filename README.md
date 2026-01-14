# cursor-cli

Cursor CLI with some extra packages.

## Usage

The image default workdir is an empty `/workspace` directory that can be mounted.

Set the `CURSOR_API_KEY` environment variable for authentication.

Example:

```sh
export CURSOR_API_KEY="Yourkeyhere"
```

```sh
docker run \
    --rm \
    --interactive \
    --tty \
    --env CURSOR_API_KEY \
    --volume "$(pwd):/workspace" \
    andreswebs/cursor-cli \
        --approve-mcps \
        --force \
        --print \
        "are you operational?"
```

## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE).
