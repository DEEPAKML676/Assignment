# Node.js DevOps Assessment

## Node.js Application CI/CD Pipeline using Jenkins

## Project Overview

This project demonstrates a complete CI/CD pipeline for a Node.js web application using Jenkins, Docker, SonarQube, Trivy, and Docker Hub.

The pipeline automates the full software delivery lifecycle including:

* Source code checkout
* Dependency installation
* Automated testing
* Static code analysis
* Security vulnerability scanning
* Docker image build
* Docker image push to Docker Hub
* Application deployment using Docker container
* Deployment verification

This project follows DevOps best practices and industry standards for secure and reliable software delivery.

---

## Architecture Overview

### CI/CD Flow

```text
Developer pushes code to GitHub
↓
Jenkins triggers pipeline automatically
↓
Clone latest source code
↓
Install Node.js dependencies
↓
Run test cases
↓
Perform SonarQube static code analysis
↓
Perform Trivy security scan
↓
Build Docker image
↓
Push Docker image to Docker Hub
↓
Stop old running container
↓
Deploy new container
↓
Verify successful deployment
```

This ensures faster delivery, reduced manual work, better security, and reliable deployments.

---

## Prerequisites

Before running this project, ensure the following tools are installed and configured:

### Required Tools

* Jenkins
* Docker
* Node.js
* Git
* SonarQube Server
* Trivy
* Docker Hub Account
* Linux Server

---

## Jenkins Credentials Required

Go to:

Manage Jenkins → Credentials

Add the following credentials:

### 1. sonar-token

Type: Secret Text

Used for:

SonarQube authentication

---

### 2. dockerhub-creds

Type: Username with Password

Used for:

Docker Hub login and image push

---

## Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/DEEPAKML676/Assignment.git
cd Assignment
```

---

### Step 2: Install Node.js Dependencies

```bash
cd app
npm install
```

---

### Step 3: Configure SonarQube

* Install and start SonarQube server
* Create a project in SonarQube
* Generate authentication token
* Add token to Jenkins credentials as `sonar-token`

---

### Step 4: Configure Docker Hub

* Create Docker Hub account
* Add Docker Hub username and password in Jenkins credentials as `dockerhub-creds`

---

### Step 5: Install Trivy

Install Trivy for container security scanning.

Example:

```bash
sudo apt install trivy
```

---

### Step 6: Create Jenkins Pipeline Job

* Open Jenkins Dashboard
* Click New Item
* Select Pipeline
* Enter job name
* Configure GitHub repository
* Use Jenkinsfile from SCM

---

## Pipeline Stages

The Jenkins pipeline includes the following stages:

### 1. Clone Repository

Pulls source code from GitHub.

### 2. Install Dependencies

Installs required Node.js packages.

### 3. Run Tests

Executes application test cases.

### 4. SonarQube Scan

Checks code quality, bugs, vulnerabilities, and code smells.

### 5. Build Docker Image

Creates Docker image for deployment.

### 6. Security Scan

Scans Docker image for HIGH and CRITICAL vulnerabilities using Trivy.

### 7. Docker Hub Login

Authenticates Jenkins with Docker Hub securely.

### 8. Docker Push

Pushes Docker image to Docker Hub.

### 9. Stop Old Container

Stops and removes old running container.

### 10. Run Docker Container

Deploys latest application container.

### 11. Verify Deployment

Checks successful deployment using Docker container status.

---

## How to Run the Pipeline End-to-End

### Step 1

Push code changes to GitHub repository

### Step 2

Jenkins automatically triggers the pipeline

### Step 3

Pipeline runs all CI/CD stages

### Step 4

Docker image is pushed to Docker Hub

### Step 5

Latest container is deployed automatically

### Step 6

Verify deployment using:

```bash
docker ps
```

---

## Expected Output

If the pipeline completes successfully, Jenkins shows:

```text
Pipeline executed successfully!
```

Also verify:

* Docker image available in Docker Hub
* Running container on port 3000
* SonarQube analysis report generated
* Trivy security scan completed successfully

---

## Security Best Practices Followed

* No hardcoded credentials
* Jenkins credentials used securely
* SonarQube static code analysis
* Trivy vulnerability scanning
* Secure Docker Hub authentication
* Automated deployment verification
* Safe container replacement process

---


## Conclusion

This project demonstrates a production-ready Jenkins CI/CD pipeline for a Node.js application using Docker with security scanning and automated deployment.

Benefits include:

* Faster software delivery
* Improved code quality
* Better security
* Reduced manual effort
* Reliable production deployment

This solution follows modern DevOps practices and industry standards.
