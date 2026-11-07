#! /bin/bash
#
# Create/update container-release reference file in directory /opt/openapx
#
# Usage: ./container-release.sh
#
# This script will create or update the container-release reference file in the directory /opt/openapx.
# The container-release file contains metadata about the container image, such as its name,
# version, source repository, and build information.
#
# The script relies on the container-release file ARG with prefix ARG_OPENAPX_*. If a container-release 
# file entry is missing, it is likely that the ARG_OPENAPX_* argument could not be resolved.
#
#

# -- container release file 
CONTAINER_RELEASE=/opt/openapx/container-release


# -- ensure parent directory for container-release exists
mkdir -p $(dirname $CONTAINER_RELEASE)


# -- new CONTAINER file

if [ ! -f $CONTAINER_RELEASE ]; then

cat <<EOF > $CONTAINER_RELEASE
# Container metadata information
#
# Note: The information provided was current at the time of the container build.
#

CONTAINER=
GITHUB_REPO_URL=
GITHUB_REPO_COMMIT_URL=
GITHUB_REPO_BUILD_URL=

# Provenance information for the container image is a record of its origin and image
# dependencies, i.e. the parent heirarchy of images leading up to and including
# this current container image.
[PROVENANCE]
EOF

fi


# -- Update CONTAINER file

# - container reference
sed -i "s|^CONTAINER=.*|CONTAINER=${ARG_OPENAPX_IMAGE_ID}|" $CONTAINER_RELEASE

# - GitHub repository
sed -i "s|^GITHUB_REPO_URL=.*|GITHUB_REPO_URL=${ARG_OPENAPX_GITHUB_REPO_URL}|" $CONTAINER_RELEASE

# - GitHub commit URL
sed -i "s|^GITHUB_REPO_COMMIT_URL=.*|GITHUB_REPO_COMMIT_URL=${ARG_OPENAPX_GITHUB_COMMIT_URL}|" $CONTAINER_RELEASE

# - GitHub build URL
sed -i "s|^GITHUB_REPO_BUILD_URL=.*|GITHUB_REPO_BUILD_URL=${ARG_OPENAPX_GITHUB_BUILD_URL}|" $CONTAINER_RELEASE

# - append current container to PROVENANCE section
echo "${ARG_OPENAPX_IMAGE_ID}" >> $CONTAINER_RELEASE


