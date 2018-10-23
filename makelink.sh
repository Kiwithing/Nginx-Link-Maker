#!/bin/bash
#Create new folders for projects and add an Nginx server block to run the new static and php sites.

#TODO: Make find and replace for domain when copying the boilerplate config using $baseurl

#Set server folders; defaults based on basic installation on Ubuntu / Debian
baseurl='example.com'
htdocs='/var/www/html/'
defaultsbfile='/etc/nginx/sites-available/new-server-block'

#Get project name
echo "$(tput setaf 5)Project Name (lower case, no spaces):$(tput sgr0)"
read -r projectname

#Check if exact project already exists in subdirectory or nginx
if [ -d "$htdocs$projectname" ]; then

    #Let user know that this project already exists
    echo "$(tput setaf 3)$projectname$(tput sgr0) already exists. Please check the html directory or choose another project name."
    exit 1
else
    #Create a new project

    #Create folders
    mkdir -p "$htdocs$projectname/frontend" "$htdocs$projectname/dev"
    chmod -R 775 "$htdocs$projectname"
    chown -R www-data:www-data "$htdocs$projectname"

    #Create nginx server block entries
    #Assumes a default nginx setup on Ubuntu / Debian
    if [ -f "$defaultsbfile" ]; then

        #Where this new config will live
        availconfig="/etc/nginx/sites-available/$projectname"

        cp "$defaultsbfile" "$availconfig"

      #Change variables within file using grep
        sed -i "s/currentproject/$projectname/g" "$availconfig"

        #Create the symlinks
        if [ -h "$availconfig" ]; then

            #Let user know that config file already exists
            echo "$(tput setaf 3)$availconfig$(tput sgr0) already exists. Please remove or review sites-available and sites-enabled folders."
            exit 1
        else
            ln -s "$availconfig" /etc/nginx/sites-enabled/
        fi

    else

        #If this file does not exist, then exit
        echo "$defaultsbfile does not exist."
        exit 1;

    fi 

    echo "Project successfully created in $(tput setaf 3)$htdocs$projectname$(tput sgr0)\n"
    echo "http://frontend.$projectname.example.com\n"
    echo "http://dev.$projectname.example.com\n"
    echo "Run $(tput setaf 2)certbot --nginx$(tput sgr0) to create an SSL certificate for your new project."
    

fi