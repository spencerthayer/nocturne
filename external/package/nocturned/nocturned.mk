################################################################################
#
# nocturned — Unchained fork (USB-only transport, no iAP2/BT)
#
# Upstream: https://github.com/usenocturne/nocturned
# Fork:     https://github.com/spencerthayer/nocturned
#
# Pin to an immutable commit on the fork.  WI5 (offline-integration) will
# retarget to the integration-branch tip once all component work items land.
#
################################################################################

NOCTURNED_VERSION = c3a0878
NOCTURNED_SITE_METHOD = git
NOCTURNED_SITE = https://github.com/spencerthayer/nocturned.git

$(eval $(cargo-package))
