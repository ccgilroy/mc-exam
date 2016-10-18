# Multiple Choice Exam Parser

This repo generates multiple choice exams formatted with numbered questions and lettered answer choices, with both question order and answer order randomized, from a YAML file of questions and answers.

## Background and Inspiration

I was directly inspired by [this answer](http://stats.stackexchange.com/a/16476) on Stack Overflow and the example Ruby script the respondent provided.

My parsing and formatting rely extensively on the Tidyverse [`stringr`](https://github.com/tidyverse/stringr) package by Hadley Wickam.

Alternatives considered: the [GIFT format](https://docs.moodle.org/31/en/GIFT_format) and the [MediaWiki Quiz format](https://www.mediawiki.org/wiki/Extension:Quiz) both seemed overly complex for my needs, and not particularly readable on their own or suitable for producing standalone printed exams.

## Contents

`parse_questions.R` contains the main function, `parse_questions()`, as well as a few helper functions for randomization and formatting.

`example_exam_*_version.Rmd` shows how to read in the YAML file using the `yaml` package and chain the functions together to produces an exam or answer key document.

`example_questions.yml` illustrates the permissible variations on the question format.

`example_exam_html_version.md` is an example of the output, but it needs Pandoc Markdown (not GitHub-flavored Markdown) to render lettered lists properly. See the [final html version](https://ccgilroy.github.io/mc-exam/example_exam_html_version.html), hosted on GitHub Pages.

## Usage

I have used these scripts to produce exams for a course I TA at the University of Washington.

My workflow is as follows: I generate separate pdfs for the exam, the exam with answers shown, and the short answer key, using `set.seed()` to keep the three consistent. I produce two alternate versions of the exam by setting different initial seeds.

Feel free to copy, modify, or otherwise make use of this code! (Preferably with attribution---I've used an MIT license to encourage reuse.)

## TODO

There are a bunch of special cases the parser doesn't handle yet. Here's a to-do list:

- Add handling for "All of the above" and "None of the above" options
- Add support for e.g. "Both A and B" options
- Add support for matching-based questions
- Add support for grouped sets of exam questions (e.g. "For the following 4 questions, do X")
