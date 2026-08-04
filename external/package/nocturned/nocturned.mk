################################################################################
#
# nocturned — Unchained fork (USB-only transport, no iAP2/BT)
#
# Upstream: https://github.com/usenocturne/nocturned
# Fork:     https://github.com/spencerthayer/nocturned
#
# Pin is annotated tag unchained-daemon-0.1 at 492a2be (includes unbounded
# USB bind + peer_session duplex tests). Must remain an ancestor of
# unchained/offline-integration in the nocturned fork.
#
# For local iteration use NOCTURNED_OVERRIDE_SRCDIR in output/local.mk (see
# local.mk.example).  The git pin is only used when OVERRIDE_SRCDIR is unset.
#
################################################################################

NOCTURNED_VERSION = unchained-daemon-0.1
NOCTURNED_SITE_METHOD = git
NOCTURNED_SITE = https://github.com/spencerthayer/nocturned.git

$(eval $(cargo-package))
