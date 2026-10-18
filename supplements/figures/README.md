# Images in the supplements

Where each image came from, and under what terms, in the same spirit as
`lectures/figures/README.md`.

These two are **reference photographs of toys**, used in Supplement 1 to show the
physical object a color palette was taken from. They are third-party product
photography, not public domain, and they are included as small low-resolution
excerpts for teaching, credited and linked on the slide where they appear.

| File | Shows | Source page | Credit shown on slide |
|---|---|---|---|
| `glyaxia_command.jpg` | Glyan, Glyaxia Command colorway, Onell Design, 2014 | <https://database.glyos.com/2014/05/glyan-glyaxia-standard.html> | yes, with link |
| `megatron_g1.jpg` | Megatron, Generation 1 toy, 1984 | <https://tfwiki.net/wiki/Megatron_(G1)/toys> | yes, with link |

Both URLs come from the package data itself: `glyos_colorways$image` and
`glyos_colorways$source` in **glyospalettes**, and `tf_characters$image` and
`tf_characters$source` in **transformerpalettes**.

## Why these are stored here rather than linked

The supplements render with `embed-resources: true`, so an image referenced by
URL is downloaded and base64-inlined into the published HTML anyway. Keeping a
copy in the repository changes nothing about what gets distributed, and it means

- rendering does not depend on a third-party host being up, and
- the slide does not silently lose its illustration when a URL moves.

That second point is not hypothetical. The Optimus Prime entry in
**transformerpalettes** points at
`tfwiki.net/mediawiki/images2/2/2d/G1_OptimusPrime_toy.jpg`, which now returns
404: the file has been removed from that wiki. Megatron is used instead. A spot
check of 12 images from each package on 2026-10-18 found Glyos at 12 of 12 live
and Transformers at 10 of 12.

## If you add more

Take the URL from the package data rather than from a search engine, so the
photograph matches the colorway the palette was actually sampled from. Record
the source page here, and put the credit and link on the slide itself, not only
in this file.
