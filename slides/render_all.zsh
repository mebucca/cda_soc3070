#!/usr/bin/env zsh

set -u

script_dir="${0:A:h}"
cd "$script_dir" || exit 1

typeset -a decks notebooks failed
decks=(
  ${(f)"$(
    find . -maxdepth 2 -type f \
      \( -name 'class_*.qmd' -o -name 'bonus_*.qmd' \) \
      -print | LC_ALL=C sort
  )"}
)
notebooks=(
  ${(f)"$(
    find . -maxdepth 2 -type f \
      \( -name 'notebook_*.qmd' -o -name 'nb_*.qmd' -o -name 'nb_*.Rmd' -o -name 'index.qmd' \) \
      -print | LC_ALL=C sort
  )"}
)

if (( ${#decks[@]} == 0 && ${#notebooks[@]} == 0 )); then
  print -u2 "No se encontraron presentaciones Quarto."
  exit 1
fi

for qmd in "${decks[@]}"; do
  print "Renderizando (revealjs): ${qmd#./}"
  (
    cd "${qmd:h}" || exit 1
    quarto render "${qmd:t}" --to revealjs
  )

  if (( $? != 0 )); then
    failed+=("${qmd#./}")
  fi
done

# Practice notebooks are plain HTML documents (their own YAML sets `format:
# html` or `output: html_document`), not revealjs decks.
for qmd in "${notebooks[@]}"; do
  print "Renderizando (html): ${qmd#./}"
  (
    cd "${qmd:h}" || exit 1
    quarto render "${qmd:t}"
  )

  if (( $? != 0 )); then
    failed+=("${qmd#./}")
  fi
done

if (( ${#failed[@]} == 0 )); then
  print "Todas las presentaciones se renderizaron correctamente."
else
  print -u2 "Fallaron los siguientes renders:"
  printf ' - %s\n' "${failed[@]}"
  exit 1
fi
