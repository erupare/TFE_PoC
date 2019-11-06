sudo docker ps
sudo docker logs ptfe_atlas

# Two options to consume logs:
# sudo docker logs ptfe_atlas > tfe_logs.json
# OR send to syslog using external tool like logspout
# docker run --name="logspout"  --volume=/var/run/docker.sock:/var/run/docker.sock gliderlabs/logspout syslog+tls://YOUR_LOG_SOLUTION_URL:55555