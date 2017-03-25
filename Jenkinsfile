#!/usr/bin/env groovy

/**
 * Jenkinsfile for Chef cookbook for EOS
 * from https://github.com/aristanetworks/chef-eos/edit/develop/Jenkinsfile
 */

node('master') {

    currentBuild.result = "SUCCESS"

    try {

        stage ('Checkout') {

            checkout scm
            sh """
                eval "\$(chef shell-init bash)"

            """
        }
        stage ('Chef Linttest') {

            try {
                sh """
                    eval "\$(chef shell-init bash)"
                    chef exec delivery local lint
                """
            }
            catch (Exception err) {
                currentBuild.result = "UNSTABLE"
            }
            echo "RESULT: ${currentBuild.result}"
        }
        stage ('Chef Syntaxtest') {

            try {
                sh """
                    eval "\$(chef shell-init bash)"
                    chef exec delivery local syntax
                """
            }
            catch (Exception err) {
                currentBuild.result = "UNSTABLE"
            }
            echo "RESULT: ${currentBuild.result}"
        }

        stage ('ChefSpec Unittest') {

            sh """
                eval "\$(chef shell-init bash)"
                chef exec delivery local Unittest
            """

            step([$class: 'JUnitResultArchiver', testResults: 'result.xml'])

        }

        stage ('TestKitchen integration') {

            // wrap([$class: 'AnsiColorSimpleBuildWrapper', colorMapName: "xterm"]) {
                sh """
                    eval "\$(chef shell-init bash)"
                    chef exec kitchen test
                """
            // }
        }

        stage ('Cleanup') {

            echo 'Cleanup'

            step([$class: 'WarningsPublisher',
                  canComputeNew: false,
                  canResolveRelativePaths: false,
                  consoleParsers: [
                                   [parserName: 'Rubocop'],
                                   [parserName: 'Foodcritic']
                                  ],
                  defaultEncoding: '',
                  excludePattern: '',
                  healthy: '',
                  includePattern: '',
                  unHealthy: ''
            ])

           mail body: "${env.BUILD_URL} build successful.\n" +
                      "Started by ${env.BUILD_CAUSE}",
                from: 'steve@bigsteve.us',
                replyTo: 'steve@bigsteve.us',
                subject: "Chef_repo_server ${env.JOB_NAME} (${env.BUILD_NUMBER}) build successful",
                to: 'steve@bigsteve.us'

        }

    }

    catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "${env.JOB_NAME} (${env.BUILD_NUMBER}) cookbook build error " +
                       "is here: ${env.BUILD_URL}\nStarted by ${env.BUILD_CAUSE}" ,
                 from: 'steve@bigsteve.us',
                 replyTo: 'steve@bigsteve.us',
                 subject: "chef_repo_server ${env.JOB_NAME} (${env.BUILD_NUMBER}) build failed",
                 to: 'steve@bigsteve.us'

            throw err
    }

}
