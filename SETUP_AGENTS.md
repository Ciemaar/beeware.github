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

These four agents run concurrently as parallel jobs within a single workflow, triggered automatically on every `pull_request`.

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
- All must use the `JULES_API_KEY` repository secret.
- All `pull_request` triggers MUST include `actions/checkout@v4` with `fetch-depth: 0` and `persist-credentials: false` before the `jules-action` step.
- Include standard GitHub concurrency cancellation blocks (`cancel-in-progress: true`) on all workflows.
- All `schedule` triggers must include a bash script step using `git log` to skip the `jules-action` execution if no commits have landed in the last 24 hours.
- Permissions should be `contents: read`, `pull-requests: write` for reviewers, and `contents: write`, `pull-requests: write` for optimizers.
```
