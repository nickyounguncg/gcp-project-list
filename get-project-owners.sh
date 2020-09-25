#!/bin/bash
input=$1
# Set "," as the field separator using $IFS 
# and read line by line using while read combo 
while IFS=',' read -r create_time name projectNumber projectId
do 
	for robot in $(gcloud projects get-iam-policy $projectId --flatten="bindings[].members" --format="csv(bindings.members)" --filter="bindings.role:owner")
	do
	if echo $robot | grep -q user; then
		printf "$create_time,$name,$projectNumber,$projectId,";
		printf $robot | grep user
		#printf "\n";
	else
		printf "$create_time,$name,$projectNumber,$projectId,NO_OWNER_USER\n";
	fi
	done

done < "$input"
