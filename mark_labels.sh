#!/bin/bash -eix

PR_TITLE=$(jq -r .pull_request.title < "${GITHUB_EVENT_PATH}")
PR_ISSUE_URL=$(jq -r .pull_request.issue_url < "${GITHUB_EVENT_PATH}")

echo "${PR_TITLE}"
echo "${PR_ISSUE_URL}"

label=""

if [[ "${PR_TITLE}" =~ "fix" ]];then
  label="fix"
elif [[ "${PR_TITLE}" =~ "feat" ]];then
  label="新功能"
elif [[ "${PR_TITLE}" =~ "perf" || ${PR_TITLE} =~ "refactor" ]];then
  label="优化"
elif [[ "${PR_TITLE}" =~ "ci" ]];then
  label="无需处理"
fi
if [[ -z "${label}" ]];then
  exit 0
fi

data='{"labels":["'"${label}"'"]}'

curl \
      --fail \
      -X PATCH \
      --data ${data} \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      "${PR_ISSUE_URL}"