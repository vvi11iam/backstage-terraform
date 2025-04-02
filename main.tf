terraform {
  backend "remote" {
    organization = "romthayon2310"

    workspaces {
      name = "github-actions"
    }
  }
}

# An example resource that does nothing.
resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}

