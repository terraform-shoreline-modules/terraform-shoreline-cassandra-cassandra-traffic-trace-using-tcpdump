resource "shoreline_notebook" "cassandra_traffic_trace_using_tcpdump" {
  name       = "cassandra_traffic_trace_using_tcpdump"
  data       = file("${path.module}/data/cassandra_traffic_trace_using_tcpdump.json")
  depends_on = [shoreline_action.invoke_cassandra_config_check]
}

resource "shoreline_file" "cassandra_config_check" {
  name             = "cassandra_config_check"
  input_file       = "${path.module}/data/cassandra_config_check.sh"
  md5              = filemd5("${path.module}/data/cassandra_config_check.sh")
  description      = "Check if the Cassandra cluster is properly configured. Ensure that there are no configuration errors in the Cassandra.yaml file."
  destination_path = "/agent/scripts/cassandra_config_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cassandra_config_check" {
  name        = "invoke_cassandra_config_check"
  description = "Check if the Cassandra cluster is properly configured. Ensure that there are no configuration errors in the Cassandra.yaml file."
  command     = "`chmod +x /agent/scripts/cassandra_config_check.sh && /agent/scripts/cassandra_config_check.sh`"
  params      = ["PATH_TO_CASSANDRA_YAML_FILE"]
  file_deps   = ["cassandra_config_check"]
  enabled     = true
  depends_on  = [shoreline_file.cassandra_config_check]
}

