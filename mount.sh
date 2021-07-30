rclone mount gd: /media/google --allow-other --allow-non-empty --vfs-cache-mode writes &

systemctl restart chfs.service
