#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
cd $CI_PRIMARY_REPOSITORY_PATH/ci_scripts || exit 1

# Create the plist content
SECRET_CONTENT= "
import Foundation

enum SupaExt {
    static var url = URL(string: \"$SUPABASE_URL\")!
    static var key = \"$SUPABASE_API_KEY\"
}
"

# Write a JSON File containing all the environment variables and secrets.
echo "${SECRET_CONTENT}" > ../Sportify/Constant/SupaExt.swift

echo "Wrote Secrets.plist file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
