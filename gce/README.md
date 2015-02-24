## Install Terraform

```
brew install terraform
```

## Configure credentials

[Google Cloud Platform credentials](https://console.developers.google.com/project/siq-haas/apiui/credential)

* `~/.credentials/account.json`: Service Account > Generate new JSON key
* `~/.credentials/client_secret.json`: Client ID for native application > Download JSON

Checking the credentials

```
terraform plan -var owner=$USER -var credential_dir=~/.config/gcloud/
```

## Upload ssh public key

This SSH key is used to remote exec the provisioning script

Upload the key [GCE Compute engine > Metadata > SSH tab](https://console.developers.google.com/project/siq-haas/compute/metadata/sshKeys)
