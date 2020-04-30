mkdir -p ./backup/nagiosql/
mkdir -p ./backup/nagios/etc/
mkdir -p ./backup/nagios/libexec/
cp -r /usr/local/nagiosql/* ./backup/nagiosql/
cp -r /usr/local/nagios/etc/* ./backup/nagios/etc/
cp -r /usr/local/nagios/libexec/* ./backup/nagios/libexec/
tar czf /home/pi/$(date +%Y%m%d).tar.gz backup
rm -rf ./backup/
echo backup done. use \"scp pi@naging:~/$(date +%Y%m%d).tar.gz .\"  to download

