if command -v lms >/dev/null; then
  export LMSTUDIO=y
fi
if [ -n "$OLLAMA_HOST" ] || command -v ollama >/dev/null; then
  export OLLAMA=y
fi
