# OTH Regensburg Thesis Template

This template is for OTH Regensburg students writing their Bachelor's or Master's thesis.

> This repository is a fork of the [HPI Thesis Template](https://typst.app/universe/package/cleanified-hpi-thesis/) ([Source](https://github.com/felixhoffmnn/hpi-thesis-template)), adapted for OTH Regensburg.

## Disclaimer

- This template is not official.
- Official university guidelines may differ from the ones used in this template.

## Getting Started

```bash
typst init @preview/oth-regensburg-thesis
```

## Configuration

An example configuration is located in [`example/`](./example/main.typ).

```typst
#import "@preview/oth-regensburg-thesis:0.1.0": *

#show: project.with(
  title: "My Very Long, Informative, Expressive, and Definitely Fancy Title",
  // translation: "Eine adäquate Übersetzung meines Titels",
  name: "Max Mustermann",
  student-id: "1234567",
  date: "July 17th, 2025",
  study-program: "Computer Science",
  professor: "Prof. Dr. Rosseforp Renttalp",
  second-professor: "Prof. Dr. Anothera Examinia",
  advisors: (
    "This person",  // Even for a single advisor, Typst requires the subsequent comma!
    // "Someone Else"  // Add as many advisors as you like
  ),
  abstract: abstract,
  abstract-de: abstract-de,
  acknowledgements: acknowledgements,
  type: "Master",
  bibliography: bibliography("references.bib"),
  // lang: "de",
  // typography: (font: "STIX Two Text", body-text-size: 12pt),
  // layout: (for-print: true, toc-depth: 2),
  appearance: (
    // accent-color: rgb("#164194"),
    company-logo: image("company-logo.svg", alt: "Logo of associated company or institution", width: 5cm),
    // university-logo-width: 5cm,
  ),
)

... your content ...
```
