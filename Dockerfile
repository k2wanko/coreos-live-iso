FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y tar
RUN apt-get install -y mkisofs
RUN apt-get install -y syslinux


WORKDIR /work
RUN mkdir -p iso/coreos iso/syslinux iso/isolinux 
ENV PATH /scripts:$PATH

# Set public key
COPY id_rsa.pub /id_rsa.pub

# Download syslinux
ENV SYSLINUX_VERSION 6.03
ENV SYSLINUX_BASENAME syslinux-${SYSLINUX_VERSION}
ENV SYSLINUX_URL ftp://www.kernel.org/pub/linux/utils/boot/syslinux/${SYSLINUX_BASENAME}.tar.gz
ENV BOOT_ENV bios
COPY scripts/download-syslinux /scripts/download-syslinux
RUN download-syslinux
COPY scripts/set-syslinux /scripts/set-syslinux

# Download CoreOS
ENV CHANNEL stable
ENV VERSION current
ENV COREOS_BASE_URL   http://${CHANNEL}.release.core-os.net/amd64-usr/${VERSION}
ENV COREOS_VER_URL    ${COREOS_BASE_URL}/version.txt
ENV COREOS_KERN_URL   ${COREOS_BASE_URL}/coreos_production_pxe.vmlinuz
ENV COREOS_INITRD_URL ${COREOS_BASE_URL}/coreos_production_pxe_image.cpio.gz
COPY scripts/download-coreos /scripts/download-coreos
RUN download-coreos

WORKDIR iso/coreos
RUN mkdir -p usr/share/oem

COPY vps-config /work/iso/coreos/usr/share/oem/vps-config
COPY oem-run /work/iso/coreos/usr/share/oem/run
#COPY cloud-config.yml /work/iso/coreos/usr/share/oem/cloud-config.yml

RUN gzip -d cpio.gz
RUN find usr | cpio -o -A -H newc -O cpio
RUN gzip cpio

# Set syslinux
WORKDIR /work
RUN set-syslinux

# Make ISO
WORKDIR /work/iso
RUN mkisofs -v -l -r -J -o /CoreOS.iso \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
RUN isohybrid /CoreOS.iso
