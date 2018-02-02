#/bin/bash
#A script to check for long running jenkins jobs and send an email
#dependencies 'jq'
jenkins_url_prefix=$1 # Mandatory
alert_email=$2 # Mandatory to send an Email
ignore_node=$3 # Optional if you want to ignore multiple please use 'foo*\|boo*'

echo "Printing the number of jenkins nodes with executors"
for jenkins_node_name in `curl -f --silent http://${jenkins_url_prefix}/jenkins/computer/api/json?pretty=true | jq -r .computer[].displayName`; do
  if [ "$jenkins_node_name" == "master" ]
    then
      echo "Lets skip the check for $jenkins_node_name";
    elif [[ -n "`echo $jenkins_node_name | grep -e $ignore_node`"  ]];
      then
        echo "Lets skip the check for $jenkins_node_name";
    else
      jenkins_node_details_json="`curl -f --silent ${jenkins_url_prefix}/jenkins/computer/${jenkins_node_name}/api/json`"
      num_of_executors_1="`echo $jenkins_node_details_json | jq .numExecutors`"; num_of_executors="$(( num_of_executors_1 - 1 ))"
      echo "$jenkins_node_name has $num_of_executors executors"
      for executor_number in `seq 0 $num_of_executors`; do
        command_check='1'
        executor_details="`curl -f --silent ${jenkins_url_prefix}/jenkins/computer/${jenkins_node_name}/executors/${executor_number}/api/json`"
        if [ "`echo $executor_details | jq -r .progress`" == "-1" ]; then
          echo $executor_details | jq . | grep '"currentWorkUnit": {},' >/dev/null 2>&1
          command_check="$?"
        fi
        if [ "$command_check" -eq '0' ]; then
          echo "$jenkins_node_name - thread $(( executor_number + 1 )) stuck. needs restarting";
          exit_condition="$(( exit_condition + 1 ))"
        fi
        if [[ ! -z $(printf '%s\n' "${excluded_jobs_array[@]}" | grep -w "`echo $executor_details | jq -r .currentExecutable.url | cut -d'/' -f6`") ]]; then
          continue
        fi
        if [ "`echo $executor_details | jq -r .likelyStuck`" == "true" ]; then
          echo "`echo $executor_details | jq -r .currentExecutable.url` This Jenkins job seems to be stuck. Please check. Email sent to $alert_email"
          echo "`echo $executor_details | jq -r .currentExecutable.url` This Jenkins job seems to be stuck. Please check." | mail -s "A Jenkins job seems to be stuck" $alert_email
          exit_condition="$(( exit_condition + 1 ))"
        fi
      done
    fi
done
