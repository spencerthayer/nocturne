################################################################################
#
# nocturned — Unchained fork (USB-only transport, no iAP2/BT)
#
# Upstream: https://github.com/usenocturne/nocturned
# Fork:     https://github.com/spencerthayer/nocturned
#
# Pin must be on or after f29f9c2 ("refactor(bluetooth): remove companion and
# rfcomm paths") which strips the BT/iAP2 phone-companion code.
#
# For local iteration use NOCTURNED_OVERRIDE_SRCDIR in output/local.mk (see
# local.mk.example).  The git pin is only used when OVERRIDE_SRCDIR is unset.
#
################################################################################

NOCTURNED_VERSION = f29f9c2
NOCTURNED_SITE_METHOD = git
NOCTURNED_SITE = https://github.com/spencerthayer/nocturned.git

$(eval $(cargo-package))
