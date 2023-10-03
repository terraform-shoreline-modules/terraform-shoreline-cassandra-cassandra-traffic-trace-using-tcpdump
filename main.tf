terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "cassandra_traffic_trace_using_tcpdump" {
  source    = "./modules/cassandra_traffic_trace_using_tcpdump"

  providers = {
    shoreline = shoreline
  }
}