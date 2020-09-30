#!/bin/bash
# Usage to get projects from one ORG ID: ./get-project-list.sh 123456789
# Usage to get projects from all (that you have access to): ./get-project-list.sh
# Results: CSV containing Create Time, Name, Project Number, Project ID, Life Cycle State
# Project fields that can be returned are documented here: https://cloud.google.com/sdk/gcloud/reference/projects/describe
#
# if the first argument is not passed in, then assume that we want to grab ALL projects, not just from a particular ORG ID
if [ $# -eq 1 ]
then
  # if the first argument IS passed in, then only return projects from that ORG ID
  gcloud projects list --filter "parent.type=organization parent.id=$1" --format="csv(createTime.date('%Y-%m-%d'),name,projectNumber,projectId,lifecycleState)"
else
	gcloud projects list --format="csv(createTime.date('%Y-%m-%d'),name,projectNumber,projectId,lifecycleState)"
fi
