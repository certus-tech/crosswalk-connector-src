#!/bin/bash
set -e
########################################################################
# Clean the documentation site.
########################################################################

# Delete any tmp dirs created by Publican.
rm -rf ../../ext/Publican/CommonContent/common

doc_root=../../documentation/UKRISSCrosswalk
rm -rf $doc_root/publish
rm -rf $doc_root/tmp

doc_root=../../documentation/UKRISSCrosswalkConnector
rm -rf $doc_root/publish
rm -rf $doc_root/tmp
