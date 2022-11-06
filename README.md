# Terraform

This is a library of Terraform code to build various things.

## How to use

cd into the directory of whatever it is you want to build.

#### Verify the code

```
terraform fmt -check
terraform init
terraform validate
```

#### Apply the code

```
terraform plan -out my.tfplan
terraform apply -state=my.tfstate my.tfplan
```

#### Clean up
```
terraform destroy -state=my.tfstate
```

## webserver

This builds a simple machine, installs Apache and displays a message.

## standalone_pe

Builds a standalone Puppet Enterprise server.
