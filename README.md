# Table of Contents
[Slide Deck](https://github.com/jvargh/github-actions-workshop/files/14057669/AKS-GithubActions.pdf)
1. [Introduction](#introduction)
2. [GitHub Actions - Demo 1](#github-actions---demo-1)
    - [Usage](#usage)
    - [Workflow 'sample1-cicd.yaml' Overview](#workflow-sample1-cicdyaml-overview)
    - [Jobs Breakdown](#jobs-breakdown)
        - [Lint](#1-lint)
        - [Test](#2-test)
        - [Deploy](#3-deploy)
3. [GitHub Actions - CI/CD with AKS and Terraform - Demo 2](#github-actions---cicd-with-aks-and-terraform---demo-2)
    - [Usage](#usage-1)
    - [Workflow: 01-actions-ci-cd-aks-tf-backend-jobs](#workflow-01-actions-ci-cd-aks-tf-backend-jobs)
    - [Jobs Breakdown](#jobs-breakdown-1)
        - [Create Terraform Infrastructure](#create-terraform-infrastructure)
        - [Build and Push Container](#build-and-push-container)
        - [Deploy App to AKS](#deploy-app-to-aks)
4. [GitHub Actions -- AKS CI/CD with PR and Merge - Demo 3](#github-actions----aks-cicd-with-pr-and-merge---demo-3)
    - [Usage](#usage-2)
    - [Workflow: 02-actions-ci-cd-aks-tf-backend-jobs](#workflow-02-actions-ci-cd-aks-tf-backend-jobs)
    - [Jobs Breakdown](#jobs-breakdown-2)
        - [Prepare Terraform](#prepare-terraform)
        - [Apply Terraform](#apply-terraform)
        - [Build-Push-Scan Container](#build-push-scan-container)
        - [Deploy App to AKS in Production](#deploy-app-aks-prod)
    - [Prerequisites](#prerequisites)
    
## Introduction

The aim of this repository is to demonstrate the capabilities of GitHub
Actions in facilitating the continuous integration and continuous
deployment (CI/CD) of web applications to Azure Kubernetes Service
(AKS). GitHub Actions stands out as a robust automation platform that
integrates seamlessly with GitHub repositories, enabling the automation
of software workflows with relative ease.

Utilizing GitHub Actions, we are empowered to craft complex workflows
that are capable of building, testing, and deploying code directly from
our GitHub repositories. This versatile platform provides the means to
react to various repository events, including push, pull requests, and
merges, with automated processes executed in customizable virtual
environments.

The sections that follow contain detailed descriptions of assorted labs.
These are designed to showcase the practical application of CI/CD
pipelines using GitHub Actions, offering a glimpse into how it adeptly
manages the entire lifecycle of a web application, from the initial code
commit to its eventual deployment.

## 

## GitHub Actions - Demo 1

This demonstration walks through a simple GitHub Actions workflow that
is divided into three jobs: **lint**, **test**, and **deploy**. This
workflow ensures that any new code pushed or merged into the **main**
branch or any branch matching the **sample1/\*\*** pattern goes through
a Continuous Integration (CI) pipeline before deployment.

### Usage

To use this workflow, push code changes to the **main** branch or create
a pull request against it. You can also push changes to branches
matching the **sample1/\*\*** pattern. To manually trigger the workflow,
use the GitHub UI to dispatch a new workflow run.

Customize this workflow by editing the
**.github/workflows/sample1-cicd.yaml** file. You can modify the
environment variables, runner type, and commands as needed for your
project.

### Workflow 'sample1-cicd.yaml' Overview

-   **File**: .github/workflows/sample1-cicd.yaml

-   **Trigger**: Push and pull request events to the **main** branch or
    the folder matching **sample1/\*\***.

-   This workflow can also be triggered manually via the
    **workflow_dispatch** event.

### Jobs Breakdown

#### 1. Lint

This job runs on the **ubuntu-latest** runner and performs the following
steps:

-   Checks out the repository using **actions/checkout@v3**.

-   Installs dependencies with **npm ci**.

-   Runs linting with **npm run lint**.

#### 2. Test

This job depends on the **lint** job and also runs on the
**ubuntu-latest** runner. It performs the following steps:

-   Checks out the repository using **actions/checkout@v3**.

-   Installs dependencies with **npm ci**.

-   Executes tests with **npm run test**.

#### 3. Deploy

This final job depends on the **test** job and runs on the
**ubuntu-latest** runner. It performs the following steps:

-   Checks out the repository using **actions/checkout@v3**.

-   Installs dependencies with **npm ci**.

-   Builds the project with **npm run build**.

-   Deploys the code, with an **echo** command simulating the deployment process.

## GitHub Actions - CI/CD with AKS and Terraform - Demo 2

This demonstration walks through a GitHub Actions workflow designed to
provision Azure resources using Terraform and deploy a .NET MVC
application to Azure Kubernetes Service (AKS).

### Usage

To use this workflow,

1.  Ensure all the prerequisites secrets are set up in your GitHub
    repository.

2.  Enable workflow
    **.github/workflows/01-actions-ci-cd-aks-tf-backend-jobs.yml** from
    Actions tab in GitHub.

3.  Trigger the workflow by pushing changes to the monitored paths
    (aks\_\*\*) or manually via the Actions tab. Monitor the Actions tab
    for progress and logs.

4.  For **Pull Requests**, push changes to main branch or when changes
    occur in the paths **aks_infra/\*\***, **aks_kubernetes/\*\***, or
    **aks_MvcApp/\*\***. Open a **PR** with changes in the same paths.

5.  Manual trigger through **workflow_dispatch**.

6.  Modify the workflow according to your requirements by updating
    environment variables to match your Azure environment and updating
    the **.NET MVC** Dockerfile and Kubernetes manifests as necessary.

### Workflow: 01-actions-ci-cd-aks-tf-backend-jobs

This CI/CD pipeline is defined in the
**.github/workflows/01-actions-ci-cd-aks-tf-backend-jobs.yml** file and
consists of three main jobs:

1.  **create-terraform-infra**: Sets up the Terraform backend in Azure,
    creates necessary Azure resources, and configures the Terraform
    state storage.

2.  **build-push-container**: Builds a Docker container image for the
    MVC application, scans it for vulnerabilities, and pushes it to
    Azure Container Registry (ACR).

3.  **deploy-app-aks**: Deploys the application to AKS using Kubernetes
    manifests.

### Jobs Breakdown

#### Create Terraform Infrastructure

-   Initializes and configures Terraform backend.

-   Replaces variables in **terraform.tfvars**.

-   Applies Terraform configuration to provision Azure resources.

#### Build and Push Container

-   Builds a Docker image from the .NET MVC application.

-   Scans the Docker image for vulnerabilities.

-   Pushes the Docker image to ACR.

#### Deploy App to AKS

-   Replaces image repository, name, and tag in the Kubernetes YAML
    deployment file.

-   Sets the AKS context for kubectl commands.

-   Deploys the application to AKS using Kubernetes manifests.

-   Runs kube-bench to check the cluster configuration.

## GitHub Actions -- AKS CI/CD with PR and Merge - Demo 3

 This repository demonstrates a CI/CD pipeline that automates the deployment of a web application to Azure Kubernetes Service (AKS). It leverages GitHub Actions for the orchestration of workflow steps and Terraform for the underlying infrastructure provisioning. The process begins with a pull request, which triggers initial checks. Following a successful review and merge, the pipeline proceeds to construct the infrastructure and deploy the application onto AKS.

### Usage

To run this workflow:

1.  Set up all the prerequisites and required secrets in your GitHub
    repository.

2.  Enable workflow
    **.github/workflows/02-actions-ci-cd-aks-tf-backend-jobs.yml** from
    Actions tab in GitHub.

3.  To trigger workflow, make changes to the monitored paths to trigger
    the workflow or use the GitHub UI to manually dispatch a run.

    -   **On push:** to the **main** branch, specifically for changes in
        **aks_infra/**, **aks_kubernetes/**, **aks_MvcApp/**, and the
        workflow file itself.

    -   **On pull request:** against the **main** branch for the same paths.

    -   **Manually:** through the **workflow_dispatch** event.

4.  Monitor the GitHub Actions tab for execution status.

5.  For customization, you may need to adjust the workflow file and
    associated configurations to fit your project\'s specifics. This can
    include:

    -   Changing the Azure region and resource names.

    -   Modifying the Dockerfile and Kubernetes manifest files.

    -   Updating Terraform files for infrastructure provisioning.

### Workflow: 02-actions-ci-cd-aks-tf-backend-jobs

This workflow is defined in
**.github/workflows/02-actions-ci-cd-aks-tf-backend-jobs.yml** and
consists of several jobs to plan and apply infrastructure changes, build
and push a Docker container, scan for vulnerabilities, and deploy to
AKS.

### Jobs Breakdown

#### prepare-terraform

Plans the Terraform changes without applying them. This job runs on pull
requests that haven\'t been merged.

#### apply-terraform

Applies the Terraform plan to update the backend infrastructure. This
job runs when a pull request is merged into the **main** branch.

#### build-push-scan-container

Builds the Docker image for the MVC application, pushes it to Azure
Container Registry (ACR), and scans it for vulnerabilities.

#### deploy-app-aks-prod

Deploys the application to AKS and performs a security assessment of the
cluster configuration.

### Prerequisites

-   Azure subscription and appropriate permissions.

-   GitHub repository secrets configured with Azure credentials. This is setup in Settings for the repository. Paste output of this cmd as value of AZURE_CREDENTIALS. The remaining ARM secrets are also derived from the output of this cmd.
    ```# az ad sp create-for-rbac --name "spn-githubactions" --role Owner --scope /subscriptions/<sub-id> --sdk-auth```
  
  ![image](https://github.com/jvargh/github-actions-workshop/assets/3197295/36a9584e-68c0-4392-8c3e-15e8420e3356)

-   Terraform and Docker configurations in place.
