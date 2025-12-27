# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```sh
npm run dev      # Start development server with hot-reload
npm run build    # Production build
npm run preview  # Preview production build locally
```

## Architecture

Vue 3 + Vite template using Tailwind CSS v4 and Vue Router.

**Key files:**
- `src/main.js` - App entry point, mounts Vue app with router
- `src/router/index.js` - Vue Router configuration (web history mode)
- `src/App.vue` - Root component
- `src/assets/main.css` - Global styles, imports Tailwind CSS
- `vite.config.js` - Vite configuration with Vue, DevTools, and Tailwind plugins

**Path alias:** `@` maps to `./src` (configured in both `vite.config.js` and `jsconfig.json`)

**Node requirements:** ^20.19.0 or >=22.12.0

**Notable:** Uses `rolldown-vite` (experimental Rolldown-based Vite) instead of standard Vite.
