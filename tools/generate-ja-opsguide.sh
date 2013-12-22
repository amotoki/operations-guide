#!/bin/bash -x

CONV_ONLY=False
DO_COMMIT=True

#GHPAGEDIR=$HOME/openstack-manuals-ja
#TARGETDIR=openstack-ops-draft
GHPAGEDIR=$HOME/docs/opsguide-gh-pages
TARGETDIR=.

#WORKBRANCH=trans-ja
WORKBRANCH=update-ja-trans

CURDIR=$(pwd)
echo $CURDIR

if [ "$CONV_ONLY" != "True" ]; then
  git checkout $WORKBRANCH
fi

./tools/generatedocbook -l ja -b openstack-ops
cd generated/ja/openstack-ops/
sed -i -e '/webhelpDirname/a\                            <webhelpIndexerLanguage>ja</webhelpIndexerLanguage>' pom.xml
mvn clean generate-sources
cd -

if [ "$CONV_ONLY" == "True" ]; then
  exit 0
fi

cd $GHPAGEDIR
pwd
git checkout gh-pages
mkdir -p $TARGETDIR
rm -rf $TARGETDIR/*
cp -pr $CURDIR/generated/ja/openstack-ops/target/docbkx/webhelp/local/openstack-ops/* $TARGETDIR

if [ "$DO_COMMIT" == "True" ]; then
  git add $TARGETDIR
  git commit -m "Translation snapshot"
fi
