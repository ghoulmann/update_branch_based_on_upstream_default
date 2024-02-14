# Fetch from Upstream Remote README

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

## License

This project is open-sourced under the MIT License. See the LICENSE file for more details.

---

This README provides a comprehensive guide to using and contributing to the scripts in this repository, ensuring users can easily understand their purpose, setup requirements, and how to execute them effectively.
