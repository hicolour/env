{ sudo crontab -l -u root; echo '*/5 * * * *  /home/marek/.dzen/status_checks/status_packages.sh'; } | sudo crontab -u root -
