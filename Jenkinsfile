node {
   wrap([$class: 'AnsiColorBuildWrapper']) {
      properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '6')), pipelineTriggers([pollSCM('H/15 * * * *')])])
      stage('Checkout') { // for display purposes
         // send to slack
         slackSend "Started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
         // Get some code from a GitHub repository
         git 'https://github.com/relybv/rely-terraform_testpipe.git'
      }
      stage('Dependencies') {
         sh 'cd $WORKSPACE'
      }
      stage('Code quality') {
         parallel (
            validate: { sh '/usr/local/bin/terraform validate' }
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
               if (fileExists('/var/lib/jenkins/.ssh/id_rsa')) {
                 echo 'Skip ssh-keygen'
               } else {
                 sh "ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''"
               }
               sh "openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout star_notarisdossier_nl.key -out star_notarisdossier_nl.crt -subj \"/CN=openstacklocal\" -days 3650"
               sh "cat star_notarisdossier_nl.crt star_notarisdossier_nl.key > star_notarisdossier_nl.pem"
               sh "TF_VAR_environment=${env.BUILD_NUMBER} /usr/local/bin/terraform plan -no-color | tee TFPLAN.md"
               sh "TF_VAR_environment=${env.BUILD_NUMBER} /usr/local/bin/terraform apply -no-color | tee TFEXEC.md"
            }
            stage('Performance tests')
            {
               // replace PERFTARGET in *.yml using loadurl output from terraform
               sh 'perftarget=$(/usr/local/bin/terraform output loadurl -no-color); sed -ie "s,PERFTARGET,$perftarget,g" perftests/*.yml; sed -ie "s,PERFTARGET,$perftarget,g" perftests/*.rb'
               // start load tests
               sh 'bzt perftests/load.yml -o settings.artifacts-dir="${WORKSPACE}/perftests/output/"'
               step([$class: 'JUnitResultArchiver', testResults: 'perf-junit.xml'])
               junit 'perf-junit.xml'
               sh 'xvfb-run -a ruby perftests/acc.rb'
            }
            stage('Acceptance tests')
            {
               // start acceptance tests
               sh 'xvfb-run -a ruby perftests/acc.rb'
            }
            stage('Cleanup')
            {
               sh "TF_VAR_environment=${env.BUILD_NUMBER} /usr/local/bin/terraform destroy -force -no-color | tee TFDEST.md"
            }
         }
      }
   }

   archiveArtifacts '*.md'
   archiveArtifacts '*.png'
   perfReport 'perf-plot.xml'

}
