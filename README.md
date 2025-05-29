# Deploying GKE Autopilot Clusters

A comprehensive guide to deploying and managing Google Kubernetes Engine (GKE) Autopilot clusters using the Google Cloud Console.

## Video

https://youtu.be/znvCQD_9New

## Overview

This project demonstrates how to deploy GKE Autopilot clusters and manage workloads using the Google Cloud Console. GKE Autopilot is a fully managed Kubernetes service that provides a hands-off experience for cluster operations and Pod lifecycle management.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Deployment Steps](#deployment-steps)
- [Example Workloads](#example-workloads)
- [Monitoring and Management](#monitoring-and-management)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## Prerequisites

Before starting this project, ensure you have:

- A Google Cloud Platform (GCP) account
- Access to Google Cloud Console
- Basic understanding of Kubernetes concepts
- Familiarity with containerized applications

## Project Structure

```
gke-autopilot-deployment/
├── README.md
├── docs/
│   ├── deployment-guide.md
│   ├── workload-management.md
│   └── troubleshooting.md
├── examples/
│   ├── nginx-deployment.yaml
│   └── sample-workloads/
├── scripts/
│   └── setup.sh
└── images/
    └── screenshots/
```

## Getting Started

### Lab Setup Instructions

1. **Access the Lab Environment**
   - Click the "Start Lab" button in your learning environment
   - Wait for resources to provision
   - Note the temporary credentials provided

2. **Sign in to Google Cloud Console**
   - Click "Open Google Cloud console"
   - Use the provided username and password (not your personal Google account)
   - Accept terms and conditions
   - Skip recovery options and free trials

3. **Verify Project Access**
   - Confirm you're in the correct GCP project
   - Navigate to the project dashboard

## Deployment Steps

### Task 1: Deploy GKE Autopilot Cluster

1. **Navigate to Kubernetes Engine**
   ```
   Navigation Menu → Kubernetes Engine → Clusters
   ```

2. **Create New Cluster**
   - Click "Create" to start cluster creation
   - Review available configuration options:
     - Cluster name
     - Location (region/zone)
     - Kubernetes version
     - Node pool settings

3. **Configure Cluster Settings**
   - **Cluster Name**: `autopilot-cluster-1`
   - **Region**: Select your preferred region
   - **Mode**: Autopilot (default)
   - Leave other settings at defaults

4. **Deploy the Cluster**
   - Click "Create"
   - Wait for provisioning to complete (typically 5-10 minutes)

### Task 2: Deploy Sample Workload

1. **Access Workloads Section**
   ```
   Navigation Menu → Kubernetes Engine → Workloads
   ```

2. **Deploy Nginx Application**
   - Click "+ Deploy"
   - **Deployment name**: `nginx-1`
   - **Container image**: `nginx:latest` (default)
   - Click "Deploy"

3. **Verify Deployment**
   - Confirm deployment status shows as "OK"
   - Note the three Pod replicas created

### Task 3: Monitor and Manage Workloads

1. **View Workload Details**
   - Navigate to the nginx-1 workload
   - Explore different tabs:
     - **Overview**: Resource utilization and Pod status
     - **Details**: Pod specifications and autoscaler info
     - **Revision History**: Deployment version history
     - **Events**: Workload-related events
     - **YAML**: Complete configuration file

2. **Examine Pod Details**
   - Click on individual Pod names
   - Review Pod configuration and resource usage
   - Check Events and Logs tabs for troubleshooting

## Example Workloads

### Basic Nginx Deployment

The project includes a sample nginx deployment that demonstrates:
- Multi-replica Pod deployment
- Container image management
- Resource allocation in Autopilot mode
- Automatic scaling capabilities

### Key Features Demonstrated

- **Autopilot Benefits**: No node management required
- **Automatic Scaling**: Pods scale based on demand
- **Security**: Built-in security hardening
- **Resource Efficiency**: Pay only for requested resources

## Monitoring and Management

### Using Google Cloud Console

1. **Cluster Monitoring**
   - CPU and memory utilization
   - Node and Pod status
   - Network traffic metrics

2. **Workload Management**
   - Deployment scaling
   - Rolling updates
   - Health checks

3. **Logging and Events**
   - Container logs via Cloud Operations
   - Kubernetes events
   - Audit logs

## Best Practices

### Cluster Configuration
- Use regional clusters for high availability
- Enable workload identity for secure access
- Configure appropriate resource requests and limits

### Security
- Follow principle of least privilege
- Use Kubernetes RBAC
- Regularly update container images

### Cost Optimization
- Right-size resource requests
- Use appropriate scaling policies
- Monitor resource utilization

## Troubleshooting

### Common Issues

1. **Cluster Creation Fails**
   - Check project quotas and permissions
   - Verify region availability
   - Review error messages in console

2. **Pod Deployment Issues**
   - Validate container image availability
   - Check resource requests vs. available capacity
   - Review Pod events and logs

3. **Access Problems**
   - Ensure correct project selection
   - Verify IAM permissions
   - Check network connectivity

### Debugging Commands

While this project uses the Google Cloud Console, here are equivalent `kubectl` commands for reference:

```bash
# View cluster info
kubectl cluster-info

# List all pods
kubectl get pods

# Describe a specific pod
kubectl describe pod <pod-name>

# View pod logs
kubectl logs <pod-name>
```

## Learning Outcomes

After completing this project, you will understand:

- How to deploy GKE Autopilot clusters via Google Cloud Console
- Workload deployment and management techniques
- Monitoring and troubleshooting containerized applications
- Google Cloud Console navigation for Kubernetes resources

## Next Steps

Consider exploring these advanced topics:
- Custom application deployments
- Service mesh implementation
- CI/CD pipeline integration
- Multi-cluster management

## Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Resources

- [GKE Autopilot Documentation](https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Google Cloud Console Guide](https://cloud.google.com/cloud-console)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---
