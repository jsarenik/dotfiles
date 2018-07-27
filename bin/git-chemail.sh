#!/bin/sh


git filter-branch --commit-filter '
	OLD=old@old.io
	NEW=new@new.com
	NEW_NAME="New Name"
	if [ "$GIT_AUTHOR_EMAIL" = "$OLD" ];
	then
		GIT_AUTHOR_NAME="$NEW_NAME";
		GIT_AUTHOR_EMAIL="$NEW";
		git commit-tree "$@";
	else
		git commit-tree "$@";
	fi' HEAD
