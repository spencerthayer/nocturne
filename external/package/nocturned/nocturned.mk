################################################################################
#
# nocturned — Unchained fork (USB-only transport, no iAP2/BT)
#
# Upstream: https://github.com/usenocturne/nocturned
# Fork:     https://github.com/spencerthayer/nocturned
#
# Pin is annotated tag unchained-daemon-0.2 at the unchained/offline-integration
# tip (expanded peer_session fixtures + session-channel CRC retransmit). checkpin
# requires exact tip equality and origin tag presence.
#
# For local iteration use NOCTURNED_OVERRIDE_SRCDIR in output/local.mk (see
# local.mk.example).  The git pin is only used when OVERRIDE_SRCDIR is unset.
#
################################################################################

NOCTURNED_VERSION = unchained-daemon-0.3
NOCTURNED_SITE_METHOD = git
NOCTURNED_SITE = https://github.com/spencerthayer/nocturned.git

$(eval $(cargo-package))
