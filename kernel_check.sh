#!/bin/sh

#*********************************************************************************************************
#*   __     __               __     ______                __   __                      _______ _______   *
#*  |  |--.|  |.---.-..----.|  |--.|   __ \.---.-..-----.|  |_|  |--..-----..----.    |       |     __|  *
#*  |  _  ||  ||  _  ||  __||    < |    __/|  _  ||     ||   _|     ||  -__||   _|    |   -   |__     |  *
#*  |_____||__||___._||____||__|__||___|   |___._||__|__||____|__|__||_____||__|      |_______|_______|  *
#* http://www.blackpantheros.eu | http://www.blackpanther.hu - kbarcza[]blackpanther.hu * Charles Barcza *
#*************************************************************************************(c)2002-2018********

KERNEL=$(uname -r)
echo "Kernel  : $KERNEL"

KERNELRPM=$(rpm -qf "/lib/modules/$KERNEL")
echo "KernRPM : $KERNELRPM"

KERNELRPMVER=$(rpm -q --provides $KERNELRPM | grep "kernel =" | grep "-" | awk -F"= " '{print $2}')
echo "KrpmVer : $KERNELRPMVER"

KERNELRPMNAME=$(rpm -q --provides $KERNELRPM | grep "\-${KERNELRPMVER}" | sed "s|\-${KERNELRPMVER}.*||" | head -n 1)
echo "KrpnName: $KERNELRPMNAME"


KERNELDEV=$(readlink /lib/modules/$KERNEL/build1)
if [ -d "$KERNELDEV" ];then
echo "KerDev  : $KERNELDEV"

KERNELDEVRPM=$(rpm -qf "$KERNELDEV")
echo "KDevrRPM: $KERNELDEVRPM"
fi
echo "Request : $KERNELRPMNAME-devel = $KERNELRPMVER"

FULLDEVNAME="$KERNELRPMNAME-devel-$KERNELRPMVER"
echo -n "Check   : $FULLDEVNAME : "

if [ "$(rpm -q "$FULLDEVNAME" >/dev/null || echo error)" != "error" ];then
    echo "Installed"
    else
    echo "Missing : $FULLDEVNAME"
fi

