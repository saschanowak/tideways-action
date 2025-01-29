# Tideways release

This action creates a release event in Tideways. It is useful to track deployments and correlate them with performance data.

## Inputs

### `apiKey`

- Check to "Project Settings" to find the API key necessary to authenticate the Create Event request.

### `appName`

- Name of the project

### `title`

- Name of the release

### `eventType` (optional)

- Type of the event
- Accepts `release`, `marker`.
- By default `release` is used.

### `description` (optional)

- More details about the release if you want.

### `environment` (optional)

- The environment this release is performed on, otherwise the default environment is used.
- By default `production` is used.

### `service` (optional)

- The service this release is performed on, otherwise the default service of the project is used.

### `compareAfterMinutes` (optional)

- Specifies the timeframes around the event for which the performance will be compared.
  Supported values are between 5 minutes and 1440 minutes (one day).
- By default `90` is used.

## Usage

```yaml
      - name: Tideways release
        uses: saschanowak/tideways-action@1.0.0
        with:
          apiKey: '${{ secrets.TIDEWAYS_API_KEY }}'
          appName: '${{ vars.TIDEWAYS_APP_NAME }}'
          title: 'Deployed ${{ github.sha }}'
```

## Version Numbers

Version numbers will be assigned according to the [Semantic Versioning](https://semver.org/) scheme.
This means, given a version number MAJOR.MINOR.PATCH, we will increment the:

1. MAJOR version when we make incompatible API changes
2. MINOR version when we add functionality in a backwards compatible manner
3. PATCH version when we make backwards compatible bug fixes

## Contributing

### Build & Test Action

```bash
docker buildx build -t ghcr.io/saschanowak/tideways-cli:latest -f cli/Dockerfile cli
docker run --rm -it -e TIDEWAYS_API_KEY='...' -e TIDEWAYS_APP_NAME='acme/myapp17' -e TIDEWAYS_TITLE='Deployed v1.2.5' ghcr.io/saschanowak/tideways-cli:latest
```

### Report Bugs

Please make sure the bug is not already reported by searching existing [issues].

If you're unable to find an existing issue addressing the problem please [open a new one][new-issue]. Be sure to include
a title and clear description, as much relevant information as possible, a workflow sample and any logs demonstrating
the problem.

### Suggest an Enhancement

Please [open a new issue][new-issue].

### Submit a Pull Request

Discuss your idea first, so that your changes have a good chance of being merged in.

Submit your pull request against the `main` branch.

Pull requests that include documentation and relevant updates to README.md are merged faster, because you won't have to
wait for somebody else to complete your contribution.

## License

Code Coverage Summary is available under the MIT license, see the [LICENSE](LICENSE) file for more info.

[issues]: https://github.com/saschanowak/tideways-action/issues

[new-issue]: https://github.com/saschanowak/tideways-action/issues/new
