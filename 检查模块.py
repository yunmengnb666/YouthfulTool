import subprocess
import sys
import importlib
import importlib.metadata

def check_and_install_module(module_name):
    try:

        importlib.metadata.version(module_name)
        return True
    except importlib.metadata.PackageNotFoundError:

        return False

def main():

    modules_to_install = []
    if not check_and_install_module("requests"):
        modules_to_install.append("requests")
    if not check_and_install_module("colorama"):
        modules_to_install.append("colorama")


    if modules_to_install:
        print("检测到你是第一次使用工具，正在安装模块...")
        for module in modules_to_install:
            subprocess.check_call([sys.executable, "-m", "pip", "install", module])
            print(f"{module} 安装完成！")


if __name__ == "__main__":
    main()
