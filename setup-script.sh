#!/bin/bash

# GKE Autopilot Cluster Setup Script
# This script automates the deployment process using gcloud CLI
# Note: This is provided as reference - the main lab uses Google Cloud Console

set -e

# Configuration variables
PROJECT_ID=${PROJECT_ID:-"your-project-id"}
CLUSTER_NAME=${CLUSTER_NAME:-"autopilot-cluster-1"}
REGION=${REGION:-"us-central1"}
DEPLOYMENT_NAME=${DEPLOYMENT_NAME:-"nginx-1"}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    log "Checking prerequisites..."
    
    # Check if gcloud is installed
    if ! command -v gcloud &> /dev/null; then
        error "gcloud CLI is not installed. Please install Google Cloud SDK."
        exit 1
    fi
    
    # Check if kubectl is installed
    if ! command -v kubectl &> /dev/null; then
        warning "kubectl is not installed. Installing via gcloud..."
        gcloud components install kubectl
    fi
    
    # Verify authentication
    if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
        error "Not authenticated with gcloud. Please run 'gcloud auth login'"
        exit 1
    fi
    
    success "Prerequisites check completed"
}

# Set project and enable APIs
setup_project() {
    log "Setting up project: $PROJECT_ID"
    
    # Set active project
    gcloud config set project $PROJECT_ID
    
    # Enable required APIs
    log "Enabling required APIs..."
    gcloud services enable container.googleapis.com
    gcloud services enable compute.googleapis.com
    
    success "Project setup completed"
}

# Create GKE Autopilot cluster
create_cluster() {
    log "Creating GKE Autopilot cluster: $CLUSTER_NAME in region: $REGION"
    
    # Check if cluster already exists
    if gcloud container clusters describe $CLUSTER_NAME --region=$REGION &> /dev/null; then
        warning "Cluster $CLUSTER_NAME already exists"
        return 0
    fi
    
    # Create Autopilot cluster
    gcloud container clusters create-auto $CLUSTER_NAME \
        --region=$REGION \
        --project=$PROJECT_ID
    
    success "Cluster created successfully"
}

# Get cluster credentials
get_credentials() {
    log "Getting cluster credentials..."
    
    gcloud container clusters get-credentials $CLUSTER_NAME \
        --region=$REGION \
        --project=$PROJECT_ID
    
    success "Credentials configured successfully"
}

# Deploy sample nginx workload
deploy_workload() {
    log "Deploying nginx workload..."
    
    # Create deployment
    kubectl create deployment $DEPLOYMENT_NAME --image=nginx:latest --replicas=3
    
    # Wait for deployment to be ready
    kubectl rollout status deployment/$DEPLOYMENT_NAME
    
    # Create service
    kubectl expose deployment $DEPLOYMENT_NAME --port=80 --type=ClusterIP
    
    success "Workload deployed successfully"
}

# Verify deployment
verify_deployment() {
    log "Verifying deployment..."
    
    # Check cluster status
    echo "Cluster information:"
    kubectl cluster-info
    
    echo -e "\nNodes:"
    kubectl get nodes
    
    echo -e "\nDeployments:"
    kubectl get deployments
    
    echo -e "\nPods:"
    kubectl get pods -o wide
    
    echo -e "\nServices:"
    kubectl get services
    
    success "Deployment verification completed"
}

# Show useful commands
show_commands() {
    log "Useful commands for managing your deployment:"
    
    cat << EOF

# View cluster details
kubectl cluster-info
kubectl get nodes -o wide

# View workload status
kubectl get deployments
kubectl get pods -o wide
kubectl get services

# Describe resources
kubectl describe deployment $DEPLOYMENT_NAME
kubectl describe pod <pod-name>

# View logs
kubectl logs deployment/$DEPLOYMENT_NAME
kubectl logs <pod-name>

# Scale deployment
kubectl scale deployment $DEPLOYMENT_NAME --replicas=5

# Delete deployment
kubectl delete deployment $DEPLOYMENT_NAME
kubectl delete service $DEPLOYMENT_NAME

# Delete cluster (when done)
gcloud container clusters delete $CLUSTER_NAME --region=$REGION

EOF
}

# Cleanup function
cleanup() {
    log "Cleaning up resources..."
    
    read -p "Do you want to delete the deployment? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        kubectl delete deployment $DEPLOYMENT_NAME --ignore-not-found=true
        kubectl delete service $DEPLOYMENT_NAME --ignore-not-found=true
        success "Workload deleted"
    fi
    
    read -p "Do you want to delete the cluster? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        gcloud container clusters delete $CLUSTER_NAME --region=$REGION --quiet
        success "Cluster deleted"
    fi
}

# Main execution
main() {
    log "Starting GKE Autopilot deployment process..."
    
    case "${1:-deploy}" in
        "deploy")
            check_prerequisites
            setup_project
            create_cluster
            get_credentials
            deploy_workload
            verify_deployment
            show_commands
            ;;
        "verify")
            verify_deployment
            ;;
        "cleanup")
            cleanup
            ;;
        "help"|"-h"|"--help")
            cat << EOF
GKE Autopilot Setup Script

Usage: $0 [command]

Commands:
    deploy      Deploy cluster and workload (default)
    verify      Verify existing deployment
    cleanup     Clean up resources
    help        Show this help message

Environment Variables:
    PROJECT_ID      Google Cloud Project ID
    CLUSTER_NAME    Name of the GKE cluster (default: autopilot-cluster-1)
    REGION          Region for cluster deployment (default: us-central1)
    DEPLOYMENT_NAME Name of the nginx deployment (default: nginx-1)

Examples:
    $0 deploy
    PROJECT_ID=my-project REGION=us-west1 $0 deploy
    $0 cleanup

EOF
            ;;
        *)
            error "Unknown command: $1"
            echo "Use '$0 help' for usage information"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@"