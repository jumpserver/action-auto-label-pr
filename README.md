# 构建和上传 release assets

这个 action 是用来自动给 repo 的 PR 打标签的，因为 JumpServer 项目的 Release Log 是根据 PR 标签生成的

## 约定条件

根据 PR 标题中的字符来打标签：

fix => fix
feat => 新功能
perf => 优化
refactor => 优化
ci => 无需处理

## Inputs
无

## Example usage

```yaml
on:
  pull_request:
    types:
      - opened
      - edited

name: Auto add PR label

jobs:
  add_pr_labels:
    name: Auto add pull request labels if need
    runs-on: ubuntu-latest
    steps:
      - name: Add labels
        uses: jumpserver/action-auto-label-pr@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```
