# Just working through Terraform Up and Running, nothing interesting to see here

### Notes

Generate the dependency graph (`sudo apt-get install graphviz` first)

```bash
terraform graph | dot -Tpng -o test.png
```

## How to Manage Terraform State

Once you `isolate via file layout`, you have to remember to execute `terraform` from within the folder that represents what you want to use.  I.e. given the following directory structure, if you wanted to provision the mysql datastore, you would have to `terraform apply` from within the `stage/datastores/mysql` folder.

```text
stage
├── data-stores
│   └── mysql
└── services
    └── webserver-cluster
```

Changing the `aws_launch_configuration` does NOT automatically de/provision the ASG nodes.  This seems like the safest behavior, but it does require the user to manually recycle the nodes.

It's really easy to accidentally take down the site when recycling nodes - 502 gateway errors.  Maybe due to health checks?  In any case, be VERY careful doing this manually.

## Reusable Infrastructure w/ Terraform Modules

pick up from chap 4