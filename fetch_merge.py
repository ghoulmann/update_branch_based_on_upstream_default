import os
import subprocess
import requests
from dotenv import load_dotenv

def run_command(command, check_conflict=False):
    """Executes a shell command and returns the output, checks for merge conflicts if specified."""
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    stdout, stderr = process.communicate()
    if check_conflict and process.returncode != 0:
        conflict_detected = "CONFLICT" in stderr.decode("utf-8")
        if conflict_detected:
            print("Merge conflict detected. Please resolve the conflicts manually.")
            print("After resolving conflicts, use 'git add' for the resolved files, and then 'git commit' to complete the merge.")
            print("Or, for a rebase, after resolving conflicts, use 'git rebase --continue' to proceed.")
            raise Exception("Merge/rebase halted due to conflict.")
        else:
            raise Exception(stderr.decode("utf-8"))
    elif process.returncode != 0:
        raise Exception(stderr.decode("utf-8"))
    return stdout.decode("utf-8").strip()

def confirm_action(prompt):
    """Asks the user for confirmation before proceeding."""
    confirmation = input(f"{prompt} (y/n): ").lower()
    while confirmation not in ['y', 'n']:
        confirmation = input("Please enter 'y' for yes or 'n' for no: ").lower()
    return confirmation == 'y'

def get_user_choice(prompt, options):
    """Asks the user to choose an option."""
    print(prompt)
    for i, option in enumerate(options, 1):
        print(f"{i}. {option}")
    choice = input("Enter your choice: ").strip()
    while not choice.isdigit() or int(choice) < 1 or int(choice) > len(options):
        choice = input("Please enter a valid choice: ").strip()
    return options[int(choice) - 1]

def get_repository_info(remote_url, token, enterprise_url):
    """Retrieves repository information, including checking if it's a fork and the default branch."""
    parts = remote_url.replace(".git", "").split('/')
    repo_owner, repo_name = parts[-2], parts[-1]
    api_url = f"{enterprise_url}/api/v3/repos/{repo_owner}/{repo_name}"
    headers = {'Authorization': f'token {token}'}
    response = requests.get(api_url, headers=headers)
    if response.status_code == 200:
        repo_info = response.json()
        is_fork = repo_info.get('fork', False)
        default_branch = repo_info['default_branch']
        upstream_repo = repo_info['parent']['full_name'] if is_fork else None
        return is_fork, default_branch, upstream_repo
    else:
        raise Exception(f"Failed to get repository information: {response.text}")

def main():
    load_dotenv()
    github_token = os.getenv("GITHUB_TOKEN")
    github_enterprise_url = os.getenv("GITHUB_ENTERPRISE_URL")

    if not github_token or not github_enterprise_url:
        print("Missing GitHub token or GitHub Enterprise URL in .env file.")
        return

    try:
        # Fetch changes from the upstream repository
        upstream_remote = run_command("git remote get-url upstream")
        is_fork, default_branch, upstream_repo = get_repository_info(upstream_remote, github_token, github_enterprise_url)
        if confirm_action(f"Do you want to fetch changes from the '{default_branch}' branch of '{upstream_repo}'?"):
            run_command(f"git fetch upstream {default_branch}")
            print("Fetch completed successfully.")

            # Ask user to merge or rebase
            action = get_user_choice("Do you want to merge or rebase the fetched changes into your active branch?", ["merge", "rebase"])
            if action == "merge":
                if confirm_action("This will merge the fetched changes into your active branch. Continue?"):
                    try:
                        run_command(f"git merge upstream/{default_branch}", check_conflict=True)
                        print("Merge completed successfully.")
                    except Exception as e:
                        print(e)
                        return
            elif action == "rebase":
                if confirm_action("This will rebase your active branch onto the fetched changes. Continue?"):
                    try:
                        run_command(f"git rebase upstream/{default_branch}", check_conflict=True)
                        print("Rebase completed successfully.")
                    except Exception as e:
                        print(e)
                        return
        else:
            print("Operation cancelled by the user.")
    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    main()
