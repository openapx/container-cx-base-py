#! /bin/bash
#
# Create/update CONTAINER reference file in root directory
#
# Usage: ./container.sh
#
# This script will create or update the CONTAINER reference file in the root directory.
# The CONTAINER file contains metadata about the container image, such as its name,
# version, source repository, and build information.
#
# The script relies on the container file ARG with prefix ARG_OPENAPX_*. If a CONTAINER
# file entry is missing, it is likely that the ARG_OPENAPX_* argument could not be resolved.
#
#

# -- new CONTAINER file

if [ ! -f CONTAINER ]; then

cat <<EOF > /CONTAINER
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
sed -i "s|^CONTAINER=.*|CONTAINER=${ARG_OPENAPX_IMAGE_ID}|" CONTAINER

# - GitHub repository
sed -i "s|^GITHUB_REPO_URL=.*|GITHUB_REPO_URL=${ARG_OPENAPX_GITHUB_REPO_URL}|" CONTAINER

# - GitHub commit URL
sed -i "s|^GITHUB_REPO_COMMIT_URL=.*|GITHUB_REPO_COMMIT_URL=${ARG_OPENAPX_GITHUB_COMMIT_URL}|" CONTAINER

# - GitHub build URL
sed -i "s|^GITHUB_REPO_BUILD_URL=.*|GITHUB_REPO_BUILD_URL=${ARG_OPENAPX_GITHUB_BUILD_URL}|" CONTAINER

# - append current container to PROVENANCE section
echo "${ARG_OPENAPX_IMAGE_ID}" >> CONTAINER


