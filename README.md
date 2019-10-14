# terraform-aws-rds module

Create RDS instance(s) in AWS Cloud Platform.

## Docs

All available parameters and example can be found [here](docs/).

## Tests

### All tests

* `go test -timeout 30m`
* `go test -timeout 30m -p 1 ./... # For multiple tests with less log output`
* `GOCACHE=off go test -timeout 30m -p 1 ./... # without cache`

### One test

* `cd tests/`
* `go test -v -run BaicTestTerraformRdsModule # BaicTestTerraformRdsModule = name of function`

## Authors

* [Marius Stanca](mailto:me@marius.xyz)
