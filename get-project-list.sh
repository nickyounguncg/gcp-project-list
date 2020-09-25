#!/bin/bash
gcloud projects list --format="csv(createTime.date('%Y-%m-%d'),name,projectNumber,projectId)"
