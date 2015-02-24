variable owner {
    description = "Who is respomsible for the instance"
}

variable gce_project {
    description = "siq-haas"
}

variable credential_dir {
    description = "Directory that containst the account and client_secret json https://www.terraform.io/docs/providers/google/index.html"
}

variable ssh_key_file {
    description = "SSH key file to be used when provisioning"
}

variable gce_zone {
    description = "GCE zone to start the cbreak deployment"
    default = "us-central1-a"
}

variable ins_type {
    description = "cbreak deployment insance size"
    default = "n1-standard-4"
}

provider "google" {
    account_file = "${var.credential_dir}/account.json"
    client_secrets_file = "${var.credential_dir}/client_secret.json"
    project = "${var.gce_project}"
    region = "us-central1"
}

resource "google_compute_instance" "cloudbreak-deploy1" {
    name = "cloudbreak-deploy"
    machine_type = "${var.ins_type}"
    zone = "${var.gce_zone}"

    disk {
        image = "packer-cloudbreak-2015-02-03"
    }

    network {
        source = "default"
    }

    provisioner "remote-exec" {

        connection {
            user = "ubuntu"
            key_file = "${var.ssh_key_file}"
        }

        script = "./deploy_gce.sh"
    }

}

output "instance" {
    value = "${google_compute_instance.cloudbreak-deploy1.name}"
}
