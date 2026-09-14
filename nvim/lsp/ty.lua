return {
  -- ty reads `experimental.useUv` from initializationOptions, not `settings`.
  init_options = {
    experimental = {
      -- Let ty use uv to build/refresh per-script venvs for PEP 723
      -- standalone scripts (`# /// script`), so their inline deps resolve.
      useUv = 'scripts',
    },
  },
}
