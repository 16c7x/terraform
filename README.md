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
terraform plan
terraform apply -auto-approve

#### Clean up
```
terraform destroy -state=my.tfstate
```

## webserver

This builds a simple machine, installs Apache and displays a message.

## standalone_pe

Builds a standalone Puppet Enterprise server.
Logging in is sometimes tricky as connecting directly to port 443 doesn't always redirect to the login page, the path is https://<hostname>/auth/login and also ensure the details are in /etc/hosts.


ext_ip="curl -s https://freedns.afraid.org/dynamic/check.php | grep REMOTE_ADDR | awk '{ print \$3 }'";"$(ext_ip)/32"
