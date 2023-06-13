### YB94_VPC

-----------



### Spec

cidr : "10.20.0.0/16"

public_subnet : "10.20.1.0/24", "10.20.2.0/24"

private_subnet : "10.20.101.0/24", "10.20.102.0/24"

db_subnet : "10.20.103.0/24", "10.20.104.0/24"

provider : aws "~> 4.63.0"

region  = "ap-northeast-2"



### Usage

```
$ terraform plan -out=plan

$ terraform apply plan

$ terraform destory -target module.rds
```

