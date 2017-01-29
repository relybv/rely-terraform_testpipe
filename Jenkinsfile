node {
   wrap([$class: 'AnsiColorBuildWrapper']) {
      properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '6')), pipelineTriggers([pollSCM('H/15 * * * *')])])
      stage('Checkout') { // for display purposes
         // Clean workspace before checkout
         step ([$class: 'WsCleanup'])
         // Get some code from a GitHub repository
         git 'https://github.com/relybv/rely-terraform_testpipe.git'
      }
      stage('Dependencies') {
         sh 'cd $WORKSPACE'
//         sh '/usr/bin/bundle install --jobs=2 --path vendor/bundle'
      }
      stage('Code quality') {
         parallel (
//            syntax: { sh '/usr/bin/bundle exec rake syntax' },
//            lint: { sh '/usr/bin/bundle exec rake lint' },
            spec: { sh '/usr/local/bin/terraform validate' }
         )
//         step([$class: 'JUnitResultArchiver', testResults: 'spec/reports/*.xml'])
//         junit 'spec/reports/*.xml'
      stage('Documentation') {
         sh '/usr/local/bin/terraform-doc'
         publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: false, reportDir: 'doc', reportFiles: 'index.html', reportName: 'HTML Report'])
      }
      stage('Acceptance tests') 
      {
         withEnv(['OS_AUTH_URL=https://access.openstack.rely.nl:5000/v2.0', 'OS_TENANT_ID=10593dbf4f8d4296a25cf942f0567050', 'OS_TENANT_NAME=lab', 'OS_PROJECT_NAME=lab', 'OS_REGION_NAME=RegionOne']) {
            withCredentials([usernamePassword(credentialsId: 'OS_CERT', passwordVariable: 'OS_PASSWORD', usernameVariable: 'OS_USERNAME')]) {
//                sh 'BEAKER_set="openstack-ubuntu-server-1404-x64" /usr/bin/bundle exec rake setbeaker_env > openstack-ubuntu-server-1404-x64.log'
//                try {
                   // False if failures in logfile
//                   sh "grep --quiet Failures openstack-ubuntu-server-1404-x64.log"
//                   sh "grep -A100000 Failures openstack-ubuntu-server-1404-x64.log"
//                   currentBuild.result = 'FAILURE'
//                   emailext attachLog: true, body: '', recipientProviders: [[$class: 'DevelopersRecipientProvider']], subject: 'SUCCESS', to: 'paulgomersbach+euxeg3u1sxmmdpq07rcm@boards.trello.com'
//                } catch (Exception err) {
//                   currentBuild.result = 'SUCCESS'
//                }
               }
            }
         }
      }
   }
   archiveArtifacts '*.log'
}
