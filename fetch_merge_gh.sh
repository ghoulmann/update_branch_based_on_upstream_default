#!/bin/bash

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it to proceed."
    exit 1
fi
echo "GitHub CLI (gh) is installed."

# Function to confirm user action with a customizable prompt
confirm() {
    read -r -p "${1} [y/n]: " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Function to check whether there are uncommitted changes
check_uncommitted_changes() {
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo "Warning: You have uncommitted changes in your working directory or index."
        echo "These changes may affect merge or rebase operations."
        echo "Consider stashing or committing your changes before proceeding."
        if ! confirm "Continue with uncommitted changes? This may lead to merge conflicts."; then
            echo "Operation cancelled by the user."
            exit 0
        fi
    fi
}

# Retrieve the current branch once to optimize branch retrieval
current_branch=$(git branch --show-current)

# Check if the current repository is a fork and get the upstream repository details
upstream_repo=$(gh repo view --json parent -q .parent.sshUrl)
if [ -z "$upstream_repo" ]; then
    echo "This repository does not appear to be a fork."
    exit 1
else
    echo "Upstream repository detected: $upstream_repo"
    if ! git remote get-url upstream &> /dev/null; then
        echo "Adding 'upstream' remote pointing to $upstream_repo"
        if ! git remote add upstream "$upstream_repo"; then
            echo "Failed to add 'upstream' remote. Please check your permissions and the repository URL."
            exit 1
        fi
    else
        echo "'upstream' remote already exists."
    fi
fi

# Fetch changes from upstream
if confirm "Fetch changes from the upstream repository? This will update your local copy of the branch."; then
    if ! git fetch upstream; then
        echo "Failed to fetch changes from upstream. Please check your network connection and access rights."
        exit 1
    fi
    echo "Changes fetched successfully."
else
    echo "Fetch operation cancelled."
    exit 0
fi

# Check for uncommitted changes before proceeding with merge or rebase
check_uncommitted_changes

# Merge or Rebase with enhanced user instructions and error handling
if confirm "Merge the fetched changes into '$current_branch'? Choosing 'No' will prompt for rebase."; then
    if git merge upstream/"$current_branch"; then
        echo "Merge completed successfully."
    else
        echo "Merge conflict detected. Resolve conflicts manually, then run 'git merge --continue'."
        echo "To open an editor to resolve conflicts, use 'git mergetool', or manually edit the files."
        exit 1
    fi
elif confirm "Rebase your current branch '$current_branch' onto the fetched changes?"; then
    if git rebase upstream/"$current_branch"; then
        echo "Rebase completed successfully."
    else
        echo "Rebase conflict detected. Resolve conflicts manually, then run 'git rebase --continue'."
        echo "To open an editor to resolve conflicts, use 'git rebase --edit-todo', or manually edit the files."
        exit 1
    fi
else
    echo "Operation cancelled."
    exit 0
fi
