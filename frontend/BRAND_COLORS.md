# Complete Cyber Assistant - Enterprise Brand Colors

## Brand Color Palette

### Primary Colors
- **Brand Teal**: `#3FECAC` - Main brand color for primary actions, highlights, and key UI elements
- **Brand Navy**: `#081C2D` - Secondary brand color for backgrounds, text, and secondary UI elements

### Color Variations
Each brand color includes a complete scale from 50 (lightest) to 950 (darkest) for consistent design:

#### Teal Scale (Primary)
- `--color-primary-50` to `--color-primary-950`
- Based on the main brand teal `#3FECAC`

#### Navy Scale (Secondary)
- `--color-secondary-50` to `--color-secondary-950`
- Based on the main brand navy `#081C2D`

### Semantic Colors
- **Success**: Teal-based for brand consistency
- **Warning**: Warm amber for brand harmony
- **Error**: Red for brand contrast
- **Info**: Blue for information states

## Usage Guidelines

### Primary Actions
- Use **Brand Teal** (`#3FECAC`) for:
  - Primary buttons
  - Call-to-action elements
  - Links and navigation highlights
  - Success states
  - Important form elements

### Secondary Elements
- Use **Brand Navy** (`#081C2D`) for:
  - Backgrounds
  - Text content
  - Secondary buttons
  - Borders and dividers
  - Card backgrounds

### Accessibility
- All color combinations meet WCAG 2.1 AA contrast requirements
- Use the provided contrast utilities for optimal readability
- Test with color blindness simulators for inclusive design

## CSS Classes

### Brand Color Utilities
```css
.bg-brand-teal          /* Background: #3FECAC */
.bg-brand-navy          /* Background: #081C2D */
.text-brand-teal        /* Text: #3FECAC */
.text-brand-navy        /* Text: #081C2D */
.border-brand-teal      /* Border: #3FECAC */
.border-brand-navy      /* Border: #081C2D */
```

### Enterprise Button Styles
```css
.btn-brand-primary      /* Primary button with teal background */
.btn-brand-secondary    /* Secondary button with navy background */
.btn-brand-outline      /* Outline button with teal border */
```

### Enterprise Card Styles
```css
.card-brand             /* Navy gradient background with teal border */
```

### Enterprise Form Styles
```css
.input-brand            /* Navy border with teal focus state */
.focus-brand            /* Teal focus ring */
.focus-brand-secondary  /* Navy focus ring */
```

### Enterprise Effects
```css
.shadow-brand           /* Subtle navy shadow */
.shadow-brand-lg        /* Large navy shadow */
.shadow-brand-xl        /* Extra large navy shadow */
.hover-lift             /* Hover lift effect */
.hover-glow             /* Hover glow effect */
.hover-scale            /* Hover scale effect */
```

### Enterprise Gradients
```css
.gradient-brand-primary    /* Teal gradient */
.gradient-brand-secondary  /* Navy gradient */
.gradient-brand-diagonal   /* Teal to navy diagonal */
```

### Enterprise Transitions
```css
.transition-brand         /* Standard brand transition */
.transition-brand-fast    /* Fast brand transition */
.transition-brand-slow    /* Slow brand transition */
```

## Implementation Examples

### Button Component
```html
<button class="btn-brand-primary px-6 py-3 rounded-lg font-semibold">
  Get Started
</button>
```

### Card Component
```html
<div class="card-brand p-6 hover-lift">
  <h3 class="heading-brand text-xl mb-4">Feature Title</h3>
  <p class="text-brand-muted">Feature description goes here.</p>
</div>
```

### Form Input
```html
<input 
  type="text" 
  class="input-brand px-4 py-2 w-full focus-brand"
  placeholder="Enter your email"
>
```

### Navigation
```nav
<nav class="nav-brand px-6 py-4">
  <a href="#" class="nav-link px-4 py-2 rounded">Home</a>
  <a href="#" class="nav-link px-4 py-2 rounded">About</a>
  <a href="#" class="nav-link px-4 py-2 rounded">Contact</a>
</nav>
```

## Theme Integration

### Skeleton Theme
The brand colors are integrated with the Skeleton UI framework through the `ciso-theme` theme:

```css
[data-theme='ciso-theme'] {
  /* All brand color variables are available here */
  --color-primary-500: /* maps to brand teal */
  --color-secondary-500: /* maps to brand navy */
}
```

### Tailwind CSS
Custom utilities are available for Tailwind CSS:

```css
@utility btn-mini-primary {
  @apply text-brand-navy bg-brand-teal hover:bg-brand-teal-light transition-brand;
}
```

## Dark Mode Support

The brand color system includes automatic dark mode support:

```css
@media (prefers-color-scheme: dark) {
  /* Dark mode color adjustments */
  --color-neutral-50: #1A202C;
  --color-neutral-900: #FAFBFC;
}
```

## Responsive Design

All brand color utilities include responsive variants:

```css
@media (max-width: 768px) {
  .btn-brand-primary,
  .btn-brand-secondary {
    padding: 12px 24px;
    font-size: 14px;
  }
}
```

## Best Practices

1. **Consistency**: Always use the provided color variables, never hardcode hex values
2. **Hierarchy**: Use teal for primary actions, navy for secondary elements
3. **Accessibility**: Ensure sufficient contrast ratios for all text combinations
4. **States**: Use hover, focus, and active states consistently
5. **Branding**: Maintain the professional, enterprise feel through consistent color usage

## Color Psychology

- **Teal (#3FECAC)**: Represents innovation, trust, and cybersecurity
- **Navy (#081C2D)**: Conveys professionalism, stability, and enterprise reliability

## File Structure

```
frontend/
├── ciso-theme.css          # Skeleton theme with brand colors
├── src/
│   ├── brand-colors.css    # Brand color utilities and components
│   └── app.css            # Main app styles with brand imports
└── BRAND_COLORS.md        # This documentation
```

## Support

For questions about the brand color system or to request additional utilities, please refer to the design system documentation or contact the design team.
