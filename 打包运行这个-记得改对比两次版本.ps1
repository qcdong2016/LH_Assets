# 目标文件夹
$TARGET_DIR = "exported_files"
New-Item -ItemType Directory -Path $TARGET_DIR -Force

# 获取差异文件列表
$commit1 = "834113017d2f8f738199b997c9262cd4cdfc43da"
$commit2 = "0e13707e4dc4373b199bafc2bc920dd2233e5fb0"
$fileListPath = "file_list.txt"

# 使用 git diff --name-only 生成文件列表
git diff --name-only $commit1 $commit2 > $fileListPath

# 读取文件列表
Get-Content $fileListPath | ForEach-Object {
    $file = $_
    # 创建目标文件夹路径
    $targetPath = Join-Path $TARGET_DIR (Split-Path $file -Parent)
    New-Item -ItemType Directory -Path $targetPath -Force

    # 源文件路径
    $sourcePath = $file

    # 目标文件路径
    $destinationPath = Join-Path $targetPath (Split-Path $file -Leaf)

    # 复制文件
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force
}

# 删除临时文件列表
Remove-Item $fileListPath