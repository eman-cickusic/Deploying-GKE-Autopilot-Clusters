# GKE Autopilot Deployment Guide

This guide provides detailed step-by-step instructions for deploying GKE Autopilot clusters using the Google Cloud Console.

## Table of Contents

1. [Pre-deployment Setup](#pre-deployment-setup)
2. [Cluster Deployment](#cluster-deployment)
3. [Workload Deployment](#workload-deployment)
4. [Verification and Testing](#verification-and-testing)
5. [Post-deployment Tasks](#post-deployment-tasks)

## Pre-deployment Setup

### Environment Preparation

1. **Access Lab Environment**
   - Navigate to your Google Cloud training platform
   - Start the GKE Autopilot lab
   - Wait for resource provisioning (typically 2-3 minutes)

2. **Credential Management**
   ```
   Username: [Provided by lab environment]
   Password: [Provided by lab environment]
   Project ID: [Auto-assigned temporary project]
   ```

3. **Console Access**
   - Open Google Cloud Console in incognito/private window
   - Sign in with temporary credentials
   - Verify project selection in top navigation bar

### Initial Console Navigation

1. **Familiarize with Navigation Menu**
   - Located at top-left (hamburger menu)
   - Search functionality available
   - Key sections: Kubernetes Engine, Compute Engine, IAM

2. **Project Dashboard Review**
   - Check project information
   - Verify billing account (covered by lab credits)
   - Note any existing resources

## Cluster Deployment

### Step 1: Access Kubernetes Engine

1. **Navigate to Kubernetes Engine**
   ```
   Navigation Menu → Kubernetes Engine → Clusters
   ```

2. **Review Cluster Options**
   - Standard vs. Autopilot modes
   - Regional vs. Zonal deployment
   - Version selection

### Step 2: Configure Cluster Settings

1. **Basic Configuration**
   - **Name**: `autopilot-cluster-1`
   - **Location type**: Region
   - **Region**: Choose based on lab requirements
   - **Release channel**: Regular (recommended)

2. **Autopilot Features** (automatically enabled)
   - Node auto-provisioning
   - Pod-level resource billing
   - Built-in security hardening
   - Automatic scaling and upgrading

### Step 3: Deploy the Cluster

1. **Review Configuration Summary**
   - Verify all settings before creation
   - Note estimated costs (covered by lab credits)

2. **Initiate Deployment**
   - Click "Create" button
   - Monitor progress in notifications

3. **Deployment Timeline**
   - Initial provisioning: 5-7 minutes
   - Node readiness: Additional 2-3 minutes
   - Total time: ~10 minutes

### Step 4: Verify Cluster Status

1. **Check Cluster List**
   - Status should show "Running" with green checkmark
   - Node count displays as "Autopilot"
   - Location matches selected region

2. **Review Cluster Details**
   - Click cluster name for detailed view
   - Examine Overview, Nodes, Storage tabs
   - Note auto-configured security settings

## Workload Deployment

### Step 1: Access Workloads Section

1. **Navigate to Workloads**
   ```
   Navigation Menu → Kubernetes Engine → Workloads
   ```

2. **Understand Workload Types**
   - Deployments (stateless applications)
   - StatefulSets (stateful applications)
   - DaemonSets (node-level services)
   - Jobs and CronJobs (batch processing)

### Step 2: Deploy Nginx Application

1. **Initiate Deployment**
   - Click "+ Deploy" button
   - Choose "Deploy from Google Cloud Marketplace" or "Deploy from container image"

2. **Configure Deployment**
   ```yaml
   Deployment name: nginx-1
   Container image: nginx:latest
   Replicas: 3 (default)
   Port: 80 (auto-detected)
   ```

3. **Advanced Configuration Options**
   - Environment variables
   - Resource limits and requests
   - Volume mounts
   - Security context

### Step 3: Execute Deployment

1. **Review Configuration**
   - Verify all settings
   - Check resource allocation
   - Confirm security settings

2. **Deploy Application**
   - Click "Deploy" button
   - Monitor deployment progress
   - Wait for "Deployment successful" message

## Verification and Testing

### Step 1: Workload Status Verification

1. **Check Deployment Status**
   ```
   Workloads → nginx-1 → Overview tab
   ```
   - Status: OK (green)
   - Available replicas: 3/3
   - Resource utilization graphs

2. **Pod Health Verification**
   - Navigate to Managed Pods section
   - Verify all 3 pods show "Running" status
   - Check individual pod details

### Step 2: Detailed Inspection

1. **Deployment Details**
   - **Details tab**: Pod specifications, autoscaler settings
   - **Revision History**: Deployment versions and rollback options
   - **Events**: Recent activities and status changes
   - **YAML**: Complete Kubernetes manifest

2. **Pod-Level Analysis**
   - Click individual pod names
   - Review resource usage metrics
   - Examine container logs
   - Check network connectivity

### Step 3: Resource Monitoring

1. **Cluster Resources**
   - CPU and memory utilization
   - Network traffic patterns
   - Storage usage

2. **Application Metrics**
   - Request/response rates
   - Error rates
   - Performance indicators

## Post-deployment Tasks

### Step 1: Security Review

1. **Pod Security Standards**
   - Verify security context settings
   - Check for privileged containers
   - Review network policies

2. **Access Controls**
   - RBAC configuration
   - Service account permissions
   - Network security

### Step 2: Operational Procedures

1. **Backup and Recovery**
   - Configuration backup
   - Data protection strategies
   - Disaster recovery planning

2. **Monitoring Setup**
   - Alert configuration
   - Log aggregation
   - Performance monitoring

### Step 3: Scaling and Optimization

1. **Horizontal Scaling**
   - Configure Horizontal Pod Autoscaler
   - Set scaling policies
   - Test scaling behavior

2. **Resource Optimization**
   - Right-size resource requests
   - Optimize container images
   - Implement resource quotas

## Troubleshooting Common Issues

### Deployment Failures

**Problem**: Cluster creation fails
**Solutions**:
- Check project quotas and limits
- Verify region availability
- Review IAM permissions

**Problem**: Pod deployment stuck in pending
**Solutions**:
- Check resource requests vs. available capacity
- Verify image pull permissions
- Review node selector constraints

### Performance Issues

**Problem**: Slow application response
**Solutions**:
- Increase resource limits
- Check network latency
- Review application logs

**Problem**: High resource usage
**Solutions**:
- Optimize application code
- Implement caching strategies
- Scale horizontally

## Best Practices Summary

1. **Use regional clusters** for high availability
2. **Set appropriate resource requests** for optimal scheduling
3. **Implement health checks** for reliability
4. **Use least privilege** security principles
5. **Monitor resource usage** regularly
6. **Keep container images updated** for security
7. **Implement proper logging** for troubleshooting
8. **Use labels and annotations** for organization

## Next Steps

After completing this deployment:

1. **Explore advanced features**:
   - Service mesh (Istio)
   - GitOps workflows
   - Multi-cluster management

2. **Implement CI/CD**:
   - Cloud Build integration
   - Automated deployments
   - Testing strategies

3. **Security hardening**:
   - Pod security policies
   - Network segmentation
   - Secrets management

4. **Cost optimization**:
   - Resource right-sizing
   - Spot instances
   - Commitment discounts