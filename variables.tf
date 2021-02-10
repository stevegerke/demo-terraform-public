#General
variable "resource-group-name" { default = "my-resource-group" }
variable "location" { default = "EAST US 2" }

#Key Vault
variable "key-vault-name" { default = "my-key-vault" }

#Storage
variable "storage-name" { default = "mystorageadls" }

#Data Factory
variable "adf-name" { default = "my-adf" }

variable "github_configuration" {
  type = object({
    github_account_name    = string
    github_branch_name     = string
    github_url             = string
    github_repository_name = string
    github_root_folder     = string
  })
  default = {
    github_account_name    = "stevegerke"
    github_branch_name     = "main"
    github_url             = "https://github.com"
    github_repository_name = "demo-adf-public"
    github_root_folder     = "/"
  }
}
