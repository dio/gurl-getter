#!/usr/bin/env bash

# Copyright (C) 2020 Dhi Aurrahman <dio@rockybars.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

set -u
set -e

# TODO(dio): Check checksum.
# Prepare Bazel.
curl -LO "https://github.com/bazelbuild/bazelisk/releases/download/v1.1.0/bazelisk-linux-amd64"
mkdir -p "${GITHUB_WORKSPACE}"/bin
BAZEL_BIN="${GITHUB_WORKSPACE}"/bin/bazel
mv bazelisk-linux-amd64 "${BAZEL_BIN}"
chmod +x "${BAZEL_BIN}"

git clone --depth 1 https://github.com/google/copybara.git

mkdir -p "${GITHUB_WORKSPACE}"/gurl

pushd copybara
"${BAZEL_BIN}" run //java/com/google/copybara -- "${GITHUB_WORKSPACE}"/copy.bara.sky \
    "${GITHUB_WORKSPACE}"/chromium/src --folder-dir "${GITHUB_WORKSPACE}"/gurl
popd

ls -la
