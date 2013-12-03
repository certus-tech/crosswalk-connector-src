#!/bin/bash
set -e
########################################################################
# Build script to build the documentation site.
########################################################################
./clean.sh

# Prepare tmp dir.
tmp_output=../../tmp/UKRISSCrosswalkConnector/site
if [ -d $tmp_output ]; then
  rm -rf $tmp_output
fi
mkdir -p $tmp_output

# Create the site files. This unfortunately creates directories for 49 languages,
# whilst we only want en-US.
cd ${tmp_output}
publican create_site --site_config crosswalk.cfg --db_file crosswalk.db --toc_path .
echo "Publican site created."

# Install the book to the created site.
cd ../../../documentation/UKRISSCrosswalk
cp -R /usr/share/publican/Common_Content/common/ ../../ext/Publican/CommonContent
publican build --embedtoc --formats=html,html-single,pdf --langs=en-US --publish
publican install_book --site_config ${tmp_output}/crosswalk.cfg --lang=en-US

cd ../UKRISSCrosswalkConnector
publican build --embedtoc --formats=html,html-single,pdf --langs=en-US --publish
publican install_book --site_config ${tmp_output}/crosswalk.cfg --lang=en-US
echo "Publican book installed."

cd ${tmp_output}
for f in `ls -1d *-[A-Z][A-Z]` ; do
  if [ -d $f ]; then
    if [[ ! $f =~ en-.* ]]; then
      rm -rf $f
    fi
  fi
done
rm crosswalk*
echo "Documentation build complete."
