# Fetch from Upstream Remote README <!-- omit in toc -->

This repository contains a collection of scripts designed to streamline the process of fetching changes from an upstream repository and integrating these changes into your local repository through either merging or rebasing. The scripts cater to different environments and preferences: Bash scripts for command-line enthusiasts and a Python script for those who prefer a high-level scripting approach.

These have not been tested.

## Scripts Overview

1. **fetch_merge_gh.sh**: A Bash script that utilizes the GitHub CLI (`gh`) to manage upstream repositories and handle fetching, merging, or rebasing operations. It's designed for users who work closely with GitHub and prefer to leverage `gh` for repository operations.

2. **fetch_merge_git.sh**: A Bash script that relies on traditional `git` commands to add upstream remotes, fetch changes, and offer users the choice to merge or rebase these changes into their current branch. This script is suitable for users who prefer direct `git` operations without the use of GitHub-specific tools.

3. **fetch_merge.py**: A Python script that provides a more interactive experience for fetching, merging, or rebasing changes from an upstream repository. It uses `git` commands executed through Python's `subprocess` module and interacts with the GitHub API for repository information. This script is ideal for users who prefer a scripted approach with detailed prompts and error handling.

## Prerequisites

- **Git**: All scripts require Git to be installed and accessible from your command line or terminal.
- **GitHub CLI**: The `fetch_merge_gh.sh` script requires the GitHub CLI (`gh`) to be installed.
- **Python**: The `fetch_merge.py` script requires Python to be installed, along with the `requests` library for API calls.

## Installation

1. **Git**: Download and install Git from [git-scm.com](https://git-scm.com/).
2. **GitHub CLI**: Install `gh` following the instructions on [GitHub's official site](https://cli.github.com/).
3. **Python**: Download and install Python from [python.org](https://www.python.org/). Install the `requests` library using pip:

```bash
pip install requests
```

## Usage

### Bash Scripts

1. **fetch_merge_gh.sh** and **fetch_merge_git.sh**:
   - Make the script executable:

   ```bash
   chmod +x script_name.sh
   ```

   - Run the script from your repository's root directory:

   ```bash
   ./script_name.sh
   ```

### Python Script

1. **fetch_merge.py**:
   - Check the imports and install requirements
   - Run the script from your repository's root directory:

   ```bash
   python fetch_merge.py
   ```

## Features

- **Customizable Confirmation Prompts**: Each script includes confirmation prompts to ensure that you're in control of the fetching, merging, and rebasing operations.
- **Uncommitted Changes Check**: Before proceeding with merge or rebase operations, the scripts check for uncommitted changes in your working directory, offering you the option to continue or cancel the operation.
- **Error Handling**: The Python script includes detailed error handling, providing clear messages and instructions in case of merge conflicts or API communication issues.

## Contributing

Contributions to improve the scripts or add new functionalities are welcome. Please feel free to fork the repository, make your changes, and submit a pull request.

## Prospective Benefits of Each

# Repository Scripts README

This repository contains a collection of scripts designed to streamline the process of fetching changes from an upstream repository and integrating these changes into your local repository through either merging or rebasing. The scripts cater to different environments and preferences: Bash scripts for command-line enthusiasts and a Python script for those who prefer a high-level scripting approach.

## Scripts Overview

1. **fetch_merge_gh.sh**: A Bash script that utilizes the GitHub CLI (`gh`) to manage upstream repositories and handle fetching, merging, or rebasing operations. It's designed for users who work closely with GitHub and prefer to leverage `gh` for repository operations.

2. **fetch_merge_git.sh**: A Bash script that relies on traditional `git` commands to add upstream remotes, fetch changes, and offer users the choice to merge or rebase these changes into their current branch. This script is suitable for users who prefer direct `git` operations without the use of GitHub-specific tools.

3. **fetch_merge.py**: A Python script that provides a more interactive experience for fetching, merging, or rebasing changes from an upstream repository. It uses `git` commands executed through Python's `subprocess` module and interacts with the GitHub API for repository information. This script is ideal for users who prefer a scripted approach with detailed prompts and error handling.

## Prerequisites

- **Git**: All scripts require Git to be installed and accessible from your command line or terminal.
- **GitHub CLI**: The `fetch_merge_gh.sh` script requires the GitHub CLI (`gh`) to be installed.
- **Python**: The `fetch_merge.py` script requires Python to be installed, along with the `requests` library for API calls.

## Installation

1. **Git**: Download and install Git from [git-scm.com](https://git-scm.com/).
2. **GitHub CLI**: Install `gh` following the instructions on [GitHub's official site](https://cli.github.com/).
3. **Python**: Download and install Python from [python.org](https://www.python.org/). Install the `requests` library using pip:

```bash
pip install requests
```

## Usage

### Bash Scripts

1. **fetch_merge_gh.sh** and **fetch_merge_git.sh**:
   - Make the script executable:

   ```bash
   chmod +x script_name.sh
   ```

   - Run the script from your repository's root directory:

   ```bash
   ./script_name.sh
   ```

### Python Script

1. **fetch_merge.py**:
   - Run the script from your repository's root directory:

   ```bash
   python fetch_merge.py
   ```

## Features

- **Customizable Confirmation Prompts**: Each script includes confirmation prompts to ensure that you're in control of the fetching, merging, and rebasing operations.
- **Uncommitted Changes Check**: Before proceeding with merge or rebase operations, the scripts check for uncommitted changes in your working directory, offering you the option to continue or cancel the operation.
- **Error Handling**: The Python script includes detailed error handling, providing clear messages and instructions in case of merge conflicts or API communication issues.

Evaluating the three scripts based on the criteria provided involves considering the user interface, complexity and depth of logic, and potential success in achieving their intended functionality. Here's an analysis based on these aspects:

### 1. Best User Experience

- **Python Script (`fetch_merge.py`)**: The Python script likely provides the best user experience among the three. Python's ability to handle complex logic and exceptions, combined with interactive prompts and detailed error messages, offers a more guided and informative experience. The script includes functions for confirming actions, choosing between merging and rebasing, and detailed instructions for resolving conflicts, which can be more user-friendly, especially for those less familiar with command-line operations.

### 2. Richest Logic

- **Python Script (`fetch_merge.py`)**: This script also has the richest logic. It not only performs the basic operations of fetching, merging, and rebasing but also interacts with the GitHub API to retrieve repository information. It includes error handling that provides feedback on merge conflicts and API errors, and it offers users choices with clear instructions on how to proceed in various scenarios. The use of functions like `run_command`, `confirm_action`, and `get_user_choice` adds layers of logic that enhance the script's functionality and robustness.


### Conclusion

- **Best User Experience**: Python script (`fetch_merge.py`)
- **Richest Logic**: Python script (`fetch_merge.py`)
- **Most Successful**: The Bash scripts (`fetch_merge_gh.sh` and `fetch_merge_git.sh`) are likely to be more immediately successful in environments already set up for Git and GitHub CLI use, due to their straightforward nature and direct use of command-line tools. The Python script, while potentially more powerful and user-friendly, requires a Python environment, which might not be as universally available or preferred in all settings.

## Contributing

Contributions to improve the scripts or add new functionalities are welcome. Please feel free to fork the repository, make your changes, and submit a pull request.

## License

This project is open-sourced under the MIT License. See the LICENSE file for more details.
