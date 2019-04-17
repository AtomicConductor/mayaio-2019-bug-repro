# Maya IO 2019 bug repro

## Overview
This repository demonstrates behavior differences between Maya 2019 and Maya IO 2019 when rendering 
via MtoA (3.2.0.2).When rendering the test scene, Maya IO 2019 appears to crash, but Maya 2019 does not.

The scene consists of:
- a poly sphere 
- an `aiFlat` shader (color driven via `AiImage` .tiff file)
- a poly plane
- an `aiAreaLight`

![Image of Render](rendered_image.png)



## Test Setup

```
git clone https://github.com/AtomicConductor/mayaio-2019-bug-repro.git
cd mayaio-2019-bug-repro
```
Download/acquire the following software packages:

- `Autodesk_Maya_2019_Linux_64bit.tgz`
- `Autodesk_MayaIO_2019_Linux_64bit.run`
- `MtoA-3.2.0.2-linux-2019.run`

Place these three files within the `installers` directory (replacing their corresponding placeholders):
```
installers/Autodesk_Maya_2019_Linux_64bit.tgz
installers/Autodesk_MayaIO_2019_Linux_64bit.run
installers/MtoA-3.2.0.2-linux-2019.run
```
Execute `build_n_run_tests.sh`, and provide your Autodesk license server as an argument, e.g.

```
./build_n_run_tests.sh '42.052.12.200'
```

After the script completes (5-10 mins), the shell output will contain the logs from the successful 
render execution (Maya 2019), as well as the crashed render execution (Maya IO 2019). 

## Details
The `build_n_run_tests.sh` script does the following:
#### Builds 3 Docker images
1. base image (from centos 7.5), including an installation of MtoA 3.2.0.2.
2. Maya 2019 image (layered upon base image)
3. Maya IO 2019 image (layered upon base image) 

#### Runs identical test for Maya 2019 and Maya IO 2019
1. Runs the render test using the **Maya 2019** container 
  
    `Render -s 1 -e 1 -rd /tmp/output -proj /tmp/content /tmp/content/maya2019-mtoa3.2.0.1-basic_01.ma`
    
2. Runs the same test using **Maya IO 2019** container 
  
    `Render -s 1 -e 1 -rd /tmp/output -proj /tmp/content /tmp/content/maya2019-mtoa3.2.0.1-basic_01.ma`

### Note
Each stage of the process can be re/run individually as desired.  See the contents of `build_n_run_tests.sh`.

For example, to re-run the maya io render test, simply call: 

```
tests/mayaio-2019/run_test.sh
```
## Test observations



### Maya 2019
Maya 2019 renders successfully without crashing (despite the noted errors/warnings).

