#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depends on this origin.
cd $CI_PRIMARY_REPOSITORY_PATH/ci_scripts || exit 1

# Create the plist content
SECRET_CONTENT=$(cat <<EOF
import Foundation

enum SupaExt {
    static var url = URL(string: "$SUPABASE_URL")!
    static var key = "$SUPABASE_API_KEY"
}
EOF
)

# Write a Swift file containing the secret content.
echo "$SECRET_CONTENT" > ../Sportify/Constant/SupaExt.swift

echo "Wrote SupaExt.swift file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0

