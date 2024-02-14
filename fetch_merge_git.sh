#!/usr/bin/env bash

# Function to ask for confirmation
confirm() {
    read -r -p "${1:-Are you sure?} [y/n]: " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Check for an upstream remote and add it if necessary
if ! git remote get-url upstream &> /dev/null; then
    echo "Upstream remote not found."
    if confirm "Do you want to add an upstream remote? This will require the owner/repo format (e.g., openai/gpt-3)"; then
        read -r -p "Enter the upstream repository (owner/repo): " upstream_repo
        gh repo fork --remote=true --upstream="$upstream_repo" || { echo "Failed to add upstream remote."; exit 1; }
        echo "Upstream remote added successfully."
    else
        echo "Operation cancelled."
        exit 0
    fi
fi

# Fetch changes from upstream
if confirm "Do you want to fetch changes from the upstream repository?"; then
    git fetch upstream || { echo "Failed to fetch changes from upstream."; exit 1; }
    echo "Changes fetched successfully."
else
    echo "Operation cancelled."
    exit 0
fi

# Ask the user to merge or rebase
echo "You can now merge or rebase the fetched changes into your current branch."
if confirm "Do you want to merge the changes? If you choose 'No', you will be asked about rebasing."; then
    read -r -p "Enter the branch name to merge from upstream: " branch
    git merge upstream/"$branch" || {
        echo "Merge conflict detected or merge failed. Please resolve any conflicts manually."
        exit 1
    }
    echo "Merge completed successfully."
elif confirm "Do you want to rebase onto the fetched changes?"; then
    read -r -p "Enter the branch name to rebase onto from upstream: " branch
    git rebase upstream/"$branch" || {
        echo "Rebase conflict detected or rebase failed. Please resolve any conflicts manually."
        exit 1
    }
    echo "Rebase completed successfully."
else
    echo "Operation cancelled."
    exit 0
fi
