host_cc := env_var_or_default("HOSTCC", "/usr/bin/gcc-15")
host_cxx := env_var_or_default("HOSTCXX", "/usr/bin/g++-15")

build:
    [ -f output/.config ] || make -C buildroot BR2_EXTERNAL="$PWD/external" O="$PWD/output" BR2_DEFCONFIG="$PWD/configs/nocturne_defconfig" HOSTCC={{host_cc}} HOSTCXX={{host_cxx}} defconfig
    make -C buildroot BR2_EXTERNAL="$PWD/external" O="$PWD/output" BR2_DEFCONFIG="$PWD/configs/nocturne_defconfig" HOSTCC={{host_cc}} HOSTCXX={{host_cxx}} all

menuconfig:
    [ -f output/.config ] || make -C buildroot BR2_EXTERNAL="$PWD/external" O="$PWD/output" BR2_DEFCONFIG="$PWD/configs/nocturne_defconfig" HOSTCC={{host_cc}} HOSTCXX={{host_cxx}} defconfig
    make -C buildroot BR2_EXTERNAL="$PWD/external" O="$PWD/output" BR2_DEFCONFIG="$PWD/configs/nocturne_defconfig" HOSTCC={{host_cc}} HOSTCXX={{host_cxx}} menuconfig

copyconfig:
    rm -f configs/nocturne_defconfig
    cp output/.config configs/nocturne_defconfig

clean: cleandeps
    make -C buildroot O="$PWD/output" clean
    rm -rf output/package

cleandeps:
    rm -rf buildroot/dl/nocturned buildroot/dl/nocturne-ui output/build/nocturned* output/build/nocturne-ui*

install package:
    make -C buildroot BR2_EXTERNAL="$PWD/external" O="$PWD/output" BR2_DEFCONFIG="$PWD/configs/nocturne_defconfig" HOSTCC={{host_cc}} HOSTCXX={{host_cxx}} {{package}}-install

flash slot:
    dd if=output/images/rootfs.ext2 bs=1M status=progress | ssh -o StrictHostKeyChecking=no root@172.16.42.2 dd of=/dev/system_{{slot}} bs=1M
    ssh -o StrictHostKeyChecking=no root@172.16.42.2 phb -s $([ "{{slot}}" = "a" ] && echo 0 || echo 1)

flashconnector slot:
    dd if=output/images/rootfs.ext2 bs=1M status=progress | ssh -p 2022 -o StrictHostKeyChecking=no root@nocturne-connector dd of=/dev/system_{{slot}} bs=1M
    ssh -p 2022 -o StrictHostKeyChecking=no root@nocturne-connector phb -s $([ "{{slot}}" = "a" ] && echo 0 || echo 1)

pre-commit-install:
    pre-commit install

lint:
    pre-commit run --all-files

# Verify the Buildroot nocturned pin is an ancestor of the integration tip.
# Requires sibling checkout at ../nocturned with tag unchained-daemon-0.1.
checkpin:
    #!/usr/bin/env bash
    set -euo pipefail
    pin="$(awk '/^NOCTURNED_VERSION/{print $3; exit}' external/package/nocturned/nocturned.mk)"
    daemon="../nocturned"
    test -d "$daemon/.git"
    git -C "$daemon" rev-parse -q --verify "${pin}^{commit}" >/dev/null
    git -C "$daemon" merge-base --is-ancestor "$pin" unchained/offline-integration
    echo "OK: $pin is ancestor of unchained/offline-integration ($(git -C "$daemon" rev-parse --short "$pin"))"

