repo_url=https://github.com/Arun1295/git-test.git
date=$(date +'%m/%d/%Y %H:%M:%S')

first_commit()
{
	git init
	git add *
	git commit -m "First commit"
	# git remote add origin $repo_url
    add_repo;
	git tag "D_V0.0"
	git push --force origin master --tags
	git checkout -b Release
	git checkout master
	echo "Uploaded"
	read -rsp $'Repository updated.Press to exit...\n'
}

add_repo()
{
	git remote add origin $repo_url
}

daily_commit()
{
	if [ "$2" = "" ]
	then
		#echo "Please enter the version to be pushed"
		read -p 'Development Version name : ' version_name
		#exit
	else
		version_name=$2
	fi


	if [ "$version_name" = "" ]
	then
		echo "Please enter valid development version to be pushed"
		read -rsp $'Failed to upload.Press to exit...\n'
		exit
	fi


	#echo "#" 
	git init
	git add *
	git commit -m "Update : $version_name on $date"
	git tag $version_name

	if [ $? = 0 ] ; then
		echo "Updating please wait..."
	else
		echo "Fatal : Tag Version $1 already exists"
		read -rsp $'Press to exit...\n'
		exit
	fi
	
	git push origin master --tags
	echo "Updated Succesfully"
	read -rsp $'Press to exit...\n'
}

commit_to_master()
{
	git init
	add_repo;
	git add *
	git commit -m "Commit before release : $version_name on $date"
	git push origin master
}

new_release()
{
	if [ "$2" = "" ]
	then
		#echo "Please enter the version to be pushed"
		read -p 'Release Version name : ' version_name
		#exit
	else
		version_name=$2
	fi


	if [ "$version_name" = "" ]
	then
		echo "Please enter valid development version to be pushed"
		read -rsp $'Failed to upload.Press to exit...\n'
		exit
	fi

	# commit_to_master;

	# git checkout Release
	#echo "#" 
	git init
	git add *
	git commit -m "Update : $version_name on $date"
	git tag $version_name

	if [ $? = 0 ] ; then
		echo "Updating please wait..."
	else
		echo "Fatal : Release Version : $1 already exists"
		read -rsp $'Press to exit...\n'
		exit
	fi
	
	git push origin Release --tags
	echo "Release updated Succesfully"
	#git checkout master
	read -rsp $'Press to exit...\n'
}

list_tags()
{
	git tag
}

change_tag()
{
	if [ "$2" = "" ]
	then
		#echo "Please enter the version to be pushed"
		read -p 'Enter the tag name : ' tag_name
		#exit
	else
		tag_name=$2
	fi

	git checkout $tag_name
}

usage_msg=$'Usage:

git_upload.sh first_commit (or)
git_upload.sh daily_commit <dev-version-num> (or)
git_upload.sh release <rel-version-num> (or)
git_upload.sh list_tags 
'



#echo "Update on $date"

if [ "$1" = "" ] 
then
	echo "$usage_msg"
	read -rsp $'Press to exit...\n'
	exit
fi


if [ "$1" = "first_commit" ]
then
	echo "first_commit"
	
	first_commit;

	read -rsp $'Press to exit...\n'
elif [ "$1" = "daily_commit" ]
then 
	echo "daily_commit"

	daily_commit;

	read -rsp $'Press to exit...\n'

elif [ "$1" = "release" ]
then 
	echo "release"

	new_release;
	
	read -rsp $'Press to exit...\n'

elif [ "$1" = "list_tags" ]
then 
	echo "list_tags"

	list_tags;

	read -rsp $'Press to exit...\n'

# elif [ "$1" = "change_tag" ]
# then 
# 	echo "change_tag"

# 	change_tag;

# 	read -rsp $'Press to exit...\n'

# elif [ "$1" = "master" ]
# then 
# 	echo "master"
# 	git checkout master
# 	read -rsp $'Press to exit...\n'

else
	echo "Invalid option"
	echo "$usage_msg"
	read -rsp $'Press to exit...\n'

fi

