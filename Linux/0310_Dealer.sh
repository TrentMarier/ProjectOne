#!/bin/bash
cd /home/sysadmin/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
awk '{print $1, $2, $5, $6}' 0310_Dealer_schedule | grep $1 | grep -i $2 >> Dealers_working_during_losses
