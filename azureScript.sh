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

# #!/bin/bash

# # Azure DevOps Organization URL
# ORG_URL="https://dev.azure.com/akhilgupta0017/"

# # Personal Access Token
# PAT="m4f7m2boy7s54vymsja4jb7tpnaoeeay3w2y4q2p7hf6pvywxeiq"

# # Azure DevOps Project Name
# PROJECT_NAME="WebioAzureTest"

# # Pipeline ID (You can find this in the URL when you open the pipeline)
# PIPELINE_ID="1"

# # Job Name
# NEW_JOB_NAME="newAzureScript"

# # Azure Pipeline Configuration File
# PIPELINE_CONFIG_FILE="azure-pipeline.yml"

# # Create a new job in the pipeline
# NEW_JOB_DEFINITION=$(cat <<EOF
# {
#   "name": "$NEW_JOB_NAME",
#   "jobs": [
#     {
#       "job": "jobScript",
#       "displayName": "Your New Job",
#       "steps": [
#         {
#           "powershell": "Write-Host 'Running your new job'"
#         }
#       ]
#     }
#   ]
# }
# EOF
# )

# # Create a new job in the pipeline
# echo "$NEW_JOB_DEFINITION" > new-job-definition.json

# # Add the new job definition to the pipeline YAML configuration
# echo "jobs:" >> $PIPELINE_CONFIG_FILE
# echo "  - job: $NEW_JOB_NAME" >> $PIPELINE_CONFIG_FILE
# echo "    displayName: $NEW_JOB_NAME" >> $PIPELINE_CONFIG_FILE
# echo "    steps:" >> $PIPELINE_CONFIG_FILE
# echo "      - template: new-job-definition.json" >> $PIPELINE_CONFIG_FILE

# # Commit and push the changes to your Git repository
# git add $PIPELINE_CONFIG_FILE
# git commit -m "Added new job definition to the pipeline YAML"
# git push

# # Trigger the Azure Pipeline using the REST API
# curl -X POST -u "username:$PAT" -H "Content-Type: application/json" -d "{\"resources\": []}" "$ORG_URL/$PROJECT_NAME/_apis/pipelines/$PIPELINE_ID/runs?api-version=6.0-preview.1"

