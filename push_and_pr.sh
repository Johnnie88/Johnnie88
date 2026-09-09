#!/usr/bin/env bash
set -e

# ==============================================================================
# Script Name: push_and_pr.sh
# Description: Verifies GitHub authentication, pushes the developer branch,
#              and opens a Pull Request on GitHub with best practices.
# Author:      Alien Build Tech / Johnnie88
# ==============================================================================

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "=== 1. Validating repository integrity ==="
python3 tests/smoke.py

echo ""
echo "=== 2. Checking GitHub authentication ==="
if ! gh auth status >/dev/null 2>&1; then
    echo "You are not logged into GitHub CLI."
    echo "Running 'gh auth login' to authenticate with your GitHub account..."
    gh auth login
fi

echo ""
echo "=== 3. Pushing branch 'developer' to origin ==="
git push -u origin developer

echo ""
echo "=== 4. Creating Pull Request ==="
PR_TITLE="feat: complete profile overhaul with Alien Build Tech projects & Cloud/DevOps architecture"
PR_BODY="## Description
Complete redesign of the GitHub profile repository to feature real projects from Alien Build Tech and Johnnie88.

## Key Changes
- **Profile Documentation (\`README.md\`)**: Updated bio, headline, skills, live telemetry cards, and featured repositories (\`AZDOPS\`, \`argocd-clickhouse\`, \`AzOps-Accelerator\`, \`alien-build-tui\`, \`azurechatgpt\`, \`azure-pipeline-templates\`, \`Repo-Analysis-Tool\`).
- **Interactive SVG Graphics (\`assets/\`)**: Replaced placeholder visuals with animated Kubernetes cluster mesh, CI/CD pipeline stream, cloud status cards, and P99 latency telemetry.
- **Reference Examples (\`examples/\`)**: Added \`argocd_clickhouse_app.yaml\` (ArgoCD GitOps application manifest) and \`azdops_example.ps1\` (Azure DevOps automation).
- **CI / Best Practices (\`.github/\`)**: Added GitHub Actions validation workflow (\`validate.yml\`), PR template (\`PULL_REQUEST_TEMPLATE.md\`), pre-commit hook (\`.githooks/pre-commit\`), and MIT License.
- **Automated Test Suite (\`tests/smoke.py\`)**: Comprehensive assertion suite checking repository integrity, XML syntax, and keyword presence.

## Verification
- \`python3 tests/smoke.py\` executed and passed all tests.
- SVG assets validated with ElementTree XML parser."

gh pr create --title "$PR_TITLE" --body "$PR_BODY" --head developer

echo ""
echo "Pull Request successfully created!"
