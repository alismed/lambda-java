## AWS Lambda with Java and deploy with Terraform and Github Actions



### Requirements
- AWS Cli
- Terraform Cli
- Java 17
- Maven
- Docker*
- Localstack Cli*

*Not essential, but recommended.

To use LocalStack on your local machine, add a profile in the aws cli settings: `.aws/credentials` and `.aws/config`

```shell

### Commands

```shell
localstack start -d
```

```shell
localstack stop
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
terraform -chdir=infra apply -auto-approve
```

```shell
terraform -chdir=infra destroy -auto-approve
```