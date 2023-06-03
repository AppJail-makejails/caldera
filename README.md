# MITRE Caldera

MITRE Caldera is a cyber security platform designed to easily automate adversary emulation, assist manual red-teams, and automate incident response. It is built on the MITRE ATT&CK™ framework and is an active research project at MITRE.

https://caldera.mitre.org/

![image](https://github.com/AppJail-makejails/caldera/assets/11150989/cc74192f-a5e6-4cf7-bb67-942b9ccb6f40)

# Goals
The principal goal of this Makejail is to help us install, configure and run MITRE Caldera into a FreeBSD jail container.

![image](https://github.com/alonsobsd/caldera-makejail/assets/11150989/2e2a3fc7-58af-4728-8cea-fb314d3f83f6)

![image](https://github.com/alonsobsd/caldera-makejail/assets/11150989/a1471e83-53bf-4fad-9802-b0864a4cc9d4)

## Requirements
Before you can install MITRE Caldera using this template you need some initial configurations

#### Enable Packet filter
We need add somes lines to /etc/rc.conf

```sh
# sysrc pf_enable="YES"
# sysrc pflog_enable="YES"

# cat << "EOF" >> /etc/pf.conf
nat-anchor 'appjail-nat/jail/*'
nat-anchor "appjail-nat/network/*"
rdr-anchor "appjail-rdr/*"
EOF
# service pf reload
# service pf restart
# service pflog restart
```
rdr-anchor section is necessary for use dynamic redirect from jails

### Enable forwarding
```sh
# sysrc gateway_enable="YES"
# sysctl net.inet.ip.forwarding=1
```
#### Create a virtualnet
Create a virtualnet for add MITRE Caldera jail from caldera-makejail. Otherwise you can use your own virtualnet if you created it previously

```sh
# appjail network add caldera-net 10.0.0.0/24
```
it will create a bridge named caldera-net in where Caldera jail epair interfaces will be attached. By default caldera-makejail will use NAT for internet outbound. Do not forget added a pass rule to /etc/pf.conf because caldera-makefile will try to download and install packages and some another resources for configuration of it

```sh
pass out quick on caldera-net inet proto { tcp udp } from 10.0.0.2 to any
```

#### Create a lightweight container system
Create a container named caldera with a private IP address 10.0.0.2. Take on mind IP address must be part of caldera-net network

```sh
# appjail makejail -f gh+alonsobsd/caldera-makejail -j caldera -- --network caldera-net --caldera_ip 10.0.0.2
```
When it is done you will see credentials info for connect to MITRE Caldera via web browser.

```sh
 ################################################ 
 MITRE Caldera admin credential                   
 Hostname : https://jail-host-ip:8443             
 Username : admin                                 
 Password : Z1EtVnltRtirHDOTVY4=                          
 ################################################ 
 
 ################################################ 
 MITRE Caldera blue credential                    
 Hostname : https://jail-host-ip:8443             
 Username : blue                                  
 Password : M0WmJnQOLG3va+b0LM8=                           
 ################################################ 
  
 ################################################ 
 MITRE Caldera red credential                     
 Hostname : https://jail-host-ip:8443             
 Username : red                                   
 Password : 1TPza2NLp0h1scaZ2uA=                            
 ################################################
 ```
Keep them to another secure place

## License
This project is licensed under the BSD-3-Clause license.
