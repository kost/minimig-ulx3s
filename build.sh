#!/bin/sh

export ulx3s_url=https://github.com/alpin3/ulx3s/releases/download/v2019.12.30/ulx3s-2019.12.30-linux-x86_64.tar.gz
export ulx3s_dist=/dist/

 yum update -y ; \
 yum install -y python3 zip unzip make git && \
 curl -L $ulx3s_url | tar -xvz -C /opt -f - && \
 ln -sf /opt/ulx3s-* /opt/ulx3s && \
 mkdir -p /mt/scratch/tmp/openfpga/prjtrellis/libtrellis/ && \
 cd /opt/ulx3s/bin && \
 for i in ecp*; do ln -sf `pwd`/$i /mt/scratch/tmp/openfpga/prjtrellis/libtrellis/$i; done && \
 cd $HOME && \
 git clone https://github.com/emard/Minimig_ECS.git && \
 cd Minimig_ECS && \
 ./unzip_clean_generic.sh && \
 cd proj/lattice/ulx3s/universal_make_usbjoy/ && \
 for size in 25 45 85; do make clean; make FPGA_SIZE=${size} ulx3s_${size}f_minimig_usbjoy.bit; make FPGA_SIZE=${size} ulx3s_${size}f_minimig_usbjoy.bit; cp -a project/project_project.bit $ulx3s_dist/ulx3s_${size}f_minimig_usbjoy.bit; done && \
 /opt/ulx3s/bin/ecpunpack --input $ulx3s_dist/ulx3s_25f_minimig_usbjoy.bit --textcfg /tmp/ulx3s_12f_minimig_usbjoy.config --idcode 0x41111043 && \
 /opt/ulx3s/bin/ecppack --input /tmp/ulx3s_12f_minimig_usbjoy.config --bit $ulx3s_dist/ulx3s_12f_minimig_usbjoy.bit --compress --idcode 0x21111043 && \
 make clean && \
 cd ../universal_make_ps2kbd/ && \
 for size in 25 45 85; do make clean; make FPGA_SIZE=${size} ulx3s_${size}f_minimig_ps2kbd.bit; make FPGA_SIZE=${size} ulx3s_${size}f_minimig_ps2kbd.bit; cp -a project/project_project.bit $ulx3s_dist/ulx3s_${size}f_minimig_ps2kbd.bit; done && \
 /opt/ulx3s/bin/ecpunpack --input $ulx3s_dist/ulx3s_25f_minimig_ps2kbd.bit --textcfg /tmp/ulx3s_12f_minimig_ps2kbd.config --idcode 0x41111043 && \
 /opt/ulx3s/bin/ecppack --input /tmp/ulx3s_12f_minimig_ps2kbd.config --bit $ulx3s_dist/ulx3s_12f_minimig_ps2kbd.bit --compress --idcode 0x21111043 && \
 echo "[Success]"
