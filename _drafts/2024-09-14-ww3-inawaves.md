---
title: 'Running WW3 InaWaves'
author: wtyo
date: 2024-09-14 07:00:00 +0700 
categories: [Oceanography, Modelling]
tags: [model, ocean]
math: true
---

This article will guide you to run the state of the art ocean wave model developed by Marine Met Center BMKG, especially in an HPC or cluster environment.

# 1. Preparation

1. OFS bundle
2. WW3 executable files
3. Compiler
4. Libraries

## 1.1. OFS bundle

File static dari beberapa grid domain.
- domain
  - global
    - `global.bot`
    - `global.mask`
    - `global.meta`
    - `global.obs`
    - `ww3_grid.inp`
    - `ww3_strt.inp` (optional)
  - reg
    - `reg.bot`
    - `reg.mask`
    - `reg.meta`
    - `reg.obs`
    - `ww3_grid.inp`
    - `ww3_strt.inp` (optional)
  - sreg
    - `sreg.bot`
    - `sreg.mask`
    - `sreg.meta`
    - `sreg.obs`
    - `ww3_grid.inp`
    - `ww3_strt.inp` (optional)
  - hires
    - `hires.bot`
    - `hires.mask`
    - `hires.meta`
    - `hires.obs`
    - `ww3_grid.inp`
    - `ww3_strt.inp` (optional)
  - points (you can ignore this if it's unnecessary)
    - `ww3_grid.inp`
- gfs (wind input)
  - `ww3_grid.inp`
  - `ww3_prep.inp`
- tmp files
  - `gx_out_10d.inp`
  - `ww3_multi_gfs.inp`
- tools
  - `gfs_downloader.py`
  - `grib2ww3.py`
  - `create_grads.com`
  - `ww3_gfs_postproc.sh`
  - `ww3_gfs.sh` (main script)

## 1.2. WW3 executable files
Executable files, directly called in the model processing, through `ww3_gfs.sh` in this case.
  - `ww3_grid`: generate `mod_def.ww3` (model definition) for each domain. Requires `ww3_grid.inp` and static files.
  - `ww3_prep`: generate `wind.ww3` from input data (only wind in this case). Requires `ww3_prep.inp`
  - `ww3_strt`: generate restart files for the first model run (optional). Requires `ww3_prep.inp`
  - `ww3_multi`: main processing for model integration, generate `out_grd.*` and `restart.*` if requested. Requires `ww3_multi.inp`

## 1.3. Compiler

Load your compiler by typing the following command.

```bash
module load compiler
```

If failed, you need to talk to your system administrator. Such command should be returning information about your compiler.

```bash
[myaccount@mdclogin1 ~]$ module load compiler
module load compiler
Loading compiler version 2022.0.2
Loading tbb version 2021.5.1
Loading compiler-rt version 2022.0.2
Loading oclfpga version 2022.0.2
  Load "debugger" to debug DPC++ applications with the gdb-oneapi debugger.
  Load "dpl" for additional DPC++ APIs: https://github.com/oneapi-src/oneDPL

Loading compiler/latest
  Loading requirement: tbb/latest compiler-rt/latest oclfpga/latest
[myaccount@mdclogin1 ~]$
```

## 1.4. Libraries

- `NetCDF`
- `zlib`
- `jasperlib`
- `pnglib`
- `hdf5`
- `MPI` and or `OpenMP`

# 2. Diretory structures

## 2.1. Typical directory structures

The following directory structures is should not be consider as a strick rules. The things that should be in mind are: source code should be placed in `/home` directory, whereas input and output data should be located inside `/scratch` directory.

- `~` (`/home/myaccont/`)
  - `ww3`: containing ww3 source code (including WW3 executable files)
  - `ofs`: containing ofs source code (OFS bundle)
- `/scratch`: place to store input and output data

## 2.2. Project directory

- `ofs`
  - `gfs`
    - ...
  - `global`
    - ...
  - `sreg`
    - ...
  - `reg`
    - ...
  - `hires`
    - ...
  - `points`
    - ...
  - `files.*`

# 3. Running WW3

The following script is the workflow of OFS model, from pre to post processing.

## 3.1. Setting up environment and load modules
```bash
module purge
module load compiler
module load mpi

export PATH=/home/bmkg_4/libraries/bin:$PATH
export LIBRARY_PATH=/home/bmkg_4/libraries/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/bmkg_4/libraries/lib:$LD_LIBRARY_PATH

source $HOME/.bashrc
SCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $SCDIR

# Create DTN and overide input
if [[ $2 == "yes" ]];then
        echo "Fast mode, overide date: $1"
        tstart=$1
        NWDAY=${tstart:0:8}
        CYCLE=${tstart:8:2}
elif ! [ -z "$1" ];then
        echo "Press y to confirm the run date : $1"
        read -n 1 k
        if [[ $k != "y" ]];then
                echo "Aborting"
                exit 1
        fi
        tstart=$1
        NWDAY=${tstart:0:8}
        CYCLE=${tstart:8:2}
else
        NWDAY=`date -u +%Y%m%d`
        CYCLE=`$SCDIR/tools/getcyc`
fi

# Logging Function
log_file="/home/bmkg_4/ofs/logs/w3g_$NWDAY$CYCLE.log"
echo $log_file
rm -f $log_file
function logging() {
        echo "`date "+%Y-%m-%d %H:%M:%S"` : $1" 2&>> $log_file
}

function delmin() {
        tes=$(find $1 | sort | head -n -$1)
        logging "Deletting : rm -rf $tes"
        rm -rf $tes
}
```
## 3.2. WW3 Preprocessing
### 
```bash
logging ""
logging "########################################################################"
logging "#                    Daily GFS Downloader and Dumper                   #"
logging "#                          $NWDAY - cycle $CYCLE                       #"
logging "########################################################################"
logging ""
/scratch/bmkg_4/miniconda3/bin/python -u ${SCDIR}/tools/grib2ww3.py /scratch/bmkg_4/Production_Unit/data/gfs ${SCDIR}/tmp/w3g_gfs.txt archive ${NWDAY}${CYCLE} >> $log_file
# WW3 PREP GFS GLOBAL
rm -rf wind.txt
ln -sf ${SCDIR}/tmp/w3g_gfs.txt wind.txt
# Run ww3_grid => mod_def
# Run ww3_strt => restart file
logging "============= WW3 PREP GFS ============="
./ww3_prep 2&>> $log_file

# WW3 RUN
logging "============= WW3 RUNNING SECTION ============="
STime="$NWDAY $CYCLE"
ETime=`date +"%Y%m%d\ %H%M" -d "$STime + 10Days"`
ETime=`date +"%Y%m%d\ %H%M" -d "$STime + 6Hour"`
ResTime=`date +"%Y%m%d\ %H%M" -d "$STime + 12Hour"`
ResTime=`date +"%Y%m%d\ %H%M" -d "$STime + 6Hour"`
logging "Start time $STime"
logging "End time $ETime"
logging "Restart time $ResTime"

sed '
   /tgl_start/s/tgl_start/'"$STime"'/
   /tgl_end/s/tgl_end/'"$ETime"'/
   /tgl_restart/s/tgl_restart/'"$ResTime"'/
   /tgl_restart/s/tgl_restart/'"$ResTime"'/
' ${SCDIR}/tmp/ww3_multi_gfs.inp > ${SCDIR}/ww3_multi.inp

logging "   Success editing ww3_multi.inp"

sbatch run_multi.sh >> $log_file 2>&1
wait
grep 'ERROR\|error' $log_file > /dev/null 2>&1
tail -n 100 $log_file | grep 'ERROR\|error' > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
        logging "Failed running run_multi_s.sh"
        ermeslog=`tail -n 10 $log_file`
        ermes=$'WW3 GFS ERROR REPORT!\n\nError : Failed running run_multi_s.sh\nBaserun : '${NWDAY}${CYCLE}$'\nLog File :'$logfile$'\nError log:\n\n'$ermeslog
        exit 1
else
      logging "Success running run_multi_s.sh"
fi

# #rm ./global/restart.ww3 ./reg/restart.ww3 ./sreg/restart.ww3 ./hires/restart.ww3
mv restart001.global ./global/restart.ww3
mv restart001.reg ./reg/restart.ww3
mv restart001.sreg ./sreg/restart.ww3
mv restart001.hires ./hires/restart.ww3

# # Prepare Grid Output
logging "============= CREATE GRADS OUTPUT SECTION ============="
sed '
    /tgl_start/s/tgl_start/'"$STime"'/
    ' ${SCDIR}/tmp/gx_outf_10d.inp > gx_outf.inp
logging "Success editing gx_outf.inp"

logging "Run create_grads2.com"
csh create_grads.com >> $log_file 2>&1
tail -n 5 $log_file | grep -e 'ERROR' > /dev/null
if [ "$?" -eq "0" ]; then
        logging "Failed running create_grads.com"
        ermeslog=`tail -n 10 $log_file`
        ermes=$'WW3 GFS ERROR REPORT!\n\nError : Failed running create_grads.com\nBaserun : '${NWDAY}${CYCLE}$'\nLog File :'$logfile$'\nError log:\n\n'$ermeslog
        curl -X POST "https://api.telegram.org/bot662284751:AAHjhOK-2u1x60CZXNAvBWNNjxXlMEZMEo8/sendMessage" -d "chat_id=-437781007&text=$ermes" >> /dev/null
        exit 1
else
      logging "Success running create_grads.com"
fi

# ======================= Convert ke nc dan plot
# Global section
logging "============= PostProcessing ============="
logging "ww3_gfs_postproc.sh $NWDAY $CYCLE global\""
logging "ww3_gfs_postproc.sh $NWDAY $CYCLE reg\""
logging "ww3_gfs_postproc.sh $NWDAY $CYCLE hires\""

logging "============= PostProcessing log for global ============="
sh ww3_gfs_postproc.sh $NWDAY $CYCLE global $hs_mult > preproc_global.log 2>&1 &
logging "============= PostProcessing log for reg ============="
sh ww3_gfs_postproc.sh $NWDAY $CYCLE reg $hs_mult > preproc_reg.log 2>&1 &
logging "============= PostProcessing log for hires ============="
sh ww3_gfs_postproc.sh $NWDAY $CYCLE hires $hs_mult >> $log_file 2>&1
wait
cat preproc_global.log >> $log_file
cat preproc_reg.log >> $log_file

logging "============= Successfully running ww3 GFS ============="
exit 0

```

## 3.1. Pre Processing
## 3.2. Main Processing
## 3.3. Post Processing