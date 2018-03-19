# Manual Jenkins setup instructions

First, you have to have a kubernetes cluster configured,
and accessibly from kubectl.  Run the create.sh script
to create the jenkins environment and the necessary routing
rule.

Now, you can use jenkins_password.sh to get the admin
password.  Login with the admin user and this password to
bootstrap the configuration.

Once logged in, go to "Manage Jenkins" and then "Configure
Global Security."  There you can select the security realm
"Github authentication plugin" and set the oauth fields
appropriately from the github jenkins project.

Next, set authorization to be "Github committer authorization
strategy" and set the admin users to be comma separated names
and the organization to be lsst-epo.

Go to "Configure System" and to the vault configuration section
next.  The url is http://vault-vault:8200.  Enter a new cred with
kind being "Vault token credential".  In order to not break the
linking with the jobs, the ID should be:

78115cd2-68a6-41c3-ab2e-3b7d9303f6bf

Add the token created from vault to the token field, and auth
should be setup.

Last, set the timezone to be Phoenix, instead of UTC.  You can
do this in "Manage Jenkins" -> "Script console" and running
the following groovy script:

System.setProperty('org.apache.commons.jelly.tags.fmt.timeZone', 'America/Phoenix')

Now Jenkins time will be Tucson time.

After this, you can now sync the jobs to upload them and start
running them.
