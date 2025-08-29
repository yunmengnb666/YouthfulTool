#!/bin/bash

# 更新Termux的包列表
pkg update

# 检查并安装Python和pip
if ! command -v python &> /dev/null; then
    echo "Python未安装，正在安装..."
    pkg install python -y
fi

if ! command -v pip &> /dev/null; then
    echo "pip未安装，正在安装..."
    pkg install python-pip -y
fi

# 定义需要安装的包列表
packages=(
    python
    python-pip
    libandroid-shmem
    wget
    openssl
    ca-certificates
)

# 检查并安装包
for package in "${packages[@]}"; do
    if ! pkg list-installed | grep -q "^$package$"; then
        echo "$package 未安装，正在安装..."
        pkg install "$package" -y
        if [ $? -eq 0 ]; then
            echo "$package 安装成功"
        else
            echo "$package 安装失败，请检查网络或权限"
        fi
    else
        echo "$package 已安装"
    fi
done

# 定义需要安装的pip包列表
pip_packages=(
    colorama
    requests
)

# 检查并安装pip包
for pip_package in "${pip_packages[@]}"; do
    if ! pip show "$pip_package" &> /dev/null; then
        echo "$pip_package 未安装，正在安装..."
        pip install "$pip_package"
        if [ $? -eq 0 ]; then
            echo "$pip_package 安装成功"
        else
            echo "$pip_package 安装失败，请检查网络或权限"
        fi
    else
        echo "$pip_package 已安装"
    fi
done

echo "所有安装完毕 可以输入下一条代码了"
