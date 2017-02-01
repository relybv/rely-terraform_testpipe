node {
   wrap([$class: 'AnsiColorBuildWrapper']) {
      properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '6')), pipelineTriggers([pollSCM('H/15 * * * *')])])
      stage('Checkout') { // for display purposes
         // Get some code from a GitHub repository
         git 'https://github.com/relybv/rely-terraform_testpipe.git'
      }
      stage('Dependencies') {
         sh 'cd $WORKSPACE'
      }
      stage('Code quality') {
         parallel (
//            syntax: { sh '/usr/bin/bundle exec rake syntax' },
//            lint: { sh '/usr/bin/bundle exec rake lint' },
            spec: { sh '/usr/local/bin/terraform validate' }
         )
      }
      stage('Documentation') {
         sh '/usr/local/bin/terraform-docs markdown ./ | tee TF.md'
         sh 'terraform graph | dot -Tpng > graph.png'
      }
      withEnv(['OS_AUTH_URL=https://access.openstack.rely.nl:5000/v2.0', 'OS_TENANT_ID=10593dbf4f8d4296a25cf942f0567050', 'OS_TENANT_NAME=lab', 'OS_PROJECT_NAME=lab', 'OS_REGION_NAME=RegionOne']) {
         withCredentials([usernamePassword(credentialsId: 'OS_CERT', passwordVariable: 'TF_VAR_password', usernameVariable: 'TF_VAR_user_name')]) {
            stage('Provisioning') 
            {
               sh '/usr/local/bin/terraform plan -no-color | tee TFPLAN.md'
               sh '/usr/local/bin/terraform apply -no-color | tee TFEXEC.md'
            }
            stage('Acceptance tests')
            {
               sh 'echo selenium tests'
            }
            stage('Cleanup')
            {
               sh '/usr/local/bin/terraform destroy -force -no-color | tee TFDEST.md'
            }
         }
      }
   }
   archiveArtifacts '*.md'
   archiveArtifacts '*.png'
}
