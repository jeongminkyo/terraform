### Jailgas_VPC

-----------



### Spec

cidr : "10.30.0.0/16"

public_subnet : "10.30.1.0/24", "10.30.2.0/24"

private_subnet : "10.30.101.0/24", "10.30.102.0/24"

db_subnet : "10.30.103.0/24", "10.30.104.0/24"

provider : aws "~> 3.10.0"

region  = "ap-northeast-2"



### Usage

```
$ terraform plan -out=plan

$ terraform apply plan

$ terraform destory -target module.rds
```