Below is the shell output from the Maya 2019 test render (abbreviated):
```
00:00:00   485MB         |  starting 4 bucket workers of size 64x64 ...
00:00:01   504MB         |     0% done - 64 rays/pixel
00:00:01   505MB         |     5% done - 27 rays/pixel
00:00:02   506MB         |    10% done - 48 rays/pixel
00:00:02   506MB         |    15% done - 56 rays/pixel
00:00:02   507MB         |    20% done - 20 rays/pixel
00:00:03   507MB         |    25% done - 68 rays/pixel
00:00:04   508MB         |    30% done - 40 rays/pixel
00:00:04   508MB         |    35% done - 27 rays/pixel
00:00:04   509MB         |    40% done - 16 rays/pixel
00:00:04   509MB         |    45% done - 53 rays/pixel
00:00:05   510MB         |    50% done - 49 rays/pixel
00:00:05   510MB         |    55% done - 36 rays/pixel
00:00:06   510MB         |    60% done - 33 rays/pixel
00:00:06   511MB         |    65% done - 39 rays/pixel
00:00:07   511MB         |    70% done - 47 rays/pixel
00:00:07   512MB         |    75% done - 36 rays/pixel
00:00:07   512MB         |    80% done - 40 rays/pixel
00:00:08   512MB         |    85% done - 32 rays/pixel
00:00:08   513MB         |    90% done - 29 rays/pixel
00:00:08   513MB         |    95% done - 18 rays/pixel
00:00:09   514MB         |   100% done - 25 rays/pixel
00:00:09   514MB         |  render done in 0:08.090
00:00:09   514MB         |  [driver_exr] writing file `/tmp/output/maya2019-mtoa3.2.0.1-basic_01.0001.exr'
00:00:09   514MB         | render done
```
...
```
00:00:09   514MB         | number of errors, error type:
00:00:09   514MB         |     2:  [maketx] Couldn't convert the texture to TX %s
00:00:09   514MB         | number of warnings, warning type:
00:00:09   514MB         |     2:  [AiMakeTx] %s
00:00:09   514MB         |     1:  rendering with watermarks because of failed authorization:
00:00:09   514MB         | -----------------------------------------------------------------------------------
00:00:09   514MB         |  
00:00:09   514MB         | releasing resources
00:00:09   513MB         | Arnold shutdown
Scene /tmp/content/maya2019-mtoa3.2.0.1-basic_01.ma completed.
```

### Maya IO 2019
Maya IO 2019 results in a hard crash.

Below is the shell output from the Maya IO 2019 test render (abbreviated):

```
00:00:00   445MB         | loading plugins from /opt/solidangle/mtoa/2019/plug-ins/../bin/../plugins ...
00:00:00   445MB         |  synColor_shaders.so: color_manager_syncolor uses Arnold 5.3.0.2
00:00:00   445MB         |  alembic_proc.so: alembic uses Arnold 5.3.0.2
00:00:00   445MB         |  cryptomatte.so: cryptomatte uses Arnold 5.3.0.2
00:00:00   445MB         |  cryptomatte.so: cryptomatte_filter uses Arnold 5.3.0.2
00:00:00   445MB         |  cryptomatte.so: cryptomatte_manifest_driver uses Arnold 5.3.0.2
00:00:00   445MB         | loaded 5 plugins from 3 lib(s) in 0:00.00
*** Error in `/usr/autodesk/mayaIO2019/bin/maya.bin': munmap_chunk(): invalid pointer: 0x00007ffd202e2460 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x7f5d4)[0x7f13020825d4]
/usr/autodesk/mayaIO2019/lib/libAdClmHub.so.1(_ZN9__gnu_cxx13new_allocatorIPNSt8__detail15_Hash_node_baseEE10deallocateEPS3_m+0x2f)[0x7f12fe368f85]
/usr/autodesk/mayaIO2019/lib/libAdClmHub.so.1(_ZNSt10_HashtableISsSt4pairIKSsSsESaIS2_ENSt8__detail10_Select1stESt8equal_toISsESt4hashISsENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb0ELb1EEEE21_M_deallocate_bucketsEPPNS4_15_Hash_node_baseEm+0x59)[0x7f12fe36837b]
/usr/autodesk/mayaIO2019/lib/libAdClmHub.so.1(_ZNSt10_HashtableISsSt4pairIKSsSsESaIS2_ENSt8__detail10_Select1stESt8equal_toISsESt4hashISsENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb0ELb1EEEE13_M_rehash_auxEmSt17integral_constantIbLb1EE+0x19e)[0x7f12fe37215e]
/usr/autodesk/mayaIO2019/lib/libAdClmHub.so.1(_ZNSt10_HashtableISsSt4pairIKSsSsESaIS2_ENSt8__detail10_Select1stESt8equal_toISsESt4hashISsENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb0ELb1EEEE9_M_rehashEmRKm+0x3a)[0x7f12fe371454]
/usr/autodesk/mayaIO2019/lib/libAdClmHub.so.1(_ZNSt10_HashtableISsSt4pairIKSsSsESaIS2_ENSt8__detail10_Select1stESt8equal_toISsESt4hashISsENS4_18_Mod_range_hashingENS4_20_Default_ranged_hashENS4_20_Prime_rehash_policyENS4_17_Hashtable_traitsILb1ELb0ELb1EEEE21_M_insert_unique_nodeEmmPNS4_10_Hash_nodeIS2_Lb1EEE+0x94)[0x7f12fe370306]
/usr/autodesk/mayaIO2019/lib/libAdClmHub.so.1(_ZNSt8__detail9_Map_baseISsSt4pairIKSsSsESaIS3_ENS_10_Select1stESt8equal_toISsESt4hashISsENS_18_Mod_range_hashingENS_20_Default_ranged_hashENS_20_Prime_rehash_policyENS_17_Hashtable_traitsILb1ELb0ELb1EEELb1EEixERS2_+0xc7)[0x7f12fe36e901]
/opt/solidangle/mtoa/2019/plug-ins/../bin/libmtoa_api.so(_ZN14CArnoldSession13ExportTxFilesEv+0x61d)[0x7f12d23f3c8d]
/opt/solidangle/mtoa/2019/plug-ins/../bin/libmtoa_api.so(_ZN14CArnoldSession6ExportEPN8Autodesk4Maya16OpenMaya2019000014MSelectionListE+0x12f0)[0x7f12d23fd620]
/opt/solidangle/mtoa/2019/plug-ins/../bin/libmtoa_api.so(_ZN10CMayaScene6ExportEPN8Autodesk4Maya16OpenMaya2019000014MSelectionListE+0x3d)[0x7f12d2425b1d]
/opt/solidangle/mtoa/2019/plug-ins/mtoa.so(+0xb5a00)[0x7f12d34e5a00]
```
...
```
* loaded modules:
*    0x00007f12b98b7000  libai.so
*    0x00007f13023d0000  libpthread.so.0
*    0x00007f1302003000  libc.so.6
*    0x00007f12fe2f5000  libAdClmHub.so.1
*    0x00007f12d2371000  libmtoa_api.so
*    0x00007f12d3430000  mtoa.so
*    0x00007f12da2a4000  libOpenMaya.so
*    0x00007f1310b33000  libCommandEngine.so
*    0x00007f12fdaa6000  libpython2.7.so.1.0
*    0x00007f130eed9000  libExtensionLayer.so
*    0x0000000000400000  maya.bin

maya encountered a fatal error

Signal: 6 (Unknown Signal)
*
* memory: VM 2003 MB, RSS 448 MB, 1878 page faults
****
Result: /tmp/content/maya2019-mtoa3.2.0.1-basic_01.ma
Fatal Error. Attempting to save in /usr/tmp/.20190417.0215.ma
// Maya exited with status 1

```

### Additional Observations
I was able to prevent crashing in Maya IO 2019 if I refrained from using a texture file in my 
geometry's assigned material, i.e. MtoA would render successfully if the default lambert material was
used.


