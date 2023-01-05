terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

 provider "yandex" {
   token =   var.yc_token
   cloud_id  = "b1ga8hp5qimcnoglaoe9"
   folder_id = "b1gd90e13r1hhqi7jflu"
   zone      = "ru-central1-a"
  }

resource "yandex_storage_bucket" "ambacket" {
  access_key = ""
  secret_key = ""
  bucket = "amolokov-backet-${terraform.workspace}"

  count = local.instance_count[terraform.workspace]

   lifecycle {
    create_before_destroy = true
  }
}


resource "yandex_storage_bucket" "ambacket-new" {
  access_key = ""
  secret_key = ""
  bucket = "amolokov-backet-${each.key}-${terraform.workspace}"

  for_each = local.virtual_mashines[terraform.workspace]
}

locals {

  instance_count = {
    stage = 1
    prod  = 2
  }



  virtual_mashines = {
    stage = {
      "1" = { cores = "2", memory = "2" }
     }
    prod = {
      "2" = { cores = "4", memory = "4" },
      "3" = { cores = "4", memory = "4" }
     }
   }
}
