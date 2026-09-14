return {
  settings = {
    ty = {
      experimental = {
        -- Let ty use uv to build/refresh per-script venvs for PEP 723
        -- standalone scripts (`# /// script`), so their inline deps resolve.
        useUv = 'scripts',
      },
    },
  },
}
