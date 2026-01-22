# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```sh
npm run dev      # Start development server with hot-reload
npm run build    # Production build
npm run preview  # Preview production build locally
npm run lint     # Run oxlint to check for issues
npm run lint:fix # Run oxlint and auto-fix issues
npm run format   # Format code with oxfmt
npm run format-and-lint  # Format then lint
```

## Linting & Formatting

This project uses `oxlint` for linting and `oxfmt` for code formatting (both from the Oxc toolchain).

- `oxlint` - Fast JavaScript/TypeScript linter
- `oxfmt` - Fast code formatter

## Styling Guidelines

All styling uses **Tailwind CSS 4** utility classes. Follow these principles:

### Inline Tailwind Over Scoped Styles

Prefer inline Tailwind utility classes over Vue 3 `<style scoped>` blocks whenever possible:

```html
<!-- Preferred: Inline Tailwind classes -->
<button class="bg-primary hover:bg-primary/80 rounded-lg px-4 py-2 text-white">Submit</button>

<!-- Avoid: Scoped styles -->
<style scoped>
  .submit-btn {
    padding: 0.5rem 1rem;
    background-color: var(--color-primary);
    color: white;
    border-radius: 0.5rem;
  }
</style>
```

This keeps styles co-located with markup, improves consistency, and leverages Tailwind's design system.

### Mobile-First Approach

Always style for mobile first, then add responsive modifiers for larger screens:

```html
<div class="text-sm md:text-base lg:text-lg">...</div>
```

### Responsive Priority: Container Queries First

Use container queries (`@container`) as the primary responsive strategy, falling back to media queries only when necessary.

**1. Container queries (preferred)** - Style based on parent container width:

```html
<div class="@container">
  <div class="flex flex-col @md:flex-row @lg:gap-4">
    <!-- Adapts to container size, not viewport -->
  </div>
</div>
```

**2. Named containers** - For nested containers or targeting specific ancestors:

```html
<div class="@container/card">
  <div class="@sm/card:grid-cols-2">...</div>
</div>
```

**3. Max-width container queries** - Apply styles below a container size:

```html
<div class="@max-md:hidden">Hides when container is smaller than md</div>
```

**4. Media queries (fallback)** - Use only for viewport-level concerns:

```html
<div class="md:grid-cols-2 lg:grid-cols-3">...</div>
```

### When to Use Each

- **Container queries**: Component-level responsive behavior (cards, sidebars, widgets)
- **Media queries**: Page layout, viewport-specific features (print, dark mode)

### Theme Colors (Primary/Secondary)

When semantic theme colors are defined in the project's CSS using `@theme`, prefer them over hardcoded color values:

```css
/* Example theme definition in CSS */
@import 'tailwindcss';

@theme {
  --color-primary: #3490dc;
  --color-secondary: #ffed4a;
  --color-accent: #38c172;
}
```

**Usage in components:**

```html
<!-- Preferred: Use semantic theme colors -->
<button class="bg-primary hover:bg-primary/80 text-white">Submit</button>
<span class="text-secondary">Highlighted text</span>

<!-- Avoid: Hardcoded colors when theme colors exist -->
<button class="bg-blue-500 text-white">Submit</button>
```

**When to use theme colors:**

- Buttons, links, and interactive elements → `primary`
- Secondary actions, highlights → `secondary`
- Success/warning/error states → `success`, `warning`, `error` (if defined)

**For dynamic theming** (e.g., user-selectable themes), use `@theme inline`:

```css
@theme inline {
  --color-primary: var(--primary);
}

@layer base {
  :root {
    --primary: #3490dc;
  }
  .theme-dark {
    --primary: #60a5fa;
  }
}
```

## Vue 3 Code Style

Follow the [official Vue.js Style Guide](https://vuejs.org/style-guide/). Key rules:

### Component Names

- Use **multi-word names** to avoid HTML element conflicts: `TodoItem`, not `Item`
- Use **PascalCase** for filenames: `MyComponent.vue`
- Prefix base/presentational components: `BaseButton.vue`, `BaseIcon.vue`

### Reusable Components

Focus on creating reusable, composable components. Always explicitly import components where they are used:

```vue
<script setup>
import BaseButton from '@/components/BaseButton.vue'
import UserCard from '@/components/UserCard.vue'
</script>

<template>
  <UserCard>
    <BaseButton>Click me</BaseButton>
  </UserCard>
</template>
```

- Design components to be generic and reusable across different contexts
- Avoid hardcoding data or logic that could be passed as props
- Use slots for flexible content composition
- Do not rely on global component registration

### Props

Always define props with types and validation:

```js
const props = defineProps({
  status: {
    type: String,
    required: true,
    validator: (value) => ['pending', 'active', 'done'].includes(value),
  },
})
```

### Multi-Attribute Elements

Elements with multiple attributes must span multiple lines, one attribute per line:

```html
<!-- Bad -->
<MyComponent
  foo="a"
  bar="b"
  baz="c"
/>

<!-- Good -->
<MyComponent
  foo="a"
  bar="b"
  baz="c"
/>
```

### Template Expressions

Keep template expressions simple. Move complex logic to computed properties:

```html
<!-- Bad -->
{{ fullName.split(' ').map(w => w[0].toUpperCase() + w.slice(1)).join(' ') }}

<!-- Good -->
{{ normalizedFullName }}
```

### Directive Shorthands

Use shorthands consistently: `:value`, `@click`, `#header`

### v-for

Always use `:key` with `v-for`. Never combine `v-if` with `v-for` on the same element.

## VueUse

Use [@vueuse/core](https://vueuse.org/) utilities whenever applicable. Prefer VueUse composables over custom implementations for common patterns:

- `useLocalStorage`, `useSessionStorage` - Reactive storage
- `useFetch`, `useAsyncState` - Data fetching
- `useMediaQuery`, `useBreakpoints` - Responsive logic
- `useDark`, `useColorMode` - Theme handling
- `useEventListener`, `onClickOutside` - Event handling
- `useDebounceFn`, `useThrottleFn` - Function utilities
- `useVModel` - Two-way binding helpers

## Git Commits

When creating commits, use clean commit messages without the Claude Code footer. Do not include:

- The "🤖 Generated with Claude Code" line
- The "Co-Authored-By: Claude" line
