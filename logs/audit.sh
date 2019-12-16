sudo docker logs ptfe_atlas

# Reference: https://www.terraform.io/docs/enterprise/admin/logging.html

# Demo:
# In a real world scenario, you would pipe the Docker logs to a Splunk, Datadog, Logstash, etc to parse the logs
# For a simple demo we can look into the log files using jq and search vi:

# Gets container id, so we can check the log file
TFE_LOG_ID=$(sudo docker ps --no-trunc -aqf "name=ptfe_atlas")
# Gets last 100 lines and exports to a file
sudo tail -n 100  /var/lib/docker/containers/$TFE_LOG_ID/$TFE_LOG_ID-json.log > tst.log
# Open the file, and use the command "/action" to validate a certain action made, like an apply, is logged
vi tst.log