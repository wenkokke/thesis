# Propositions As Sessions Taken Apart

This repository contains the source for my Ph.D. thesis:

> Kokke, W.
> (2024).
> *Propositions as sessions taken apart*
> [Doctoral dissertation, University of Edinburgh].

## Cite

To cite my Ph.D. thesis, please use the following bibTeX entry:

```bibtex
@phdthesis{Kokke24:PASTA,
    author = {Wen Kokke},
    title = {Propositions As Sessions Taken Apart},
    school = {University of Edinburgh},
    address = {Edinburgh, UK},
    year = 2024,
    month = sep,
}
```

## Build

To build my Ph.D. thesis from source, you need the full TeX Live 2024 distribution, [pandoc] version 3.0.1 or later, and the [Noto font family][noto-fonts]

Run Latexmk:

```bash
latexmk
```

The thesis is built as `index.pdf`.

## License

The text of the Ph.D. thesis is licensed under the Creative Commons license Attribution-NonCommercial-ShareAlike 4.0 International ([CC-BY-NC-SA-4.0]).

The files in this repository are licensed under the GNU Affero General Public License ([AGPL-3.0-only]), with the exception of the following files:

- The files under `scripts/pandoc/abstract-section` are licensed under the MIT license; see [scripts/pandoc/abstract-section/LICENSE](scripts/pandoc/abstract-section/LICENSE).

- The files under `scripts/pandoc/include-files` are licensed under the MIT license; see [scripts/pandoc/include-files/LICENSE](scripts/pandoc/include-files/LICENSE).

- The files under `assets/fonts` are licensed under the SIL Open Font License 1.1; see [assets/fonts/LICENSE](assets/fonts/LICENSE).

- The files `assets/infthesis.cls`, `assets/eushield-normal.pdf`, `assets/eushield-normal.ps`, `assets/eushield.eps`, and `assets/eushield.sty` are the property of the University of Edinburgh.

[pandoc]: https://pandoc.org
[noto-fonts]: https://github.com/notofonts/noto-fonts/tree/main
[CC-BY-NC-SA-4.0]: https://creativecommons.org/licenses/by-nc-sa/4.0/
[AGPL-3.0-only]: https://www.gnu.org/licenses/agpl-3.0.html
