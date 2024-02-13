set -e

terraform init -backend-config="access_key=$TF_VAR_access_key" \
  -backend-config="secret_key=$TF_VAR_secret_key" \
  -backend-config="bucket=tfstate-ra" \
  -reconfigure

terraform plan -var-file=../../secrets/terraform.tfvars
cd -