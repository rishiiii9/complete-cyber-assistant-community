<script lang="ts">
	import { onMount } from 'svelte';
	
	let currentTheme = 'ciso-theme';
	
	function toggleTheme() {
		currentTheme = currentTheme === 'ciso-theme' ? 'dark' : 'ciso-theme';
		document.documentElement.setAttribute('data-theme', currentTheme);
	}
	
	onMount(() => {
		document.documentElement.setAttribute('data-theme', currentTheme);
	});
</script>

<svelte:head>
	<title>Brand Colors Demo - Complete Cyber Assistant</title>
</svelte:head>

<div class="min-h-screen bg-surface-50 dark:bg-surface-950">
	<!-- Header -->
	<header class="nav-brand">
		<div class="container mx-auto px-6 py-4">
			<div class="flex items-center justify-between">
				<h1 class="text-2xl font-bold text-brand-teal">Complete Cyber Assistant</h1>
				<button 
					on:click={toggleTheme}
					class="btn-brand-outline"
				>
					{currentTheme === 'ciso-theme' ? '🌙' : '☀️'} Toggle Theme
				</button>
			</div>
		</div>
	</header>

	<!-- Main Content -->
	<main class="container mx-auto px-6 py-12">
		<!-- Hero Section -->
		<section class="text-center mb-16">
			<h1 class="heading-brand text-5xl mb-6">Enterprise Brand Colors</h1>
			<p class="text-brand-muted text-xl max-w-3xl mx-auto">
				Professional cybersecurity platform with a sophisticated color palette designed for enterprise applications.
			</p>
		</section>

		<!-- Color Palette Section -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Brand Color Palette</h2>
			
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
				<!-- Primary Teal -->
				<div class="card-brand hover-lift">
					<div class="w-full h-24 bg-brand-teal rounded-lg mb-4"></div>
					<h3 class="heading-brand-light text-xl mb-2">Primary Teal</h3>
					<p class="text-brand-muted mb-3">Main brand color for primary actions</p>
					<code class="text-sm bg-surface-200 dark:bg-surface-800 px-2 py-1 rounded">#3FECAC</code>
				</div>

				<!-- Secondary Navy -->
				<div class="card-brand hover-lift">
					<div class="w-full h-24 bg-brand-navy rounded-lg mb-4"></div>
					<h3 class="heading-brand-light text-xl mb-2">Secondary Navy</h3>
					<p class="text-brand-muted mb-3">Secondary brand color for backgrounds</p>
					<code class="text-sm bg-surface-200 dark:bg-surface-800 px-2 py-1 rounded">#081C2D</code>
				</div>

				<!-- Accent Blue -->
				<div class="card-brand hover-lift">
					<div class="w-full h-24 bg-accent rounded-lg mb-4"></div>
					<h3 class="heading-brand-light text-xl mb-2">Accent Blue</h3>
					<p class="text-brand-muted mb-3">Complementary accent color</p>
					<code class="text-sm bg-surface-200 dark:bg-surface-800 px-2 py-1 rounded">#00D4FF</code>
				</div>
			</div>
		</section>

		<!-- Button Showcase -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Button Components</h2>
			
			<div class="flex flex-wrap gap-4 justify-center">
				<button class="btn-brand-primary">Primary Action</button>
				<button class="btn-brand-secondary">Secondary Action</button>
				<button class="btn-brand-outline">Outline Button</button>
			</div>
		</section>

		<!-- Form Elements -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Form Elements</h2>
			
			<div class="max-w-md mx-auto space-y-4">
				<input 
					type="text" 
					placeholder="Enter your name" 
					class="input-brand w-full focus-brand"
				>
				<input 
					type="email" 
					placeholder="Enter your email" 
					class="input-brand w-full focus-brand"
				>
				<textarea 
					placeholder="Enter your message" 
					class="input-brand w-full h-24 resize-none focus-brand"
				></textarea>
			</div>
		</section>

		<!-- Status Indicators -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Status Indicators</h2>
			
			<div class="flex flex-wrap gap-4 justify-center">
				<div class="status-success">Success Message</div>
				<div class="status-warning">Warning Message</div>
				<div class="status-error">Error Message</div>
				<div class="status-info">Info Message</div>
			</div>
		</section>

		<!-- Gradient Showcase -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Gradient Effects</h2>
			
			<div class="grid grid-cols-1 md:grid-cols-3 gap-8">
				<div class="gradient-brand-primary h-32 rounded-lg flex items-center justify-center">
					<span class="text-white font-bold text-lg">Teal Gradient</span>
				</div>
				<div class="gradient-brand-secondary h-32 rounded-lg flex items-center justify-center">
					<span class="text-white font-bold text-lg">Navy Gradient</span>
				</div>
				<div class="gradient-brand-diagonal h-32 rounded-lg flex items-center justify-center">
					<span class="text-white font-bold text-lg">Diagonal Gradient</span>
				</div>
			</div>
		</section>

		<!-- Interactive Cards -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Interactive Components</h2>
			
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
				<div class="card-brand hover-lift">
					<h3 class="heading-brand-light text-xl mb-3">Hover Lift Effect</h3>
					<p class="text-brand-muted">This card lifts up on hover with a smooth animation.</p>
				</div>
				
				<div class="card-brand hover-glow">
					<h3 class="heading-brand-light text-xl mb-3">Hover Glow Effect</h3>
					<p class="text-brand-muted">This card glows with teal light on hover.</p>
				</div>
				
				<div class="card-brand hover-scale">
					<h3 class="heading-brand-light text-xl mb-3">Hover Scale Effect</h3>
					<p class="text-brand-muted">This card scales up slightly on hover.</p>
				</div>
			</div>
		</section>

		<!-- Color Scale Demo -->
		<section class="mb-16">
			<h2 class="heading-brand text-3xl mb-8 text-center">Color Scale Variations</h2>
			
			<div class="space-y-8">
				<!-- Teal Scale -->
				<div>
					<h3 class="heading-brand-light text-xl mb-4">Teal Color Scale</h3>
					<div class="flex space-x-2">
						<div class="w-16 h-16 bg-primary-50 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-100 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-200 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-300 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-400 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-500 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-600 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-700 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-800 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-900 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-primary-950 rounded border border-surface-200"></div>
					</div>
				</div>

				<!-- Navy Scale -->
				<div>
					<h3 class="heading-brand-light text-xl mb-4">Navy Color Scale</h3>
					<div class="flex space-x-2">
						<div class="w-16 h-16 bg-secondary-50 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-100 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-200 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-300 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-400 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-500 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-600 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-700 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-800 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-900 rounded border border-surface-200"></div>
						<div class="w-16 h-16 bg-secondary-950 rounded border border-surface-200"></div>
					</div>
				</div>
			</div>
		</section>
	</main>

	<!-- Footer -->
	<footer class="bg-surface-900 dark:bg-surface-50 text-surface-50 dark:text-surface-900 py-8">
		<div class="container mx-auto px-6 text-center">
			<p class="text-brand-muted">
				Complete Cyber Assistant - Enterprise Brand Color System
			</p>
		</div>
	</footer>
</div>

<style>
	/* Additional custom styles for the demo */
	.container {
		max-width: 1200px;
	}
	
	/* Ensure proper spacing and responsive design */
	@media (max-width: 768px) {
		.container {
			padding-left: 1rem;
			padding-right: 1rem;
		}
		
		.grid {
			grid-template-columns: 1fr;
		}
	}
</style>
