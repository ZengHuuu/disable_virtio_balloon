#!/bin/bash

# 步骤1：检查 virtio_balloon 模块是否已加载
if lsmod | grep -q virtio_balloon; then
  echo "virtio_balloon 模块已加载。继续执行下面的步骤。"
else
  echo "virtio_balloon 模块尚未加载。退出脚本。"
  exit 1
fi

# 步骤2：如果已加载 virtio_balloon 模块，则卸载它
if lsmod | grep -q virtio_balloon; then
  rmmod virtio_balloon
  echo "virtio_balloon 模块已卸载。"
fi

# 步骤3：打开 /etc/modprobe.d/ 目录
cd /etc/modprobe.d/

# 步骤4：创建一个新的配置文件
echo "正在创建新的配置文件..."
echo "blacklist virtio_balloon" > blacklist-virtio-balloon.conf
echo "配置文件已创建。"

# 步骤5：保存并关闭文件
echo "正在配置模块黑名单..."
echo "blacklist virtio_balloon" > /etc/modprobe.d/blacklist-virtio-balloon.conf
echo "模块黑名单已配置。"

# 步骤6：更新 initramfs
echo "正在更新 initramfs..."
update-initramfs -u
echo "initramfs 已更新。"

echo "已经禁止 virtio_balloon 模块开机启动。"
