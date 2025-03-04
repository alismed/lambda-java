## AWS Lambda with Java and deploy with Terraform and Github Actions



### Requirements
- AWS Cli
- Terraform Cli
- Java 17
- Maven
- Docker*
- Localstack Cli*

*not essential, but recommended

### Commands

```shell
localstack start -d
```

```shell

```

```shell
terraform -chdir=infra init
```

```shell
terraform -chdir=infra fmt
```

```shell
terraform -chdir=infra plan
```

```shell
terraform -chdir=infra apply
```

```shell
terraform -chdir=infra destroy
```