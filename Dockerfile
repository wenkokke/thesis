FROM texlive/texlive:latest-basic AS build-stage

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y fonts-noto latexmk pandoc
RUN tlmgr install amsmath bussproofs cancel caption cleveref cmll enumitem etoolbox filehook framed mathcommand mathpartir mathtools parskip pgf relsize scalerel sectsty standalone stmaryrd svn-prov thmtools tikz-cd unicode-math xcolor xetex
ENV PATH="/usr/local/texlive/2024/bin/aarch64-linux:${PATH}"

WORKDIR /thesis
ADD .latexmkrc          ./.latexmkrc
ADD assets/             ./assets
ADD chapters/           ./chapters
ADD index.defaults.yaml ./index.defaults.yaml
ADD index.md            ./index.md
ADD scripts/            ./scripts
RUN latexmk -C && latexmk -pvc- || cat .latexmk-cache/index.log

FROM scratch AS export-stage
COPY --from=build-stage /thesis/index.pdf /
