
=================
1. deploy.sh
Purpose

This script automates application deployment using Docker.

It performs the following steps:

Pull latest Docker image from Docker Hub
Stop existing running container
Remove old container
Start new container using latest image

This ensures the latest version of the application is deployed.

Script
#!/bin/bash

docker pull deepakml2000/nodejs-app:latest

docker stop nodejs-container || true
docker rm nodejs-container || true

docker run -d \
  --name nodejs-container \
  -p 3000:3000 \
  deepakml2000/nodejs-app:latest
Input

No manual input required.

The script uses:

Docker Hub image name
Container name
Port mapping
Output

Expected result:

Latest Docker image pulled
Old container removed
New container deployed successfully
Usage Example
chmod +x deploy.sh
./deploy.sh

=================
2. health-check.sh
Purpose

This script verifies whether the application is running successfully.

It checks:

Application availability
Application response status

This helps confirm successful deployment.

Script
#!/bin/bash

curl -f http://localhost:3000

if [ $? -eq 0 ]; then
    echo "Application is healthy"
else
    echo "Application is down"
    exit 1
fi
Input

No manual input required.

The script checks:

http://localhost:3000
Output

Expected result:

Application is healthy

OR

Application is down
Usage Example
chmod +x health-check.sh
./health-check.sh

=============
3. rollback.sh
Purpose

This script is used to rollback deployment to the previous stable version if the latest deployment fails.

It performs:

Stop current container
Remove failed container
Deploy previous stable Docker image

This improves deployment safety and recovery.

Script
#!/bin/bash

docker stop nodejs-container || true
docker rm nodejs-container || true

docker run -d \
  --name nodejs-container \
  -p 3000:3000 \
  previous-image
Input

No manual input required.

The script uses:

Previous stable Docker image
Existing container name
Port mapping
Output

Expected result:

Failed deployment removed
Previous stable version restored successfully
Usage Example
chmod +x rollback.sh
./rollback.sh
Security Best Practices Followed
Safe container replacement using || true
Automated rollback support
Health verification after deployment
No hardcoded passwords or secrets
Reusable production-ready scripts

==========
Conclusion

These scripts improve deployment automation and reduce manual operational effort.

Benefits include:

Faster deployments
Reliable rollback
Better application monitoring
Reduced downtime
Production-ready DevOps operations

These scripts support a secure and stable CI/CD pipeline workflow.