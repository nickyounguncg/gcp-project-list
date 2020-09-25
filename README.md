# gcp-project-list
Scripts to pull information about projects from Google Cloud Platform.

## Instructions 
 - Clone this repo locally.
 
 - Open Google Cloud Shell in your browser as a Org Admin / Super Admin / Someone with permissions to list all projects in all folders in all orgs: https://console.cloud.google.com/home/dashboard?cloudshell=true

 - Use the in-browser option to upload the two shell scripts into your cloud shell
 
 - Ensure the two files are executable
 
 ```chmod u+x get-project-list.sh && chmod u+x get-project-owners.sh```

 - Run get-project-list.sh (and pipe the output to a CSV file) to get the list of projects associated with your Organization ID. If you want to get a list of projects in your whole GCP environment, whether they are associated with your Org ID or not, run the script without the Org ID parameter. Note: The first time, you'll be prompted to Auth.
 
 ``` ./get-project-list.sh 123456789 > list.csv ```
 
 or
 
 ``` ./get-project-list.sh > list.csv ```
 
 - Open the resulting list.csv to see what's in there...is it what you expected? 
 
 - Run the get-project-owners.sh script and pass in the list.csv file to lookup all the owners of those projects.
 
 ``` ./get-project-owners.sh list.csv > project-data.csv```
 
 - Download the project-data.csv file and use it in a Google Data Studio dashboard or use it to email project owners...whatever you need to do :-)
 
 ## AppScript Considerations & Projects without "User" Owners
 
Appscript projects are not associated with your Org ID by default, and do not have users as owners. They have serviceaccounts as owners. So...if you're get-project-list.sh on your full domain, you'll get those projects too....and when you run get-project-owners.sh on it, you'll get less results...because the script ignores owners that are not users.
 
## Big domain? Lot's of projects?

You can optionally run a split command on the list.csv after the first step, so you have a series of smaller CSV's to work with for the next owner lookup step. IE: do something like this:

``` split -dl 500 --additional-suffix=.csv list.csv split_list_```

Which will result in several files named split_list_aa.csv, split_list_ab.csv etc...which can then be passed into the get-owners script:

 ``` ./get-project-owners.sh split_list_aa.csv >> project-data.csv```
 
This is usually only necessary for a massive number of projects, or if you want to check easily for progress along the way rather than waiting for it to end. I figured this out after being booted from my cloud shell for non-activity a few times, even when i thought i was paying attention.

## Attribution & Contact Info

This was based on the work from Indiana University (https://iu.app.box.com/s/d5rmn4dt5kvz9t907n2pky86zjmlbttk).

For questions about this, you can contact nickyoung@uncg.edu or https://twitter.com/techupover
 
