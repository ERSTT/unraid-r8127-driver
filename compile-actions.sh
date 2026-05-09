# Get current uname
if [ -z "${UNAME}" ]; then
  UNAME=$(uname -r)
fi
# Clone repository and get latest commit
cd ${DATA_DIR}
PLUGIN_VERSION="$(git log -1 --format="%cs" | sed 's/-//g')"
git checkout main

# Compile r8127 Kernel Module and install it to the temporary directory "/RTL8127"
cd ${DATA_DIR}/r8127/src

# Hardcode the kernel version in Makefile to override dynamic detection
sed -i "s/\$(shell uname -r)/${UNAME}/g" Makefile

# Compile Kernel Module and move it to a temporary directory
make -j${CPU_COUNT}
make INSTALL_MOD_PATH=/RTL8127 install -j${CPU_COUNT}

# Remove non Kernel modules from temporary directory
rm /RTL8127/lib/modules/${UNAME}/* 2>/dev/null

# Create Slackware package
PLUGIN_NAME="r8127"
BASE_DIR="/RTL8127"
TMP_DIR="/tmp/${PLUGIN_NAME}_"$(echo $RANDOM)""
VERSION="$(date +'%Y.%m.%d')"

mkdir -p $TMP_DIR/$VERSION
cd $TMP_DIR/$VERSION
cp -R $BASE_DIR/* $TMP_DIR/$VERSION/
mkdir $TMP_DIR/$VERSION/install
tee $TMP_DIR/$VERSION/install/slack-desc <<EOF
       |-----handy-ruler------------------------------------------------------|
$PLUGIN_NAME: $PLUGIN_NAME OOT driver by jinlife
$PLUGIN_NAME:
$PLUGIN_NAME: Source: https://github.com/ERSTT/unraid-r8127-driver
$PLUGIN_NAME:
$PLUGIN_NAME: Custom $PLUGIN_NAME driver package for Unraid Kernel v${UNAME%%-*} by ich777
$PLUGIN_NAME:
$PLUGIN_NAME:
$PLUGIN_NAME:
$PLUGIN_NAME:
$PLUGIN_NAME:
$PLUGIN_NAME:
EOF
makepkg -l n -c n ${DATA_DIR}/$PLUGIN_NAME-$PLUGIN_VERSION-$UNAME-1.txz
md5sum ${DATA_DIR}/$PLUGIN_NAME-$PLUGIN_VERSION-$UNAME-1.txz | awk '{print $1}' > ${DATA_DIR}/$PLUGIN_NAME-$PLUGIN_VERSION-$UNAME-1.txz.md5
