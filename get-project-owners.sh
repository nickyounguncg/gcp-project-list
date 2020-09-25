#!/bin/bash
#
# This script takes a CSV that contains project information (from the other script in this repo)
# then looks up the ownership...then outputs the project info + owners in a CSV format
# 
# Run this while writing the output to a CSV on disk (instead of STDOUT) and you'll have a nice
# data file that can be charted using Google Data Studio, or otherwise filtered/analyzed.
#
# Example Usage: ./get-project-owners.sh path/to/input/file.csv > output_all_project_details.csv
#
if [ $# -eq 0 ]
then
	echo "you must pass in the path to a CSV file containing the project details";
else
	input=$1
	# Set "," as the field separator, and loop through the rows, setting fields as variables that we can use later 
	while IFS=',' read -r create_time name projectNumber projectId lifecycleState
	do 
		# loop through all the permission results for the projectID, looking for the owner role
		for robot in $(gcloud projects get-iam-policy $projectId --flatten="bindings[].members" --format="csv(bindings.members)" --filter="bindings.role:owner")
		do
		# if the owner is a user (not a service account), then print the user info
		if echo $robot | grep -q user; then
			printf "$create_time,$name,$projectNumber,$projectId,$lifecycleState,";
			printf $robot | grep user
			#printf "\n";
		else
			# no user owner was found, so just print a standard field in that place for easy reporting
			printf "$create_time,$name,$projectNumber,$projectId,$lifecycleState,NO_OWNER_USER\n";
		fi
		done

	done < "$input"

fi
