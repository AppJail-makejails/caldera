#!/bin/sh
#
echo " "
echo -e "\e[1;37m Generating admin, blue and red passwords ...\e[0m"
echo " "

sleep 5

adminpass=$(openssl rand -base64 14)
bluepass=$(openssl rand -base64 14)
redpass=$(openssl rand -base64 14)

sed -i "" -e "s|admin: admin|admin: ${adminpass}|g" /usr/local/www/caldera/conf/local.yml
sed -i "" -e "s|blue: admin|blue: ${bluepass}|g" /usr/local/www/caldera/conf/local.yml
sed -i "" -e "s|red: admin|red: ${redpass}|g" /usr/local/www/caldera/conf/local.yml

echo " "
echo -e "\e[1;37m ################################################ \e[0m"
echo -e "\e[1;37m MITRE Caldera admin credential                   \e[0m"
echo -e "\e[1;37m Hostname : https://jail-host-ip:8443             \e[0m"
echo -e "\e[1;37m Username : admin                                 \e[0m"
echo -e "\e[1;37m Password : ${adminpass}                          \e[0m"
echo -e "\e[1;37m ################################################ \e[0m"
echo " "

echo " "
echo -e "\e[1;37m ################################################ \e[0m"
echo -e "\e[1;37m MITRE Caldera blue credential                    \e[0m"
echo -e "\e[1;37m Hostname : https://jail-host-ip:8443             \e[0m"
echo -e "\e[1;37m Username : blue                                  \e[0m"
echo -e "\e[1;37m Password : ${bluepass}                           \e[0m"
echo -e "\e[1;37m ################################################ \e[0m"
echo " "

echo " "
echo -e "\e[1;37m ################################################ \e[0m"
echo -e "\e[1;37m MITRE Caldera red credential                     \e[0m"
echo -e "\e[1;37m Hostname : https://jail-host-ip:8443             \e[0m"
echo -e "\e[1;37m Username : red                                   \e[0m"
echo -e "\e[1;37m Password : ${redpass}                            \e[0m"
echo -e "\e[1;37m ################################################ \e[0m"
echo " "

echo " "
echo -e "\e[1;37m Passwords generated ...\e[0m"
echo " "

sleep 3

echo " "
echo -e "\e[1;37m Generating local.yml KEYS ...\e[0m"
echo " "

sleep 3

randomkey=$(openssl rand -base64 32 | b64encode -r -)

sed -i "" -e "s|%%API_KEY_BLUE%%|${randomkey}|g" /usr/local/www/caldera/conf/local.yml

randomkey=$(openssl rand -base64 32 | b64encode -r -)

sed -i "" -e "s|%%API_KEY_RED%%|${randomkey}|g" /usr/local/www/caldera/conf/local.yml

randomkey=$(openssl rand -base64 32 | b64encode -r -)

sed -i "" -e "s|%%CRYPT_SALT%%|${randomkey}|g" /usr/local/www/caldera/conf/local.yml

randomkey=$(openssl rand -base64 32 | b64encode -r -)

sed -i "" -e "s|%%ENCRYPTION_KEY%%|${randomkey}|g" /usr/local/www/caldera/conf/local.yml

echo " "
echo -e "\e[1;37m local.yml KEYS generated ...\e[0m"
echo " "

echo " "
echo -e "\e[1;37m Patching /usr/local/etc/rc.d/caldera ...\e[0m"
echo " "

sed -i "" -e 's|caldera_user=\"caldera\"|caldera_user=\"caldera\"\ncaldera_env=\"GOCACHE=/tmp/caldera/.cache GOMODCACHE=/tmp/caldera/.vendor\"|g' /usr/local/etc/rc.d/caldera

echo " "
echo -e "\e[1;37m /usr/local/etc/rc.d/caldera file patched ...\e[0m"
echo " "

sleep 3
