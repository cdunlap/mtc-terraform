# Create provider block
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

# Create the provider
provider "docker" {}

# Create the image
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest" # Actual name of the image, not an arbitrary image
}

# Create the container from the image
resource "docker_container" "nodered_container" {
  name  = "my_nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1880
  }
}

output "IP-Address" {
  value       = docker_container.nodered_container.ip_address
  description = "The IP address of the container"
}

output "container-name" {
  value       = docker_container.nodered_container.name
  description = "The name of the container"
}