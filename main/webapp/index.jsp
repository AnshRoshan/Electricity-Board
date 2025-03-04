<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Electricity Board Payment Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f5f3ff',
                            100: '#ede9fe',
                            200: '#ddd6fe',
                            300: '#c4b5fd',
                            400: '#a78bfa',
                            500: '#8b5cf6',
                            600: '#7c3aed',
                            700: '#6d28d9',
                            800: '#5b21b6',
                            900: '#4c1d95',
                        },
                    },
                    animation: {
                        'pulse-slow': 'pulse 4s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                    }
                }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Inter', sans-serif;
            background: #0f172a;
        }

        .hero-gradient {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.9), rgba(30, 41, 59, 0.8));
        }

        .card-gradient {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
        }

        .button-glow:hover {
            box-shadow: 0 0 15px rgba(139, 92, 246, 0.5);
            transform: translateY(-2px);
            transition: all 0.3s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fadeInUp {
            animation: fadeInUp 0.8s ease-out forwards;
        }

        .delay-100 {
            animation-delay: 0.1s;
        }

        .delay-200 {
            animation-delay: 0.2s;
        }

        .delay-300 {
            animation-delay: 0.3s;
        }

        .delay-400 {
            animation-delay: 0.4s;
        }
    </style>
</head>

<body class="min-h-screen text-gray-100">
    <!-- Navbar -->
    <nav class="bg-gray-900 border-b border-gray-800 shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center">
                        <svg class="h-8 w-8 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M13 10V3L4 14h7v7l9-11h-7z" />
                        </svg>
                        <span class="ml-2 text-xl font-bold">PowerPay</span>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <a href="#features"
                        class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Features</a>
                    <a href="#about"
                        class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">About</a>
                    <a href="#contact"
                        class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Contact</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative overflow-hidden">
        <div class="hero-gradient absolute inset-0 z-0"></div>
        <div
            class="absolute inset-0 z-10 bg-[url('https://images.unsplash.com/photo-1591210003864-f5e0f2a2d6c1?q=80&w=2070&auto=format&fit=crop')] bg-cover bg-center opacity-20">
        </div>

        <div class="relative z-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 md:py-32">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
                <div class="space-y-8 opacity-0 animate-fadeInUp">
                    <h1 class="text-4xl md:text-5xl font-bold leading-tight text-white">
                        Smart Electricity <span class="text-primary-400">Payment</span> Management
                    </h1>
                    <p class="text-xl text-gray-300">
                        Pay your electricity bills securely and efficiently. Track usage, manage payments, and avoid
                        late fees with our comprehensive portal.
                    </p>
                    <div class="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4 pt-4">
                        <a href="register"
                            class="inline-flex items-center justify-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 button-glow">
                            Get Started
                            <svg xmlns="http://www.w3.org/2000/svg" class="ml-2 h-5 w-5" viewBox="0 0 20 20"
                                fill="currentColor">
                                <path fill-rule="evenodd"
                                    d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z"
                                    clip-rule="evenodd" />
                            </svg>
                        </a>
                        <a href="login"
                            class="inline-flex items-center justify-center px-6 py-3 border border-gray-300 text-base font-medium rounded-md text-white hover:bg-gray-700 button-glow">
                            Sign In
                        </a>
                    </div>
                </div>

                <div class="opacity-0 animate-fadeInUp delay-200">
                    <div class="card-gradient rounded-2xl shadow-2xl border border-gray-700 p-6 backdrop-blur-sm">
                        <div class="flex items-center justify-between mb-6">
                            <div class="flex items-center">
                                <div class="h-12 w-12 rounded-full bg-primary-500/20 flex items-center justify-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-400" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M13 10V3L4 14h7v7l9-11h-7z" />
                                    </svg>
                                </div>
                                <div class="ml-4">
                                    <h3 class="text-lg font-semibold">Quick Payment</h3>
                                    <p class="text-sm text-gray-400">Secure & Fast</p>
                                </div>
                            </div>
                            <span class="text-primary-400 animate-pulse-slow">Live</span>
                        </div>

                        <div class="space-y-4">
                            <div class="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                                <div class="flex justify-between items-center">
                                    <span class="text-gray-400">Current Bill</span>
                                    <span class="font-semibold">$124.50</span>
                                </div>
                                <div class="mt-2 w-full bg-gray-700 rounded-full h-2">
                                    <div class="bg-gradient-to-r from-primary-500 to-blue-500 h-2 rounded-full"
                                        style="width: 75%"></div>
                                </div>
                                <div class="flex justify-between text-xs mt-1">
                                    <span class="text-gray-500">Due in 7 days</span>
                                    <span class="text-primary-400">75% of average</span>
                                </div>
                            </div>

                            <div class="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                                <div class="flex justify-between mb-2">
                                    <span class="text-gray-400">Usage Trend</span>
                                    <span class="text-green-400 text-sm">-12% this month</span>
                                </div>
                                <div class="flex items-end space-x-2 h-16">
                                    <div
                                        class="w-1/6 bg-primary-900/50 hover:bg-primary-700/50 rounded-t h-6 transition-all">
                                    </div>
                                    <div
                                        class="w-1/6 bg-primary-900/50 hover:bg-primary-700/50 rounded-t h-8 transition-all">
                                    </div>
                                    <div
                                        class="w-1/6 bg-primary-900/50 hover:bg-primary-700/50 rounded-t h-12 transition-all">
                                    </div>
                                    <div
                                        class="w-1/6 bg-primary-900/50 hover:bg-primary-700/50 rounded-t h-10 transition-all">
                                    </div>
                                    <div
                                        class="w-1/6 bg-primary-900/50 hover:bg-primary-700/50 rounded-t h-14 transition-all">
                                    </div>
                                    <div
                                        class="w-1/6 bg-primary-500/70 hover:bg-primary-500 rounded-t h-9 transition-all">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-16 bg-gray-900">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16 opacity-0 animate-fadeInUp">
                <h2 class="text-3xl font-bold text-white">Smart Features for Smart Payments</h2>
                <p class="mt-4 text-xl text-gray-400">Everything you need to manage your electricity payments
                    efficiently</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div
                    class="bg-gray-800 rounded-xl p-6 border border-gray-700 shadow-lg opacity-0 animate-fadeInUp delay-100">
                    <div class="h-12 w-12 rounded-lg bg-primary-900 flex items-center justify-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-400" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Easy Payments</h3>
                    <p class="text-gray-400">Multiple payment options including credit cards, net banking, and digital
                        wallets.</p>
                </div>

                <div
                    class="bg-gray-800 rounded-xl p-6 border border-gray-700 shadow-lg opacity-0 animate-fadeInUp delay-200">
                    <div class="h-12 w-12 rounded-lg bg-primary-900 flex items-center justify-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-400" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Usage Analytics</h3>
                    <p class="text-gray-400">Track your electricity consumption patterns and identify ways to save
                        energy.</p>
                </div>

                <div
                    class="bg-gray-800 rounded-xl p-6 border border-gray-700 shadow-lg opacity-0 animate-fadeInUp delay-300">
                    <div class="h-12 w-12 rounded-lg bg-primary-900 flex items-center justify-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary-400" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-2">Smart Reminders</h3>
                    <p class="text-gray-400">Get timely notifications about upcoming bills and payment deadlines.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 border-t border-gray-800 py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div class="col-span-1 md:col-span-2">
                    <div class="flex items-center">
                        <svg class="h-8 w-8 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M13 10V3L4 14h7v7l9-11h-7z" />
                        </svg>
                        <span class="ml-2 text-xl font-bold">PowerPay</span>
                    </div>
                    <p class="mt-4 text-gray-400">
                        Making electricity bill payments simple, secure, and efficient for everyone.
                    </p>
                </div>

                <div>
                    <h3 class="text-sm font-semibold text-gray-300 uppercase tracking-wider">Resources</h3>
                    <ul class="mt-4 space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-primary-400">Documentation</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-primary-400">Help Center</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-primary-400">FAQs</a></li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-sm font-semibold text-gray-300 uppercase tracking-wider">Legal</h3>
                    <ul class="mt-4 space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-primary-400">Privacy Policy</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-primary-400">Terms of Service</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-primary-400">Contact Us</a></li>
                    </ul>
                </div>
            </div>

            <div class="mt-12 pt-8 border-t border-gray-800 flex flex-col md:flex-row justify-between items-center">
                <p class="text-gray-400">&copy; 2023 PowerPay Electricity Board. All rights reserved.</p>
                <div class="flex space-x-6 mt-4 md:mt-0">
                    <a href="#" class="text-gray-400 hover:text-primary-400">
                        <span class="sr-only">Facebook</span>
                        <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path fill-rule="evenodd"
                                d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z"
                                clip-rule="evenodd" />
                        </svg>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-primary-400">
                        <span class="sr-only">Twitter</span>
                        <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path
                                d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
                        </svg>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-primary-400">
                        <span class="sr-only">Instagram</span>
                        <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                            <path fill-rule="evenodd"
                                d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.45 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z"
                                clip-rule="evenodd" />
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </footer>

    <script>
        // Simple animation trigger on scroll
        document.addEventListener('DOMContentLoaded', function () {
            const animatedElements = document.querySelectorAll('.animate-fadeInUp');

            // Initial animation for elements in viewport
            animatedElements.forEach(el => {
                if (isInViewport(el)) {
                    el.style.opacity = '1';
                }
            });

            // Animation on scroll
            window.addEventListener('scroll', function () {
                animatedElements.forEach(el => {
                    if (isInViewport(el) && el.style.opacity !== '1') {
                        el.style.opacity = '1';
                    }
                });
            });

            function isInViewport(element) {
                const rect = element.getBoundingClientRect();
                return (
                    rect.top <= (window.innerHeight || document.documentElement.clientHeight) &&
                    rect.bottom >= 0
                );
            }
        });
    </script>
</body>

</html>