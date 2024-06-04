#!/bin/bash
#       _                                 
#   ___| | ___  __ _ _ __    _   _ _ __   
#  / __| |/ _ \/ _` | '_ \  | | | | '_ \  
# | (__| |  __/ (_| | | | | | |_| | |_) | 
#  \___|_|\___|\__,_|_| |_|  \__,_| .__/  
#                                 |_|     
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

paru -Scc
sudo su -c 'pacman -Qtdq | pacman -Rns -'
sudo su -c 'pacman -Qqd | pacman -Rsu -'

