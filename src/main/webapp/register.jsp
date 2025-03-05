<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PowerPay - Customer Registration</title>
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

            .card-gradient {
                background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
            }

            .input-focus:focus {
                box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.5);
                border-color: #8b5cf6;
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
                animation: fadeInUp 0.6s ease-out forwards;
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

            @keyframes shake {
                0% {
                    transform: translateX(0);
                }

                25% {
                    transform: translateX(-5px);
                }

                50% {
                    transform: translateX(5px);
                }

                75% {
                    transform: translateX(-5px);
                }

                100% {
                    transform: translateX(0);
                }
            }

            .shake {
                animation: shake 0.5s;
            }
        </style>
    </head>

    <body class="min-h-screen text-gray-100">
        <!-- Navbar -->
        <nav class="bg-gray-900 border-b border-gray-800 shadow-lg">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    <div class="flex items-center">
                        <a href="index.jsp" class="flex-shrink-0 flex items-center">
                            <svg class="h-8 w-8 text-primary-500" xmlns="http://www.w3.org/2000/svg" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M13 10V3L4 14h7v7l9-11h-7z" />
                            </svg>
                            <span class="ml-2 text-xl font-bold">PowerPay</span>
                        </a>
                    </div>
                    <div class="flex items-center space-x-4">
                        <a href="login"
                            class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Sign In</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div
                class="card-gradient rounded-2xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm opacity-0 animate-fadeInUp">
                <div class="flex items-center justify-center mb-8">
                    <div class="h-16 w-16 rounded-full bg-primary-500/20 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary-400" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                        </svg>
                    </div>
                    <h2 class="ml-4 text-3xl font-bold text-white">Create Your Account</h2>
                </div>

                <% if (request.getAttribute("message") !=null) { %>
                    <div class="mb-8 p-4 rounded-lg <%= request.getAttribute("message").toString().contains("successful")
                        ? "bg-green-900/50 border border-green-700 text-green-300"
                        : "bg-red-900/50 border border-red-700 text-red-300" %> opacity-0 animate-fadeInUp">
                        <%= request.getAttribute("message") %>
                    </div>
                    <% } %>

                        <form action="register" method="post" onsubmit="return validateForm()" class="space-y-8">
                            <!-- Progress Steps -->
                            <div class="flex justify-between items-center mb-8 opacity-0 animate-fadeInUp delay-100">
                                <div class="w-full flex items-center">
                                    <div class="relative flex flex-col items-center">
                                        <div
                                            class="rounded-full h-10 w-10 bg-primary-600 flex items-center justify-center z-10">
                                            <span class="text-white font-bold">1</span>
                                        </div>
                                        <div class="text-xs text-primary-400 mt-1">Account</div>
                                    </div>
                                    <div class="flex-1 h-1 bg-gray-700">
                                        <div class="h-1 bg-primary-600" style="width: 0%" id="progress-bar-1"></div>
                                    </div>
                                    <div class="relative flex flex-col items-center">
                                        <div class="rounded-full h-10 w-10 bg-gray-700 flex items-center justify-center z-10"
                                            id="step-2">
                                            <span class="text-white font-bold">2</span>
                                        </div>
                                        <div class="text-xs text-gray-500 mt-1" id="step-2-text">Personal</div>
                                    </div>
                                    <div class="flex-1 h-1 bg-gray-700">
                                        <div class="h-1 bg-primary-600" style="width: 0%" id="progress-bar-2"></div>
                                    </div>
                                    <div class="relative flex flex-col items-center">
                                        <div class="rounded-full h-10 w-10 bg-gray-700 flex items-center justify-center z-10"
                                            id="step-3">
                                            <span class="text-white font-bold">3</span>
                                        </div>
                                        <div class="text-xs text-gray-500 mt-1" id="step-3-text">Security</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Step 1: Account Information -->
                            <div id="step-1-content" class="space-y-6">
                                <div class="opacity-0 animate-fadeInUp delay-200">
                                    <label for="consumerNumber"
                                        class="block text-sm font-medium text-gray-300 mb-1">ConsumerNumber</label>
                                    <div class="relative">
                                        <div
                                            class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                                            </svg>
                                        </div>
                                        <input type="text" id="consumerNumber" name="consumerNumber" maxlength="13"
                                            required
                                            class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                            placeholder="13-digit ConsumerNumber"
                                            oninput="validateConsumerNumber(this)">
                                    </div>
                                    <span id="consumerNumberError" class="hidden text-red-400 text-xs mt-1"></span>
                                </div>

                                <div class="opacity-0 animate-fadeInUp delay-300">
                                    <label for="email" class="block text-sm font-medium text-gray-300 mb-1">Email
                                        Address</label>
                                    <div class="relative">
                                        <div
                                            class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                                            </svg>
                                        </div>
                                        <input type="email" id="email" name="email" maxlength="64" required
                                            class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                            placeholder="your@email.com" oninput="validateEmail(this)">
                                    </div>
                                    <span id="emailError" class="hidden text-red-400 text-xs mt-1"></span>
                                </div>

                                <div class="opacity-0 animate-fadeInUp delay-400">
                                    <label for="customerType"
                                        class="block text-sm font-medium text-gray-300 mb-1">Customer Type</label>
                                    <div class="relative">
                                        <div
                                            class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                                            </svg>
                                        </div>
                                        <select id="customerType" name="customerType" required
                                            class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white appearance-none input-focus">
                                            <option value="" disabled selected>Select customer type</option>
                                            <option value="Residential">Residential</option>
                                            <option value="Commercial">Commercial</option>
                                            <option value="Industrial">Industrial</option>
                                        </select>
                                        <div
                                            class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                            <svg class="h-5 w-5 text-gray-500" xmlns="http://www.w3.org/2000/svg"
                                                viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>

                                <div class="pt-4 flex justify-end opacity-0 animate-fadeInUp delay-400">
                                    <button type="button" id="next-to-step-2"
                                        class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow disabled:opacity-50 disabled:cursor-not-allowed"
                                        disabled>
                                        Continue to Personal Info
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block ml-1"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <!-- Step 2: Personal Information -->
                            <div id="step-2-content" class="space-y-6 hidden">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <label for="title"
                                            class="block text-sm font-medium text-gray-300 mb-1">Title</label>
                                        <div class="relative">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                    fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
                                            </div>
                                            <select id="title" name="title" required
                                                class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white appearance-none input-focus">
                                                <option value="" disabled selected>Select title</option>
                                                <option value="Mr">Mr</option>
                                                <option value="Ms">Ms</option>
                                                <option value="Mrs">Mrs</option>
                                                <option value="Dr">Dr</option>
                                            </select>
                                            <div
                                                class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                                <svg class="h-5 w-5 text-gray-500" xmlns="http://www.w3.org/2000/svg"
                                                    viewBox="0 0 20 20" fill="currentColor">
                                                    <path fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd" />
                                                </svg>
                                            </div>
                                        </div>
                                    </div>

                                    <div>
                                        <label for="fullName" class="block text-sm font-medium text-gray-300 mb-1">Full
                                            Name</label>
                                        <div class="relative">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                    fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
                                            </div>
                                            <input type="text" id="fullName" name="fullName" maxlength="50" required
                                                class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                                placeholder="Your full name" oninput="validateName(this)">
                                        </div>
                                        <span id="fullNameError" class="hidden text-red-400 text-xs mt-1"></span>
                                    </div>
                                </div>

                                <div>
                                    <label for="address"
                                        class="block text-sm font-medium text-gray-300 mb-1">Address</label>
                                    <div class="relative">
                                        <div class="absolute top-3 left-3 flex items-start pointer-events-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                            </svg>
                                        </div>
                                        <textarea id="address" name="address" required rows="3"
                                            class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                            placeholder="Your complete address"
                                            oninput="validateAddress(this)"></textarea>
                                    </div>
                                    <span id="addressError" class="hidden text-red-400 text-xs mt-1"></span>
                                </div>

                                <div>
                                    <label for="mobileNumber"
                                        class="block text-sm font-medium text-gray-300 mb-1">Mobile Number</label>
                                    <div class="flex">
                                        <div class="relative w-1/4">
                                            <select id="countryCode" name="countryCode"
                                                class="block w-full py-3 bg-gray-800/50 border border-gray-700 rounded-l-lg text-white appearance-none input-focus">
                                                <option value="+91">+91 (India)</option>
                                                <option value="+1">+1 (USA)</option>
                                                <option value="+44">+44 (UK)</option>
                                            </select>
                                            <div
                                                class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                                <svg class="h-5 w-5 text-gray-500" xmlns="http://www.w3.org/2000/svg"
                                                    viewBox="0 0 20 20" fill="currentColor">
                                                    <path fill-rule="evenodd"
                                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                        clip-rule="evenodd" />
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="relative w-3/4">
                                            <div
                                                class="absolute inset-y-0 left-3 flex items-center pointer-events-none">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                    fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                                </svg>
                                            </div>
                                            <input type="text" id="mobileNumber" name="mobileNumber" maxlength="10"
                                                required
                                                class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-r-lg text-white placeholder-gray-500 input-focus"
                                                placeholder="10-digit mobile number" oninput="validateMobile(this)">
                                        </div>
                                    </div>
                                    <span id="mobileError" class="hidden text-red-400 text-xs mt-1"></span>
                                </div>

                                <div class="pt-4 flex justify-between">
                                    <button type="button" id="back-to-step-1"
                                        class="px-6 py-3 bg-gray-700 text-white rounded-lg font-medium hover:bg-gray-600 transition-colors">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block mr-1"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M9.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L7.414 9H15a1 1 0 110 2H7.414l2.293 2.293a1 1 0 010 1.414z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Back
                                    </button>
                                    <button type="button" id="next-to-step-3"
                                        class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow disabled:opacity-50 disabled:cursor-not-allowed">
                                        Continue to Security
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block ml-1"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <!-- Step 3: Security Information -->
                            <div id="step-3-content" class="space-y-6 hidden">
                                <div>
                                    <label for="password"
                                        class="block text-sm font-medium text-gray-300 mb-1">Password</label>
                                    <div class="relative">
                                        <div
                                            class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                            </svg>
                                        </div>
                                        <input type="password" id="password" name="password" required
                                            class="block w-full pl-10 pr-10 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                            placeholder="Create a strong password" oninput="validatePassword(this)">
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                            <button type="button" id="togglePassword"
                                                class="text-gray-500 hover:text-gray-400 focus:outline-none">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor" id="eyeIcon">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </button>
                                        </div>
                                    </div>
                                    <span id="passwordError" class="hidden text-red-400 text-xs mt-1"></span>

                                    <!-- Password strength indicator -->
                                    <div class="mt-2">
                                        <div class="flex justify-between mb-1">
                                            <span class="text-xs text-gray-400">Password strength:</span>
                                            <span class="text-xs" id="strengthText">None</span>
                                        </div>
                                        <div class="w-full bg-gray-700 rounded-full h-1.5">
                                            <div class="bg-red-500 h-1.5 rounded-full" style="width: 0%"
                                                id="strengthBar"></div>
                                        </div>
                                        <div class="flex justify-between mt-2 text-xs text-gray-500">
                                            <span>Weak</span>
                                            <span>Medium</span>
                                            <span>Strong</span>
                                        </div>
                                    </div>

                                    <!-- Password requirements -->
                                    <div class="mt-3 grid grid-cols-2 gap-2">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500"
                                                id="check-length" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span class="ml-2 text-xs text-gray-500" id="text-length">At least 8
                                                characters</span>
                                        </div>
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500"
                                                id="check-lowercase" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span class="ml-2 text-xs text-gray-500" id="text-lowercase">One lowercase
                                                letter</span>
                                        </div>
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500"
                                                id="check-uppercase" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span class="ml-2 text-xs text-gray-500" id="text-uppercase">One uppercase
                                                letter</span>
                                        </div>
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500"
                                                id="check-number" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span class="ml-2 text-xs text-gray-500" id="text-number">One number</span>
                                        </div>
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500"
                                                id="check-special" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span class="ml-2 text-xs text-gray-500" id="text-special">One special
                                                character</span>
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    <label for="confirmPassword"
                                        class="block text-sm font-medium text-gray-300 mb-1">Confirm Password</label>
                                    <div class="relative">
                                        <div
                                            class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                            </svg>
                                        </div>
                                        <input type="password" id="confirmPassword" name="confirmPassword" required
                                            class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                            placeholder="Confirm your password" oninput="validateConfirmPassword(this)">
                                    </div>
                                    <span id="confirmPasswordError" class="hidden text-red-400 text-xs mt-1"></span>
                                </div>

                                <div class="flex items-center">
                                    <input type="checkbox" id="termsAgreement" name="termsAgreement" required
                                        class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 rounded bg-gray-800/50">
                                    <label for="termsAgreement" class="ml-2 block text-sm text-gray-400">
                                        I agree to the <a href="#" class="text-primary-400 hover:text-primary-300">Terms
                                            of Service</a> and <a href="#"
                                            class="text-primary-400 hover:text-primary-300">Privacy Policy</a>
                                    </label>
                                </div>

                                <div class="pt-4 flex justify-between">
                                    <button type="button" id="back-to-step-2"
                                        class="px-6 py-3 bg-gray-700 text-white rounded-lg font-medium hover:bg-gray-600 transition-colors">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block mr-1"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M9.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L7.414 9H15a1 1 0 110 2H7.414l2.293 2.293a1 1 0 010 1.414z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        Back
                                    </button>
                                    <button type="submit" id="submitBtn"
                                        class="px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow disabled:opacity-50 disabled:cursor-not-allowed">
                                        Complete Registration
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block ml-1"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </form>

                        <div class="mt-8 text-center text-gray-400">
                            <p>Already have an account? <a href="login"
                                    class="text-primary-400 hover:text-primary-300">Sign in</a></p>
                        </div>
            </div>
        </div>

        <script>
            // Form validation variables
            let isValidForm = {
                consumerNumber: false,
                email: false,
                customerType: false,
                title: false,
                fullName: false,
                address: false,
                mobile: false,
                password: false,
                confirmPassword: false
            };

            // Current step tracking
            let currentStep = 1;

            // DOM elements
            const step1Content = document.getElementById('step-1-content');
            const step2Content = document.getElementById('step-2-content');
            const step3Content = document.getElementById('step-3-content');
            const step2Element = document.getElementById('step-2');
            const step3Element = document.getElementById('step-3');
            const step2Text = document.getElementById('step-2-text');
            const step3Text = document.getElementById('step-3-text');
            const progressBar1 = document.getElementById('progress-bar-1');
            const progressBar2 = document.getElementById('progress-bar-2');
            const nextToStep2Button = document.getElementById('next-to-step-2');
            const nextToStep3Button = document.getElementById('next-to-step-3');
            const backToStep1Button = document.getElementById('back-to-step-1');
            const backToStep2Button = document.getElementById('back-to-step-2');
            const submitButton = document.getElementById('submitBtn');
            const togglePasswordButton = document.getElementById('togglePassword');
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eyeIcon');

            // Initialize event listeners
            document.addEventListener('DOMContentLoaded', function () {
                // Step navigation
                nextToStep2Button.addEventListener('click', goToStep2);
                nextToStep3Button.addEventListener('click', goToStep3);
                backToStep1Button.addEventListener('click', goToStep1);
                backToStep2Button.addEventListener('click', goToStep2);

                // Toggle password visibility
                togglePasswordButton.addEventListener('click', togglePasswordVisibility);

                // Customer type selection
                document.getElementById('customerType').addEventListener('change', function () {
                    isValidForm.customerType = this.value !== '';
                    updateStep1Button();
                });

                // Title selection
                document.getElementById('title').addEventListener('change', function () {
                    isValidForm.title = this.value !== '';
                    updateStep2Button();
                });

                // Terms agreement
                document.getElementById('termsAgreement').addEventListener('change', function () {
                    updateSubmitButton();
                });

                // Country code change
                document.getElementById('countryCode').addEventListener('change', function () {
                    validateMobile(document.getElementById('mobileNumber'));
                });

                // Animate elements on load
                setTimeout(() => {
                    document.querySelector('.card-gradient').style.opacity = '1';
                }, 100);
            });

            // Navigation functions
            function goToStep1() {
                currentStep = 1;
                step1Content.classList.remove('hidden');
                step2Content.classList.add('hidden');
                step3Content.classList.add('hidden');
                progressBar1.style.width = '0%';
                step2Element.classList.remove('bg-primary-600');
                step2Element.classList.add('bg-gray-700');
                step2Text.classList.remove('text-primary-400');
                step2Text.classList.add('text-gray-500');
            }

            function goToStep2() {
                if (!validateStep1()) return;

                currentStep = 2;
                step1Content.classList.add('hidden');
                step2Content.classList.remove('hidden');
                step3Content.classList.add('hidden');
                progressBar1.style.width = '100%';
                step2Element.classList.remove('bg-gray-700');
                step2Element.classList.add('bg-primary-600');
                step2Text.classList.remove('text-gray-500');
                step2Text.classList.add('text-primary-400');
                progressBar2.style.width = '0%';
                step3Element.classList.remove('bg-primary-600');
                step3Element.classList.add('bg-gray-700');
                step3Text.classList.remove('text-primary-400');
                step3Text.classList.add('text-gray-500');
            }

            function goToStep3() {
                if (!validateStep2()) return;

                currentStep = 3;
                step1Content.classList.add('hidden');
                step2Content.classList.add('hidden');
                step3Content.classList.remove('hidden');
                progressBar2.style.width = '100%';
                step3Element.classList.remove('bg-gray-700');
                step3Element.classList.add('bg-primary-600');
                step3Text.classList.remove('text-gray-500');
                step3Text.classList.add('text-primary-400');
            }

            // Validation functions
            function validateStep1() {
                validateConsumerNumber(document.getElementById('consumerNumber'));
                validateEmail(document.getElementById('email'));

                const customerType = document.getElementById('customerType');
                isValidForm.customerType = customerType.value !== '';

                return isValidForm.consumerNumber && isValidForm.email && isValidForm.customerType;
            }

            function validateStep2() {
                const title = document.getElementById('title');
                isValidForm.title = title.value !== '';

                validateName(document.getElementById('fullName'));
                validateAddress(document.getElementById('address'));
                validateMobile(document.getElementById('mobileNumber'));

                return isValidForm.title && isValidForm.fullName && isValidForm.address && isValidForm.mobile;
            }

            function updateStep1Button() {
                nextToStep2Button.disabled = !(isValidForm.consumerNumber && isValidForm.email && isValidForm.customerType);
            }

            function updateStep2Button() {
                nextToStep3Button.disabled = !(isValidForm.title && isValidForm.fullName && isValidForm.address && isValidForm.mobile);
            }

            function updateSubmitButton() {
                submitButton.disabled = !(isValidForm.password && isValidForm.confirmPassword && document.getElementById('termsAgreement').checked);
            }

            function showError(input, errorId, message, isValid) {
                const error = document.getElementById(errorId);
                input.classList.remove('border-green-500', 'border-red-500');
                input.classList.add(isValid ? 'border-green-500' : 'border-red-500');
                error.classList.toggle('hidden', isValid);
                error.textContent = message;

                if (!isValid) {
                    error.classList.add('shake');
                    setTimeout(() => error.classList.remove('shake'), 500);
                }
            }

            // Field validation functions
            function validateConsumerNumber(input) {
                const value = input.value;
                const isValid = /^\d{13}$/.test(value);
                isValidForm.consumerNumber = isValid;
                showError(input, "consumerNumberError", "Please enter a valid 13-digit ConsumerNumber.", isValid);
                updateStep1Button();
            }

            function validateEmail(input) {
                const value = input.value;
                const isValid = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value);
                isValidForm.email = isValid;
                showError(input, "emailError", "Please enter a valid email address.", isValid);
                updateStep1Button();
            }

            function validateName(input) {
                const value = input.value.trim();
                let message = "";
                let isValid = true;

                if (!/^[a-zA-Z\s]{2,50}$/.test(value)) {
                    if (!/^[a-zA-Z\s]*$/.test(value)) {
                        message = "Only letters and spaces allowed.";
                    } else if (value.length < 2 || value.length > 50) {
                        message = "Name must be 2-50 characters.";
                    }
                    isValid = false;
                }

                isValidForm.fullName = isValid;
                showError(input, "fullNameError", message, isValid);
                updateStep2Button();
            }

            function validateAddress(input) {
                const value = input.value.trim();
                const isValid = value.length >= 10 && value.length <= 200;
                isValidForm.address = isValid;
                showError(input, "addressError", "Address must be 10-200 characters.", isValid);
                updateStep2Button();
            }

            function validateMobile(input) {
                const value = input.value;
                const countryCode = document.getElementById("countryCode").value;
                let isValid = false;
                let message = "";

                if (countryCode === "+91") {
                    if (!/^[6-9]\d{9}$/.test(value)) {
                        if (!/^\d{10}$/.test(value)) {
                            message = "Must be 10 digits.";
                        } else {
                            message = "Indian mobile numbers must start with 6-9.";
                        }
                        isValid = false;
                    } else {
                        isValid = true;
                    }
                } else {
                    if (!/^\d{10}$/.test(value)) {
                        message = "Must be 10 digits.";
                        isValid = false;
                    } else {
                        isValid = true;
                    }
                }

                isValidForm.mobile = isValid;
                showError(input, "mobileError", message, isValid);
                updateStep2Button();
            }

            function validatePassword(input) {
                const value = input.value;
                let message = "";
                let isValid = true;
                let strength = 0;

                // Update password requirement indicators
                const hasLength = value.length >= 8;
                const hasLower = /[a-z]/.test(value);
                const hasUpper = /[A-Z]/.test(value);
                const hasNumber = /\d/.test(value);
                const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(value);

                document.getElementById('check-length').classList.toggle('text-green-500', hasLength);
                document.getElementById('check-length').classList.toggle('text-gray-500', !hasLength);
                document.getElementById('text-length').classList.toggle('text-green-500', hasLength);
                document.getElementById('text-length').classList.toggle('text-gray-500', !hasLength);

                document.getElementById('check-lowercase').classList.toggle('text-green-500', hasLower);
                document.getElementById('check-lowercase').classList.toggle('text-gray-500', !hasLower);
                document.getElementById('text-lowercase').classList.toggle('text-green-500', hasLower);
                document.getElementById('text-lowercase').classList.toggle('text-gray-500', !hasLower);

                document.getElementById('check-uppercase').classList.toggle('text-green-500', hasUpper);
                document.getElementById('check-uppercase').classList.toggle('text-gray-500', !hasUpper);
                document.getElementById('text-uppercase').classList.toggle('text-green-500', hasUpper);
                document.getElementById('text-uppercase').classList.toggle('text-gray-500', !hasUpper);

                document.getElementById('check-number').classList.toggle('text-green-500', hasNumber);
                document.getElementById('check-number').classList.toggle('text-gray-500', !hasNumber);
                document.getElementById('text-number').classList.toggle('text-green-500', hasNumber);
                document.getElementById('text-number').classList.toggle('text-gray-500', !hasNumber);

                document.getElementById('check-special').classList.toggle('text-green-500', hasSpecial);
                document.getElementById('check-special').classList.toggle('text-gray-500', !hasSpecial);
                document.getElementById('text-special').classList.toggle('text-green-500', hasSpecial);
                document.getElementById('text-special').classList.toggle('text-gray-500', !hasSpecial);

                // Calculate password strength
                if (hasLength) strength += 20;
                if (hasLower) strength += 20;
                if (hasUpper) strength += 20;
                if (hasNumber) strength += 20;
                if (hasSpecial) strength += 20;

                // Update strength indicator
                const strengthBar = document.getElementById('strengthBar');
                const strengthText = document.getElementById('strengthText');

                strengthBar.style.width = strength + '%';

                if (strength < 40) {
                    strengthBar.classList.remove('bg-yellow-500', 'bg-green-500');
                    strengthBar.classList.add('bg-red-500');
                    strengthText.textContent = 'Weak';
                    strengthText.classList.remove('text-yellow-500', 'text-green-500');
                    strengthText.classList.add('text-red-500');
                } else if (strength < 80) {
                    strengthBar.classList.remove('bg-red-500', 'bg-green-500');
                    strengthBar.classList.add('bg-yellow-500');
                    strengthText.textContent = 'Medium';
                    strengthText.classList.remove('text-red-500', 'text-green-500');
                    strengthText.classList.add('text-yellow-500');
                } else {
                    strengthBar.classList.remove('bg-red-500', 'bg-yellow-500');
                    strengthBar.classList.add('bg-green-500');
                    strengthText.textContent = 'Strong';
                    strengthText.classList.remove('text-red-500', 'text-yellow-500');
                    strengthText.classList.add('text-green-500');
                }

                // Validate password
                isValid = hasLength && hasLower && hasUpper && hasNumber && hasSpecial;
                if (!isValid) {
                    message = "Password doesn't meet all requirements.";
                }

                isValidForm.password = isValid;
                showError(input, "passwordError", message, isValid);
                validateConfirmPassword(document.getElementById("confirmPassword"));
                updateSubmitButton();
            }

            function validateConfirmPassword(input) {
                const password = document.getElementById("password").value;
                const value = input.value;
                const isValid = password === value && password !== "";
                isValidForm.confirmPassword = isValid;
                showError(input, "confirmPasswordError", "Passwords do not match.", isValid);
                updateSubmitButton();
            }

            function togglePasswordVisibility() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);

                // Update the eye icon
                if (type === 'text') {
                    eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />';
                } else {
                    eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />';
                }
            }

            function validateForm() {
                // Validate all steps before submission
                const isStep1Valid = validateStep1();
                const isStep2Valid = validateStep2();

                validatePassword(document.getElementById('password'));
                validateConfirmPassword(document.getElementById('confirmPassword'));

                const isStep3Valid = isValidForm.password && isValidForm.confirmPassword && document.getElementById('termsAgreement').checked;

                if (!isStep1Valid) {
                    goToStep1();
                    return false;
                }

                if (!isStep2Valid) {
                    goToStep2();
                    return false;
                }

                if (!isStep3Valid) {
                    goToStep3();
                    return false;
                }

                return true;
            }
        </script>
    </body>

    </html>