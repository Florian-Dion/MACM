TPs MACM

Fichiers de base pour la conception d'un processeur pipeliné sur la base d'une ISA ARM simplifiée.

compilation : 

ghdl -a combi.vhd mem.vhd reg_bank.vhd etages.vhd test_etage_fe.vhd
ghdl -e test_etage_fe
ghdl -r test_etage_fe --vcd=test.vcd
gtkwave test.vcd
