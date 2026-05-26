# Setting up Persona-Driven AI Agents

This repository utilizes a swarm of specialized AI code review and optimization agents powered by Google Jules (`google-labs-code/jules-action@v1.0.0`) via GitHub Actions.

Rather than a single monolithic AI reviewer, we compartmentalize cognitive focus across six distinct "personas" styled after Monty Python characters. This approach drastically increases precision and reduces noise by strictly limiting the scope of each agent.

## The Personas

To reduce redundant CI statuses and optimize cloud session orchestration, the agents are divided into scheduled hunters and a combined event-driven fleet.

### The Scheduled Optimizers

These agents run independently on a daily schedule. *Note: They include a step that prevents execution if no commits have landed in the main branch within the last 24 hours to save resources.*

1.  **Bedevere (`bedevere.yml`)**: An academic visionary hunting for abstract optimization possibilities, architectural drift, and $O(n^2)$ bottlenecks.
2.  **Tim (`tim.yml`)**: A turbo optimizer hunting for performance bottlenecks like missing database indexes, expensive operations, and re-renders.

### The Fleet Reviewer (`fleet-review.yml`)

These four agents run within a single workflow, triggered automatically on specific `pull_request` events. To optimize feedback and save cloud sessions, the Centurion acts as a gatekeeper: it runs first, and only if the PR successfully follows the basic project process will the other three agents run in parallel.

3.  **Centurion**: A strict process guardian that checks PRs against explicit project guidelines (`CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `AI_POLICY.md`).
4.  **Inquisition**: A security chaos engineer looking exclusively for vulnerabilities, hardcoded secrets, and injection vectors.
5.  **Taunter**: A passive-aggressive teammate enforcing compliance through playful (but polite) psychological framing.
6.  **Ni**: A standards checker responsible for ensuring code meets both explicit project rules and implicit community standards (e.g., clean code principles).

*Note: All scheduled workflows include a step that prevents execution if no commits have landed in the main branch within the last 24 hours to save resources.*

## Replication Prompt

To set up an identical swarm of agents in another repository, you can provide the following prompt to any LLM or AI coding assistant (like Claude, Gemini, or Jules):

```markdown
Please set up a persona-driven AI code review system using Google Jules (`google-labs-code/jules-action@v1.0.0`) via GitHub Actions.

Create three YAML workflow files in `.github/workflows/` (one for the scheduled tasks, and one fleet action for PRs), themed after Monty Python characters, but ensure all prompts include a critical directive to remain polite, helpful, kind, and professional (no actual threats, demands, or unclear pseudo-academic writing).

1. `fleet-review.yml`: Triggers on `pull_request`. A combined workflow that runs four parallel jobs (Centurion, Inquisition, Taunter, Ni) using the Jules action to audit compliance, security, logic, and standards.
2. `bedevere.yml`: Triggers on daily schedule (`cron: '0 4 * * *'`). Search for algorithmic complexity ($O(n^2)$ to $O(n)$) and structural flaws.
3. `tim.yml`: Triggers on daily schedule (`cron: '0 5 * * *'`). Search exclusively for performance bottlenecks (missing indexes, missing caching).

Requirements for all workflows:
- **Reusable Workflows & Actions**: Extract the API key validation logic into a `.github/workflows/run-agents.yml` workflow, and the 24-hour commit checking logic into a `.github/actions/check-commits/action.yml` composite action.
- **Bot Exclusions & Drafts**: Inside the `run-agents` script, explicitly check if the PR is a draft (`github.event.pull_request.draft`) or if the actor is a bot (`google-labs-jules[bot]`). Output `run_agents=false` if true, allowing downstream jobs to conditionally skip.
- **Checkout Auth**: All `pull_request` triggers MUST use `actions/checkout@v4` with `fetch-depth: 0` and `persist-credentials: false`.
- **Concurrency**: Include standard GitHub concurrency cancellation blocks (`cancel-in-progress: true`) on all workflows.
- **Node.js**: Set `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` at the top level of the workflows to suppress deprecation warnings.
- **PR Output Linking**: Set `include_commit_log: false` in PR workflows to prevent false positives. Inject a directive into all prompts instructing the agents to post their reviews directly to the PR as comments using hidden HTML tags (e.g., `<!-- centurion-comment -->`), and inject the PR number into the prompt for automatic GitHub cross-linking.
- **Permissions**: `contents: read`, `pull-requests: write` for reviewers, and `contents: write`, `pull-requests: write` for optimizers.
```
