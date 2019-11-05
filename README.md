# TFE PoC 

## Test Cases

### Workspace Workflow
#### Setup VCS integration
Follow steps for desired VCS here:
https://www.terraform.io/docs/cloud/vcs/index.html

#### Workspace configuration
1. Open TFE in the browser (http://TFE_SERVER)
2. Login with admin user
3. Click on "New workspace"
4. Select desired VCS connectivity
5. Select a repository
6. Enter name
7. (Optional) Specify folder containing terraform code
8. (Option) Specify branch to track
9. Click Ok
10. Enter any variables needed

#### Validation
1. Run execution manually by pressing the button
2. Push a change to the branch of the git repo being tracked (master is default) and see the execution is triggered

### Terraform Code Review
1. Terraform Enterprise allows segregation of roles, with team members responsible for creating and managing modules, creating and managing Sentinel policies and creating and managing Terraform code.

Workflow
<DIAGRAM HERE>

2. Terraform code can be a living, evolving document. Usually it starts with all resources in the same file, and eventually as complexity grows, the team can identify areas that can be separated into independent files or in external modules.

3. Terraform will look for all files with .tf extension in a folder, and create a dependency graph internally to help it decide in which sequence resources will be created. Beacuse of that, it doesnt matter if all resources are in a main.tf or in multiple files (main.tf, network.tf, security.tf, etc).

4. Using modules is a best practice in enterprise because it allows code reuse and enforcing compliance and best practices.

5. Workflows for the Private Module Registry and for Sentinel will have their own test cases.

### Control de Permissos Terraform
1. On the TFE browser, go to "Settings" and create three groups: "admin", "users" and "superusers". 
2. Create three users, and assign each one to each of these groups
3. Go to the workspace created in the previous example, go to "Settings"> "Permissions" and assign the following permissions: "admin" has admin rights, "users" can plan and "superusers" can apply
4. Log out of the admin user and log in with each one of the 3 users created, validating that their permissions are constrained by which group they are in

#### SAML Integration
These docs describe the steps to configure integration with Active Directory, Okta and OneLogin:
https://www.terraform.io/docs/enterprise/saml/identity-provider-configuration-adfs.html

### Terraform Workflow - Variables
#### Manually
1. Open the workspace created above
2. Change variables
3. Run a plan to validate changes

#### *Terraform Enterprise Provider*
TODO
1. Do one example using Terraform Enterprise provider
https://www.terraform.io/docs/providers/tfe/index.html
Will need a user token, workspace id, tfe url, tfe certificate

#### *Terraform Enterprise API*
TODO
1. Do one example using Terraform Enterprise API
https://www.terraform.io/docs/cloud/api/variables.html
ill need a user token, workspace id, tfe url, tfe certificate

### Integracion con Azure KeyVault y Vault
TODO
1. Ensure TErraform code using the two resources:
#### Azure KeyVault
https://www.terraform.io/docs/providers/azurerm/r/key_vault.html
Needs Azure API keys

#### Vault
https://www.terraform.io/docs/providers/vault/index.html
Needs Vault token with sufficient permissions

2. Create workspace, update variables with API keys, run
3. Log to Azure to validate
4. Log to Vault to validate

### Terraform Workflow - Githook Merge
1. Open a TFE workspace, validate it is tracking the "master" branch
2. Create a branch "test" on git repo, do a change and push it to the repo
3. Validate no runs triggered on TFE
4. Merge "test" to "master"
5. Validate TFE strated a run

### Terraform Workflow - Plan
1. Log in as user with "plan" permission. Run a manual plan
2. Do a change in git to trigger a plan
3. Log in with a different user
4. Validate code can be reviewed before applying, and that sequencial executions are queued

### Terraform Workflow - Approval
1. Log in as user with "apply" permission
2. Validate that there are pending plans, cancel one and do the apply on the other

### Terraform Workflow - History
1. Open the workspace history to validate history of runs

### Terraform API Calls
TODO
GO over this code: https://github.com/hashicorp/terraform-guides/tree/master/operations/automation-script

### Terraform Cost Management
TODO
1. Simple AWS code creating resources
2. Ensure it is Terraform 0.12
3. Validate costs shown
4. Talk about roadmap for Azure and GCP

### Self Documenting Features
1. Go over Terraform code and explain how it can be used to validate infrastructure
2. Go over history of runs of each workspace to validate documentation

### Integration with Active Directory
TODO - Review to present
These docs describe the steps to configure integration with Active Directory, Okta and OneLogin:
https://www.terraform.io/docs/enterprise/saml/identity-provider-configuration-adfs.html

### TF State Management
1. Open a terminal in the computer where Terraform is running
2. Find the drive where the state files are being maintained
3. Ensure that state files are encrypted

### Private Module Registry - Lifecycle
TODO
1. Ensure terraform code with module. Structure and naming scheme expected found here 
https://www.terraform.io/docs/modules/index.html
2. Create a new module, pointing to this code
3. Push a tag to module, validate new version is available in Private Module Registry
4. Ensure separate repository with reference to this module
5. Create a workspace, run, validate worked corectly
6. Update module and push, alongside a tag. Validate new version of module available, however it does not trigger a run on workspaces using that module, since they have independent lifecycles

### Private Module Registry - Configuration Designer
1. Click on Private Module Registry
2. Select configuration designer
3. Select desired module
4. Enter values for variables
5. Copy and paste resulting code in a different repository
6. Ensure this repository is associated with workspace, trigger run

### Sentinel Workflow
1. Ensure code with Sentinel rules
2. Talk about the .sentinel file that specifies scope
3. Create rule associated with this git repository
4. Validate rules created and applied, by running a plan
5. Change the original code and do a git push
6. Validate Sentinel rules updated
7. Validate existing workspaces not impacted, need a new run for new rules to be applied. This shows they have two different lifecyles, allowing two distinct teams to manage
8. Discuss how Sentinel policies can be enforced on a recurring basis by running a cron job that triggers plans hourly using API calls and having notications set up

### TFE Notifications
TODO diagram
1. Open workspace
2. Go to "Settings"> "Notifications"
3. Talk about the two different types of integration
<diagram Service Now>
https://medium.com/hashicorp-engineering/terraform-enterprise-and-friends-2620bdfd1951

### Terraform Workflow - Code lifecycle
#### Workspace
1. Do a change and push code to a repository tracked by workspace, validate the changes
#### Modules
1. Do a change and push code to a repository tracked by a module, validate nothing changes
2. Push a new gittag to the repsository tracked by module, ensure new version shows up
#### Sentinel
1. Do a change and push code to respository associated with Sentinel policy, validate changes

### Audit Logs
TODO
1. Log in to TFE server
2. Open log XXX
3. Validate information
4. Discuss how to ship this log to a log management platform like Splunk, Datadog or logstash
<diagram logs>

### Integration with External Tools
Review API calls 
https://github.com/hashicorp/terraform-guides/tree/master/operations/automation-script
Discuss how tools can use this

Review Notifications
https://medium.com/hashicorp-engineering/terraform-enterprise-and-friends-2620bdfd1951
Discuss how tools can use this



