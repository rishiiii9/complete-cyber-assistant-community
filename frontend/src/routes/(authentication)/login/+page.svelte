<script lang="ts">
	import type { ActionData, PageData } from './$types';
	import Logo from '$lib/components/Logo/Logo.svelte';
	import Greetings from './Greetings.svelte';
	import FormCard from './FormCard.svelte';

	interface Props {
		data: PageData;
		form: ActionData;
	}

	let { data, form }: Props = $props();
</script>

<div class="lg:relative h-screen bg-slate-200">
	<div class="lg:absolute top-5 lg:left-5 flex justify-center">
		<div class="flex justify-center flex-row max-w-48 space-x-4 pb-3">
			<Logo />
		</div>
	</div>
	<div
		class="lg:absolute lg:top-1/2 lg:left-1/2 w-full transform lg:-translate-x-1/2 lg:-translate-y-1/2"
	>
		<div class="flex flex-col lg:flex-row w-full lg:pr-8 space-y-4 lg:space-y-0 lg:space-x-8">
			<!-- Left side: Vector Illustration + Greetings -->
			<div class="hidden lg:flex lg:w-1/2 flex-col justify-center items-center">
				<!-- Vector Illustration - Fixed position -->
				<div class="w-96 h-80 flex items-center justify-center mb-8">
					<svg
						viewBox="0 0 500 400"
						class="w-full h-full"
						xmlns="http://www.w3.org/2000/svg"
					>
						<!-- Background gradient -->
						<defs>
							<linearGradient id="bgGradient" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" style="stop-color:#3b82f6;stop-opacity:0.08" />
								<stop offset="100%" style="stop-color:#1e40af;stop-opacity:0.03" />
							</linearGradient>
							<linearGradient id="shieldGradient" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" style="stop-color:#3b82f6" />
								<stop offset="100%" style="stop-color:#1e40af" />
							</linearGradient>
							<linearGradient id="lockGradient" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" style="stop-color:#10b981" />
								<stop offset="100%" style="stop-color:#059669" />
							</linearGradient>
							<linearGradient id="gearGradient" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" style="stop-color:#f59e0b" />
								<stop offset="100%" style="stop-color:#d97706" />
							</linearGradient>
							<linearGradient id="networkGradient" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" style="stop-color:#8b5cf6" />
								<stop offset="100%" style="stop-color:#7c3aed" />
							</linearGradient>
						</defs>
						
						<!-- Background elements -->
						<circle cx="250" cy="200" r="180" fill="url(#bgGradient)" />
						
						<!-- Main shield -->
						<path
							d="M250 120 L320 150 L320 200 C320 250 250 280 250 280 C250 280 180 250 180 200 L180 150 Z"
							fill="url(#shieldGradient)"
							stroke="#1e40af"
							stroke-width="3"
						/>
						
						<!-- Shield inner highlight -->
						<path
							d="M250 125 L315 152 L315 200 C315 245 250 275 250 275 C250 275 185 245 185 200 L185 152 Z"
							fill="none"
							stroke="#ffffff"
							stroke-width="2"
							opacity="0.4"
						/>
						
						<!-- Central lock -->
						<rect x="235" y="170" width="30" height="35" rx="4" fill="url(#lockGradient)" />
						<path
							d="M235 170 L235 155 C235 148 242 142 250 142 C258 142 265 148 265 155 L265 170"
							fill="none"
							stroke="url(#lockGradient)"
							stroke-width="5"
							stroke-linecap="round"
						/>
						<circle cx="250" cy="185" r="3" fill="#ffffff" />
						<rect x="247" y="185" width="6" height="12" fill="#ffffff" />
						
						<!-- Security gears -->
						<g transform="translate(100, 100)">
							<circle cx="0" cy="0" r="25" fill="url(#gearGradient)" />
							<circle cx="0" cy="0" r="15" fill="#ffffff" />
							<path d="M0 -25 L5 -20 L5 -5 L-5 -5 L-5 -20 Z" fill="url(#gearGradient)" />
							<path d="M25 0 L20 5 L5 5 L5 -5 L20 -5 Z" fill="url(#gearGradient)" />
							<path d="M0 25 L-5 20 L-5 5 L5 5 L5 20 Z" fill="url(#gearGradient)" />
							<path d="M-25 0 L-20 -5 L-5 -5 L-5 5 L-20 5 Z" fill="url(#gearGradient)" />
						</g>
						
						<g transform="translate(400, 120)">
							<circle cx="0" cy="0" r="20" fill="url(#gearGradient)" />
							<circle cx="0" cy="0" r="12" fill="#ffffff" />
							<path d="M0 -20 L4 -16 L4 -4 L-4 -4 L-4 -16 Z" fill="url(#gearGradient)" />
							<path d="M20 0 L16 4 L4 4 L4 -4 L16 -4 Z" fill="url(#gearGradient)" />
							<path d="M0 20 L-4 16 L-4 4 L4 4 L4 16 Z" fill="url(#gearGradient)" />
							<path d="M-20 0 L-16 -4 L-4 -4 L-4 4 L-16 4 Z" fill="url(#gearGradient)" />
						</g>
						
						<!-- Network nodes -->
						<circle cx="80" cy="80" r="8" fill="url(#networkGradient)" opacity="0.8">
							<animate attributeName="opacity" values="0.8;1;0.8" dur="2s" repeatCount="indefinite" />
						</circle>
						<circle cx="420" cy="80" r="8" fill="url(#networkGradient)" opacity="0.8">
							<animate attributeName="opacity" values="0.8;1;0.8" dur="2.3s" repeatCount="indefinite" />
						</circle>
						<circle cx="80" cy="320" r="8" fill="url(#networkGradient)" opacity="0.8">
							<animate attributeName="opacity" values="0.8;1;0.8" dur="1.8s" repeatCount="indefinite" />
						</circle>
						<circle cx="420" cy="320" r="8" fill="url(#networkGradient)" opacity="0.8">
							<animate attributeName="opacity" values="0.8;1;0.8" dur="2.1s" repeatCount="indefinite" />
						</circle>
						
						<!-- Connection lines -->
						<line x1="80" y1="80" x2="180" y2="150" stroke="url(#networkGradient)" stroke-width="2" opacity="0.4" />
						<line x1="420" y1="80" x2="320" y2="150" stroke="url(#networkGradient)" stroke-width="2" opacity="0.4" />
						<line x1="80" y1="320" x2="180" y2="250" stroke="url(#networkGradient)" stroke-width="2" opacity="0.4" />
						<line x1="420" y1="320" x2="320" y2="250" stroke="url(#networkGradient)" stroke-width="2" opacity="0.4" />
						
						<!-- Security checkmarks -->
						<g transform="translate(120, 280)">
							<circle cx="0" cy="0" r="12" fill="#10b981" />
							<path d="M-4 0 L-1 3 L4 -2" stroke="#ffffff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" />
						</g>
						<g transform="translate(380, 280)">
							<circle cx="0" cy="0" r="12" fill="#10b981" />
							<path d="M-4 0 L-1 3 L4 -2" stroke="#ffffff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" />
						</g>
						
						<!-- Floating security elements -->
						<g transform="translate(150, 60)">
							<rect x="-8" y="-8" width="16" height="16" rx="2" fill="#3b82f6" opacity="0.7">
								<animate attributeName="opacity" values="0.7;1;0.7" dur="3s" repeatCount="indefinite" />
							</rect>
						</g>
						<g transform="translate(350, 60)">
							<rect x="-8" y="-8" width="16" height="16" rx="2" fill="#10b981" opacity="0.7">
								<animate attributeName="opacity" values="0.7;1;0.7" dur="2.7s" repeatCount="indefinite" />
							</rect>
						</g>
					</svg>
				</div>
				
				<!-- Greetings text below the illustration - Fixed height container -->
				<div class="h-32 flex items-center justify-center">
					<Greetings />
				</div>
			</div>
			
			<!-- Form section -->
			<div class="flex justify-center lg:pr-5 items-center w-full lg:w-2/5">
				<FormCard {data} {form} />
			</div>
		</div>
	</div>
</div>
