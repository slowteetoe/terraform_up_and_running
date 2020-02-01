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

## Terraform Gotchas

* `Zero-downtime deployment using an ASG` actually has an issue: it doesn't really work well with policies. It will reset the ASG size back to `min_size` after each deployment, which could be a problem if you had scaled up.  E.g. if you were running with 10 servers because of a policy that runs daily at 8am, and deployed later that day, the number of servers would go from 10 -> 2 (assuming that was min_size).  The rule would not trigger again until 8am the next morning, so capacity would be greatly reduced.

* `terraform plan` only looks at resources in the TF state file.  If you have people monkeying around with resources in the AWS console (for example), you can run into the situation where resources conflict, even though the plan looks valid.  You'd have to use `terraform import` to import that resource into the state file

* Refactoring: 
    * changing name of variables can cause outages, because they may be used in a resources name and certain resources will be deleted, and then recreated, if the name changes
    * changing the name of terraform identifiers can have the same problem (TF associates the ID from the cloud provider to the resource identifier internally, so renaming looks like you wanted to delete the old and add a new) - you have to `terraform state mv <original_reference> <new_reference>`

* Eventual consistency: some things take time to create, so although AWS returns a 201 created, it may not be available immediately.  Something else may fail because it tries to use that resource.  You may have to run `terraform apply` a couple times...

## Production-grade Terraform Code

* Small modules!