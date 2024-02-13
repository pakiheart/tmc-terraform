# Create Tanzu Mission Control workspace
resource "tanzu-mission-control_workspace" "create_workspace" {
  name = var.workspace_name

  meta {
    description = "Create workspace through terraform"
    labels = {
      "key1" : "value1",
      "key2" : "value2"
    }
  }
}