JENKINS_URL=http://localhost:8080/
USERNAME=admin
API_TOKEN=1132c93292182780576372d2522071c094

GIT_REPO_URL=https://github.com/Akhilg-02/WebdriveIO-test.git
BRANCH_NAME=main
JENKINSFILE_PATH=JenkinsFile
JOB_NAME=testjob1

# Retrieve the Jenkins security crumb
CRUMB=$(curl -u "$USERNAME:$API_TOKEN" -s "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")

echo "CRUMB: $CRUMB"

# Encode the username and password in base64
AUTH_HEADER="Authorization: Basic $(echo -n $USERNAME:$API_TOKEN | base64)"

# Define the Jenkins job XML configuration
JOB_XML=$(cat <<EOF
<flow-definition plugin="workflow-job@2.43">
	<actions/>
	<description/>
	<keepDependencies>false</keepDependencies>
	<properties/>
	<definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.90">
		<scm class="hudson.plugins.git.GitSCM" plugin="git@4.10.0">
			<configVersion>2</configVersion>
			<userRemoteConfigs>
				<hudson.plugins.git.UserRemoteConfig>
					<url>$GIT_REPO_URL</url>
				</hudson.plugins.git.UserRemoteConfig>
			</userRemoteConfigs>
			<branches>
				<hudson.plugins.git.BranchSpec>
					<name>$BRANCH_NAME</name>
				</hudson.plugins.git.BranchSpec>
			</branches>
			<doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
			<submoduleCfg class="list"/>
			<extensions/>
		</scm>
		<scriptPath>$JENKINSFILE_PATH</scriptPath>
		<lightweight>true</lightweight>
	</definition>
	<triggers/>
	<quietPeriod>0</quietPeriod>
</flow-definition>

EOF
)
# Create a new Jenkins job
curl -X POST "$JENKINS_URL/createItem?name=$JOB_NAME" -d "$JOB_XML" -H "$AUTH_HEADER" -H "Jenkins-Crumb:$CRUMB" -H "Content-Type: application/xml"

# Trigger the Jenkins job
curl -X POST "$JENKINS_URL/job/$JOB_NAME/build" -H "$AUTH_HEADER" -H "Jenkins-Crumb:$CRUMB"
