# Script
#!/bin/bash

# Replace with the URL of your Git repository
GIT_REPO_URL="https://github.com/FNNDSC/ChRIS-in-a-box.git"

# Replace with the desired directory where the repository will be cloned
CLONE_DIR="/path/to/clone/dir"

# Replace with the name of the shell script to execute
SCRIPT_NAME="minichris.sh"

# Clone the Git repository
git clone "$GIT_REPO_URL" "$CLONE_DIR"

# Navigate to the cloned repository directory
cd "$CLONE_DIR"

# Execute the shell script
./"$SCRIPT_NAME"
