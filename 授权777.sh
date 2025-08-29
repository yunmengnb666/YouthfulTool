# 检查当前目录是否为一个目录
if [ ! -d "$PWD" ]; then
    echo "错误：当前路径不是一个目录。"
    exit 1
fi

# 遍历当前目录下的所有文件，并添加执行权限和设置权限为777
echo "正在为当前目录中的所有文件添加执行权限…"
for file in "$PWD"/*; do
    if [ -f "$file" ]; then
        chmod 777 "$file"
        chmod +x "$file"
    fi
done
echo "当前目录中所有文件的执行权限已更新……"
