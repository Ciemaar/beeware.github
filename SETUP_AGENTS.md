# Setting up Persona-Driven AI Agents

This repository utilizes a swarm of specialized AI code review and optimization agents powered by Google Jules (`google-labs-code/jules-action@v1.0.0`) via GitHub Actions.

Rather than a single monolithic AI reviewer, we compartmentalize cognitive focus across six distinct "personas" styled after Monty Python characters. This approach drastically increases precision and reduces noise by strictly limiting the scope of each agent.

## The Personas

1.  **Centurion (`centurion.yml`)**: Event-driven on `pull_request`. A strict process guardian that checks PRs against explicit project guidelines (`CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `AI_POLICY.md`).
2.  **Bedevere (`bedevere.yml`)**: Scheduled daily. An academic visionary hunting for abstract optimization possibilities, architectural drift, and $O(n^2)$ bottlenecks.
3.  **Inquisition (`inquisition.yml`)**: Event-driven on `pull_request`. A security chaos engineer looking exclusively for vulnerabilities, hardcoded secrets, and injection vectors.
4.  **Tim (`tim.yml`)**: Scheduled daily. A turbo optimizer hunting for performance bottlenecks like missing database indexes, expensive operations, and re-renders.
5.  **Taunter (`taunter.yml`)**: Event-driven on `pull_request`. A passive-aggressive teammate enforcing compliance through playful (but polite) psychological framing.
6.  **Ni (`ni.yml`)**: Event-driven on `pull_request`. A standards checker responsible for ensuring code meets both explicit project rules and implicit community standards (e.g., clean code principles).

*Note: All scheduled workflows include a step that prevents execution if no commits have landed in the main branch within the last 24 hours to save resources.*

## Replication Prompt

To set up an identical swarm of agents in another repository, you can provide the following prompt to any LLM or AI coding assistant (like Claude, Gemini, or Jules):

```markdown
Please set up a persona-driven AI code review system using Google Jules (`google-labs-code/jules-action@v1.0.0`) via GitHub Actions.

Create six separate YAML workflow files in `.github/workflows/`, themed after Monty Python characters, but ensure all prompts include a critical directive to remain polite, helpful, kind, and professional (no actual threats, demands, or unclear pseudo-academic writing).

1. `centurion.yml`: Triggers on `pull_request`. Check against project guidelines, testing requirements, and Definition of Done.
2. `bedevere.yml`: Triggers on daily schedule (`cron: '0 4 * * *'`). Search for algorithmic complexity ($O(n^2)$ to $O(n)$) and structural flaws.
3. `inquisition.yml`: Triggers on `pull_request`. Search exclusively for security vulnerabilities and injection vectors.
4. `tim.yml`: Triggers on daily schedule (`cron: '0 5 * * *'`). Search exclusively for performance bottlenecks (missing indexes, missing caching).
5. `taunter.yml`: Triggers on `pull_request`. Point out code smells, missing tests, or poor logic using playful psychological framing.
6. `ni.yml`: Triggers on `pull_request`. Enforce implicit community standards (clean code, sensible naming).

Requirements for all workflows:
- All must use the `JULES_API_KEY` repository secret.
- All `pull_request` triggers MUST include `actions/checkout@v4` with `fetch-depth: 0` before the `jules-action` step.
- All `schedule` triggers must include a bash script step using `git log` to skip the `jules-action` execution if no commits have landed in the last 24 hours.
- Permissions should be `contents: read`, `pull-requests: write` for reviewers, and `contents: write`, `pull-requests: write` for optimizers.
```
