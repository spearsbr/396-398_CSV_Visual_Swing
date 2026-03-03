
output=$(quarto render index.qmd 2>&1)
if echo "$output" | grep -qi "error"; then
  echo "Quarto rendering failed with an error."
  echo "$output"
  exit 1
fi

