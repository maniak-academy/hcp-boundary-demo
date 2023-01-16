mkdir ~/boundary/ && cd ~/boundary/

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - ;\
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" ;\
sudo apt-get update && sudo apt-get install boundary-worker-hcp -y

touch ~/boundary/pki-worker.hcl

disable_mlock = true

hcp_boundary_cluster_id = "5771af38-3a3b-43c5-b992-8f3c0439df23"

listener "tcp" {
  address = "127.0.0.1:9202"
  purpose = "proxy"
}

worker {
  auth_storage_path = "/home/ubuntu/boundary/worker1"
  tags {
    type = ["worker", "dev"]
  }
}



boundary-worker server -config="/home/ubuntu/boundary/pki-worker.hcl"