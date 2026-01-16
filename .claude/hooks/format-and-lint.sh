#!/bin/bash

# Run oxfmt (formatter) then oxlint (linter) on files changed by Claude Code
# This hook runs after Edit or Write tool calls
#
# 1. Format file (auto-fix, silent)
# 2. Lint file (report errors to Claude)

# Extract the file path from JSON input (passed via stdin)
FILE_PATH=$(jq -r '.tool_input.file_path // empty')

# Exit if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Step 1: Format (for supported file types)
if [[ "$FILE_PATH" =~ \.(js|jsx|ts|tsx|vue|json|css|md|html)$ ]]; then
  npx oxfmt "$FILE_PATH" > /dev/null 2>&1
fi

# Step 2: Lint (only for JS/TS/Vue files)
if [[ "$FILE_PATH" =~ \.(js|jsx|ts|tsx|vue)$ ]]; then
  LINT_OUTPUT=$(npx oxlint "$FILE_PATH" 2>&1)

  # Check if there are any errors or warnings
  if echo "$LINT_OUTPUT" | grep -q "Found.*errors\|Found.*warnings"; then
    # Escape the output for JSON
    ESCAPED_OUTPUT=$(echo "$LINT_OUTPUT" | jq -Rs .)

    # Output JSON that Claude can see
    echo "{\"decision\": \"block\", \"reason\": $ESCAPED_OUTPUT}"
    exit 0
  fi
fi

exit 0
