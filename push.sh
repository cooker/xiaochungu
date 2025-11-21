#!/usr/bin/env sh

# 提交当前所有变更

# =========================================== GLOBAL FUNCTIONS ===========================================
echoInfo() { echo "\033[1;36m$@\033[0m"; }      # info  重要，输出信息：用来反馈系统的当前状态给最终用户的；
echoSuccess() { echo "\033[1;32m$@\033[0m"; }   # success 成功，输出信息：用来反馈系统的当前状态给最终用户的；
echoWarn() { echo "\033[1;33m$@\033[0m"; }      # warn, 可修复，系统可继续运行下去；
echoError() { echo "\033[1;31m$@\033[0m"; }     # error, 可修复性，但无法确定系统会正常的工作下去;
echoFatal() { echo "\033[5;31m$@\033[0m"; }     # fatal, 相当严重，可以肯定这种错误已经无法修复，并且如果系统继续运行下去的话后果严重。


# =========================================== MAIN ===========================================
script_file="$(dirname $0)"
notebook_dir="$(dirname $script_file)"
cd "$notebook_dir" && echoInfo "\n根路径：$(pwd)"

echoInfo "\n待提交变更："
git status

echoInfo "\n开始提交变更："
git add .
git commit -m "Update by $(basename "$0") ."
git push

echoSuccess "\n已提交所有变更！"
echoSuccess "\n详见GitHub: https://github.com/AndyM129/Notebook\n"
