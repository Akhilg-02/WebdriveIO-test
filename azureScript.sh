#!/bin/bash

# Azure DevOps Organization URL
ORG_URL="https://dev.azure.com/akhilgupta0017/"

# Personal Access Token
PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"

# Azure DevOps Project Name
PROJECT_NAME="WebioAzureTest"

# Pipeline ID (You can find this in the URL when you open the pipeline)
PIPELINE_ID="1"

# Set the GitHub Repository URL here
GITHUB_REPO_URL="https://github.com/Akhilg-02/WebdriveIO-test.git"

# Azure Pipeline Configuration File
PIPELINE_CONFIG_FILE="azure-pipeline.yml"

# The specific branch you want to target
BRANCH="main"

# Checkout the branch
git checkout $BRANCH

# Create a dynamic job template for the pipeline YAML
NEW_JOB_NAME="newAzureScript_$BRANCH"
DYNAMIC_JOB_DEFINITION=$(cat <<EOF
    - template: job-template.yml
      parameters:
        jobName: "testazureScript"
        branch: $BRANCH
EOF
)

echo "$DYNAMIC_JOB_DEFINITION" > $PIPELINE_CONFIG_FILE

# Commit and push the changes to the pipeline YAML
git add $PIPELINE_CONFIG_FILE
git commit -m "Added dynamic job template for $BRANCH to the pipeline YAML"
git push

# Trigger the Azure Pipeline using the REST API with the predefined GitHub repo URL
curl -X POST -u "username:$PAT" -H "Content-Type: application/json" -d "{\"resources\": [{\"repositories\":[\"$GITHUB_REPO_URL\"]}]" "$ORG_URL/$PROJECT_NAME/_apis/pipelines/$PIPELINE_ID/runs?api-version=6.0-preview.1"

# -------------------------------------------------------------------------------------------
#!/bin/bash

# # Define your Azure DevOps organization, project, and pipeline information
# ORG_NAME="akhilgupta0017"
# PROJECT_NAME="WebioAzureTest"
# PIPELINE_ID="1"
# NEW_JOB_NAME="newAzureScript"

# # Your Personal Access Token (PAT) - Replace with your own token
# PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"

# # GitHub repository URL where the code is located
# GITHUB_REPO_URL="https://github.com/Akhilg-02/WebdriveIO-test"

# # Download the azure-pipeline.yml content from GitHub
# # AZURE_PIPELINE_CONTENT=$(curl -sL "$GITHUB_REPO_URL/blob/main/azure-pipelines.yml")

# curl -sL "$GITHUB_REPO_URL/blob/main/azure-pipelines.yml" -o azure-pipeline.yml

# # Trigger a new job in the Azure Pipeline
# curl -X POST \
#   -H "Content-Type: application/json" \
#   -H "Authorization: Basic $PAT" \
#   -d '{
#     "resources": {
#         "repositories": {
#             "self": {
#                 "refName": "refs/heads/main"
#             }
#         }
#     },
#     "templateParameters": {
#         "newJobName": "'"${NEW_JOB_NAME}"'",
#         "githubRepoUrl": "'"${GITHUB_REPO_URL}"'"
       
#     }
# }' "https://dev.azure.com/${ORG_NAME}/${PROJECT_NAME}/_apis/pipelines/${PIPELINE_ID}/runs?api-version=7.1-preview.1"



# ----------------------------------------------------------------------------------
# #!/bin/bash

# PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"
# # ORGANIZATION_URL="https://dev.azure.com/akhilgupta0017/WebioAzureTest/_build"
# PROJECT_NAME="akhilgupta0017"
# PIPELINE_ID="1"
# PIPELINE_NAME="testAzurescript"
# ORG_NAME="akhilgupta0017"

# # Find the full path to the Azure CLI executable
# AZURE_CLI_PATH="C:/Program Files (x86)/Microsoft SDKs/Azure/CLI2/wbin/az"  # Update this path as needed

# # Check if the Azure CLI is installed
# if [ -x "$AZURE_CLI_PATH" ]; then
#   $AZURE_CLI_PATH devops login --organization $ORG_NAME --pat $PAT
#   $AZURE_CLI_PATH pipelines run --name $PIPELINE_NAME --project $PROJECT_NAME
# else
#   echo "Azure CLI is not installed or not in the system PATH."
# fi




# --------------------------------------------------------------------------------------------------
# #!/bin/bash

# # Azure DevOps Variables
# ORGANIZATION="akhilgupta0017"
# PROJECT="WebioAzureTest"
# PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"

# # GitHub Variables
# GITHUB_REPO="https://github.com/Akhilg-02/WebdriveIO-test.git" # GitHub repository name
# GITHUB_BRANCH="main"  # GitHub branch for which you want to create a pipeline

