# Just working through Terraform Up and Running, nothing interesting to see here

### Notes

Generate the dependency graph (`sudo apt-get install graphviz` first)

```bash
terraform graph | dot -Tpng -o test.png
```

Once you `isolate via file layout`, you have to remember to execute `terraform` from within the folder that represents what you want to use.  I.e. given the following directory structure, if you wanted to provision the mysql datastore, you would have to `terraform apply` from within the `stage/datastores/mysql` folder.

```text
stage
├── data-stores
│   └── mysql
└── services
    └── webserver-cluster
```