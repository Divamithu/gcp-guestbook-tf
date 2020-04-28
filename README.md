# DEV, UAT and PROD environments in GCP

Define the following values for variables in `Settings -> CI/CD -> Variables` before running pipeline:

`TF_VAR_mysql_user_password` - mysqluser-password \
`TF_VAR_postgresql_user_password` - postgres-user-password \
`TF_VAR_postgresql_username` - postgres-username \
`TF_VAR_uat_postgresql_user_password` - uat-postgres-user-password \
`DEV_GCP_CREDS` - content of DEV service account json key \
`PROD_GCP_CREDS` - content of PROD service account json key \
`UAT_GCP_CREDS` - content of UAT service account json key

Run Pipeline on master branch and run jobs manually 