# # Define the YAML pipeline configuration---------------------------------
# PIPELINE_YAML='
# trigger:
# - main

# pr:
# - '*'

# jobs:
# - job: Build
#   pool:
#     vmImage: window-latest
#   steps:
#   - script: echo Hello, World!
#     displayName: 'Run a script'
# '

# # # ---------------------------------------------------------------------------

# # Create a JSON payload with the YAML pipeline configuration
# JSON_PAYLOAD="{\"name\":\"NewPipeline\", \"configuration\":\"$PIPELINE_YAML\"}"

# # Azure DevOps API URL to create a new pipeline
# API_URL="https://dev.azure.com/$ORGANIZATION/$PROJECT/_apis/pipelines?api-version=7.0-preview.1"

# # Create a new pipeline in Azure DevOps
# response=$(curl -X POST -H "Authorization: Basic $PAT" -H "Content-Type: application/json" -d "$JSON_PAYLOAD" $API_URL)

# # Check the response
# if [ $? -eq 0 ]; then
#   echo "Azure DevOps Pipeline Created Successfully"
# else
#   echo "Failed to Create Azure DevOps Pipeline"
#   echo "Response: $response"
# fi

# # Extract the new pipeline ID from the response using Node.js
#  PIPELINE_ID=$(node -e "console.log(JSON.parse(process.argv[1]).id)" "$response")
# # PIPELINE_ID='1'
# # Azure DevOps API URL to trigger the new pipeline
# TRIGGER_API_URL="https://dev.azure.com/$ORGANIZATION/$PROJECT/_apis/pipelines/$PIPELINE_ID/runs?api-version=7.1-preview"

# # Trigger the new pipeline
# trigger_response=$(curl -X POST -H "Authorization: Basic $PAT" -H "Content-Type: application/json" $TRIGGER_API_URL)

# # Check the trigger response
# if [ $? -eq 0 ]; then
#   echo "Azure DevOps Pipeline Triggered Successfully with the new pipeline ID: $PIPELINE_ID"
# else
#   echo "Failed to Trigger Azure DevOps Pipeline"
#   echo "Trigger Response: $trigger_response"
# fi


# --------------------------------------------------------------------

# #!/bin/bash

# # Set the new pipeline name
# NEW_PIPELINE_NAME="scriptWebioTest"

# # Azure DevOps Variables
# ORGANIZATION="akhilgupta0017"
# PROJECT="WebioAzureTest"
# PIPELINE_ID="1"  # The ID of your Azure DevOps pipeline
# PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"

# # Azure DevOps API URL
# API_URL="https://dev.azure.com/$ORGANIZATION/$PROJECT/_apis/pipelines/$PIPELINE_ID/runs?api-version=7.2-preview.1"
# # POST https://dev.azure.com/{organization}/{project}/_apis/pipelines/{pipelineId}/runs?api-version=7.2-preview.1

# # Create a JSON payload with the new pipeline name
# JSON_PAYLOAD="{\"resources\": {\"repositories\": {\"self\": {\"refName\": \"$NEW_PIPELINE_NAME\"}}}}"

# # Trigger Azure DevOps Pipeline with the new pipeline name
# response=$(curl -X POST -H "Authorization: Basic $PAT" -H "Content-Type: application/json" -d "$JSON_PAYLOAD" $API_URL)

# # Check the response
# if [ $? -eq 0 ]; then
#   echo "Azure DevOps Pipeline Triggered Successfully with the new pipeline name: $NEW_PIPELINE_NAME"
# else
#   echo "Failed to Trigger Azure DevOps Pipeline"
#   echo "Response: $response"
# fi


# ---------------------------------------------------------------------
# #!/bin/bash

# # Azure DevOps Variables
# ORGANIZATION="akhilgupta0017"
# PROJECT="scriptWebio-test"
# PIPELINE_ID="1"  # The ID of your Azure DevOps pipeline
# PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"

# # Azure DevOps API URL
# API_URL="https://dev.azure.com/$ORGANIZATION/$PROJECT/_apis/pipelines/$PIPELINE_ID/runs?api-version=7.1-preview.1"

# # Trigger Azure DevOps Pipeline
# response=$(curl -X POST -H "Authorization: Basic $PAT" -H "Content-Type: application/json" -d "{}" $API_URL)
# echo "Response: $response"
# # Check the response
# if [ $? -eq 0 ]; then
#   echo "Azure DevOps Pipeline Triggered Successfully"
# else
#   echo "Failed to Trigger Azure DevOps Pipeline"
#   echo "Response: $response"
# fi
