# A Guide to GitHub Workflows for Developers

GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline. You can create workflows that build and test every pull request to your repository, or deploy merged pull requests to production.

This guide provides an overview of GitHub Workflows to help developers unfamiliar with them get started.

## What is a Workflow?

A **workflow** is a configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked into your repository and will run when triggered by an event in your repository, or they can be triggered manually, or at a defined schedule.

Workflows are defined in the `.github/workflows` directory in a repository, and a repository can have multiple workflows, each of which can perform a different set of tasks.

## Key Concepts

### 1. Events

An **event** is a specific activity in a repository that triggers a workflow run. For example, activity can originate from GitHub when someone creates a pull request, opens an issue, or pushes a commit to a repository.

Examples of common events:
- `push`: Triggers when someone pushes to a specific branch.
- `pull_request`: Triggers on pull request activity (e.g., opened, synchronized, reopened).
- `schedule`: Triggers at specific times (like a cron job).
- `workflow_dispatch`: Allows a workflow to be triggered manually.

### 2. Jobs

A **job** is a set of steps in a workflow that execute on the same runner. Each step is either a shell script that will be executed, or an action that will be run. Steps are executed in order and are dependent on each other. Since each step is executed on the same runner, you can share data from one step to another. For example, you can have a step that builds your application followed by a step that tests the application that was built.

By default, jobs in a workflow run in parallel. You can also configure jobs to run sequentially by defining dependencies between them.

### 3. Runners

A **runner** is a server that runs your workflows when they're triggered. Each runner can run a single job at a time. GitHub provides Ubuntu Linux, Microsoft Windows, and macOS runners to run your workflows. You can also host your own runners if you need a specific operating system or hardware configuration.

Common runner: `ubuntu-latest`.

### 4. Steps

A **step** is an individual task that can run commands in a job. A step can be either an action or a shell command. Each step in a job executes on the same runner, allowing the actions in that job to share data with each other.

### 5. Actions

An **action** is a custom application for the GitHub Actions platform that performs a complex but frequently repeated task. Use an action to help reduce the amount of repetitive code that you write in your workflow files. An action can pull your git repository from GitHub, set up the correct toolchain for your build environment, or set up the authentication to your cloud provider.

## Example Workflow: PR Checklist

Let's look at an example workflow that checks if a Pull Request description includes a required checklist. This example is very similar to the one we just added to our repository!

```yaml
name: PR Checklist # The name of the workflow as it will appear in the GitHub UI

on:
  pull_request: # This workflow triggers on pull request events
    types: [opened, edited, reopened, synchronize]

jobs:
  check-pr-template: # The name of the job
    runs-on: ubuntu-latest # The runner environment

    steps:
      - name: Check PR body # A step to run our script
        env:
          PR_BODY: ${{ github.event.pull_request.body }} # We pass data from the GitHub event into an environment variable
        run: |
          # Write the PR body to a file securely from the environment variable
          printf '%s\n' "$PR_BODY" > pr_body.txt

          # Check if the checklist header exists
          if ! grep -q "## PR Checklist:" pr_body.txt; then
              echo "::error::PR checklist absent. We require PRs to use our template, your PR will be ignored until/unless you change to the standard template...."
              exit 1
          fi

          # ... more validation logic ...

          echo "PR Checklist verification passed."
          exit 0
```

## How to Read This Workflow

1. **`name: PR Checklist`**: This is the title of the workflow. It will show up in the "Actions" tab of the repository and on Pull Request checks.
2. **`on: pull_request`**: This tells GitHub to run this workflow whenever there is a pull request. The `types` array specifies that it should run when a PR is opened, when its body is edited, reopened, or synchronized (when new commits are pushed).
3. **`jobs: check-pr-template`**: Defines a job named `check-pr-template`.
4. **`runs-on: ubuntu-latest`**: Tells GitHub to spin up a fresh virtual machine running the latest version of Ubuntu Linux.
5. **`steps`**: This is where the actual work happens.
6. **`env: PR_BODY: ${{ github.event.pull_request.body }}`**: GitHub Actions provides a context object called `github` that contains information about the event that triggered the workflow. Here, we're taking the body (description) of the pull request and putting it into an environment variable called `PR_BODY`.
7. **`run:`**: This allows us to execute shell commands directly on the runner. We use a bash script to write the environment variable to a file and then use `grep` to check for specific text.
8. **`echo "::error::..."`**: This is a special workflow command that tells GitHub Actions to create an error annotation. This will show up prominently in the GitHub UI.
9. **`exit 1`**: Exiting with a non-zero status code tells GitHub Actions that the step failed, which will cause the entire job to fail and the PR check to be marked as red (failed). Exiting with `0` means success.

## Environment Variables and Contexts

GitHub Actions provides several contexts that contain information about the workflow run, runner environments, jobs, and steps.

- **`${{ github }}`**: Information about the webhook payload and the repository.
- **`${{ env }}`**: Environment variables set in the workflow.
- **`${{ secrets }}`**: Access to repository secrets (e.g., API keys, passwords) securely.

You can use expression syntax (`${{ <expression> }}`) to access these contexts and pass data to your jobs and steps.

## Conclusion

This guide covers the basics of GitHub Workflows. The best way to learn is by looking at existing workflows in your repositories and trying to build your own. You can automate almost anything related to your repository lifecycle!

For more detailed information, consult the official [GitHub Actions Documentation](https://docs.github.com/en/actions).
