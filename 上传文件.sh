import requests
import os
from datetime import datetime

def download_file(url, save_path, custom_file_name):

    full_save_path = os.path.join(save_path, custom_file_name)
    os.makedirs(save_path, exist_ok=True)

    response = requests.get(url, stream=True)
    if response.status_code != 200:
        print(f"下载失败，状态码：{response.status_code}，URL: {url}")
        return

    total_size = int(response.headers.get("content-length", 0))
    chunk_size = 1024
    downloaded_size = 0

    with open(full_save_path, "wb") as file:
        for chunk in response.iter_content(chunk_size=chunk_size):
            if chunk:
                file.write(chunk)
                downloaded_size += len(chunk)
                progress = (downloaded_size / total_size) * 100
                print(f"\r下载进度: [{'#' * int(progress / 10)}{'-' * (10 - int(progress / 10))}] {progress:.2f}% ({custom_file_name})", end="")

    print(f"\n文件下载完成！文件已保存到：{full_save_path}")

    if os.path.getsize(full_save_path) != total_size:
        print(f"警告：文件 {custom_file_name} 下载不完整，文件大小不匹配")
    else:
        print(f"文件 {custom_file_name} 下载完整")
        return full_save_path


if __name__ == "__main__":
    url = "http://wpan.cdndns.site/down/de64a582b617837a3fe7583f9f4de347" 
    save_path = "/storage/emulated/0/YouthfulTool制作区/最新美化原版pak下载存放区/"
    today = datetime.now().strftime("%m月%d日")
    custom_file_name = f"{today}最新美化原版pak.zip"


    download_file(url, save_path, custom_file_name)
