#!/bin/bash

# ==============================================================================
# Git 自动合并与清理脚本 (Merge Feature Branch and Cleanup)
# ==============================================================================
# 用法:
# ./git_merge_and_cleanup.sh [目标分支名]
# 示例:
# 1. 在 feature/new-login 分支上执行: ./git_merge_and_cleanup.sh
#    -> 将 feature/new-login 合并到 main
# 2. 在 feature/new-login 分支上执行: ./git_merge_and_cleanup.sh develop
#    -> 将 feature/new-login 合并到 develop
# ==============================================================================

# 默认目标分支
TARGET_BRANCH="master"

# 检查是否有提供目标分支参数
if [ -n "$1" ]; then
    TARGET_BRANCH="$1"
fi

echo "----------------------------------------------------"
echo "目标分支 (Target Branch): $TARGET_BRANCH"
echo "----------------------------------------------------"

# 1. 检查工作区是否干净
if ! git diff --quiet HEAD; then
    echo "❌ 错误: 工作区不干净。请先提交或暂存所有更改。"
    exit 1
fi

# 2. 获取当前分支名 (作为源分支)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
SOURCE_BRANCH=$CURRENT_BRANCH

if [ "$SOURCE_BRANCH" == "$TARGET_BRANCH" ]; then
    echo "❌ 错误: 不能将分支合并到自身 ($TARGET_BRANCH)。请切换到您要合并的特性分支。"
    exit 1
fi

echo "源分支 (Source Branch): $SOURCE_BRANCH"
echo "开始将 $SOURCE_BRANCH 合并到 $TARGET_BRANCH..."

# 3. 切换到目标分支并拉取最新代码
echo ""
echo "--- 步骤 1/5: 切换到 $TARGET_BRANCH 并拉取最新代码 ---"
if ! git checkout $TARGET_BRANCH; then
    echo "❌ 错误: 无法切换到目标分支 $TARGET_BRANCH。请检查分支名是否存在。"
    exit 1
fi

if ! git pull origin $TARGET_BRANCH; then
    echo "❌ 错误: 拉取 $TARGET_BRANCH 失败。请检查网络或权限。"
    exit 1
fi

# 4. 执行合并
echo ""
echo "--- 步骤 2/5: 执行合并 ($SOURCE_BRANCH -> $TARGET_BRANCH) ---"
# 使用 --no-ff (非快进合并) 以保留完整的合并记录
if ! git merge --no-ff $SOURCE_BRANCH; then
    echo "❌ 致命错误: 合并失败。请手动解决冲突，然后重新执行此脚本或手动完成合并。"
    echo "当前停留在 $TARGET_BRANCH 分支，请解决冲突后执行 'git commit' 和 'git push'。"
    exit 1
fi

# 5. 推送合并结果
echo ""
echo "--- 步骤 3/5: 推送 $TARGET_BRANCH 到远程仓库 ---"
if ! git push origin $TARGET_BRANCH; then
    echo "❌ 错误: 推送 $TARGET_BRANCH 失败。"
    exit 1
fi

echo "✅ 成功: $SOURCE_BRANCH 已成功合并并推送到 $TARGET_BRANCH。"

# 6. 清理：删除本地和远程的源分支
echo ""
echo "--- 步骤 4/5: 删除本地分支 $SOURCE_BRANCH ---"
if ! git branch -d $SOURCE_BRANCH; then
    echo "⚠️ 警告: 无法安全删除本地分支 $SOURCE_BRANCH (可能存在未合并的提交)。请手动检查和删除。"
else
    echo "✅ 成功: 本地分支 $SOURCE_BRANCH 已删除。"
fi

echo ""
echo "--- 步骤 5/5: 删除远程分支 origin/$SOURCE_BRANCH ---"
# -d 标志是删除远程分支的标准方式
if ! git push origin --delete $SOURCE_BRANCH; then
    echo "⚠️ 警告: 远程分支 origin/$SOURCE_BRANCH 删除失败 (可能不存在或权限不足)。"
else
    echo "✅ 成功: 远程分支 origin/$SOURCE_BRANCH 已删除。"
fi

echo ""
echo "----------------------------------------------------"
echo "✨ 合并和清理流程完成! 当前分支为 $TARGET_BRANCH。"
echo "----------------------------------------------------"