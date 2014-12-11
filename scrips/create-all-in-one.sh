#!/bin/bash

source /home/stack/workspace/tripleo-incubator/minicloudrc
DEPLOY_NAME=overcloud-allinone
#unset PIP_FIND_LINKS
#unset PIP_INDEX_URL

#$TRIPLEO_ROOT/diskimage-builder/bin/disk-image-create --install-type package ubuntu \
$TRIPLEO_ROOT/diskimage-builder/bin/disk-image-create ubuntu \
    -a $NODE_ARCH -o $TRIPLEO_ROOT/$DEPLOY_NAME ntp hosts pip-cache \
    baremetal boot-stack nova-compute nova-kvm cinder-api ceilometer-collector \
    ceilometer-api ceilometer-agent-central ceilometer-agent-notification \
    ceilometer-alarm-notifier ceilometer-alarm-evaluator \
    os-collect-config horizon neutron-openvswitch-agent neutron-network-node dhcp-all-interfaces \
    swift-proxy swift-storage keepalived haproxy \
    apt-sources intel-proxy stackuser rabbitmq-server cinder-tgt 2>&1 | \
    tee $TRIPLEO_ROOT/dib-overcloud-allinone.log

exit 0

$TRIPLEO_ROOT/diskimage-builder/bin/ramdisk-image-create -a $NODE_ARCH \
    $NODE_DIST $DEPLOY_IMAGE_ELEMENT -o $TRIPLEO_ROOT/$DEPLOY_NAME \
    $DIB_COMMON_ELEMENTS 2>&1 | \
    tee $TRIPLEO_ROOT/dib-allinone-deploy.log

ramdisk base  ubuntu deploy-ironic apt-sources intel-proxy use-ephemeral
