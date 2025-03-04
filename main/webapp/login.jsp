<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PowerPay - Login</title>
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

            .toast {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                padding: 1rem 2rem;
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                opacity: 0;
                transition: opacity 0.3s ease-in-out;
            }

            .toast.show {
                opacity: 1;
                animation: fadeInUp 0.5s ease-out;
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
                        <a href="register"
                            class="text-gray-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Register</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="flex items-center justify-center min-h-[calc(100vh-4rem)] px-4 py-12">
            <div class="w-full max-w-md opacity-0 animate-fadeInUp">
                <div class="card-gradient rounded-2xl shadow-2xl border border-gray-700 p-8 backdrop-blur-sm">
                    <div class="flex items-center justify-center mb-8">
                        <div class="h-16 w-16 rounded-full bg-primary-500/20 flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-primary-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
                            </svg>
                        </div>
                        <h2 class="ml-4 text-3xl font-bold text-white">Welcome Back</h2>
                    </div>

                    <form action="login" method="post" id="loginForm" class="space-y-6">
                        <div class="opacity-0 animate-fadeInUp delay-100">
                            <label for="customerId" class="block text-sm font-medium text-gray-300 mb-1">Customer
                                ID</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                </div>
                                <input type="text" id="customerId" name="customerId" required
                                    class="block w-full pl-10 pr-3 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                    placeholder="Enter your customer ID">
                            </div>
                        </div>

                        <div class="opacity-0 animate-fadeInUp delay-200">
                            <label for="password" class="block text-sm font-medium text-gray-300 mb-1">Password</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                    </svg>
                                </div>
                                <input type="password" id="password" name="password" required
                                    class="block w-full pl-10 pr-10 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white placeholder-gray-500 input-focus"
                                    placeholder="Enter your password">
                                <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                    <button type="button" id="togglePassword"
                                        class="text-gray-500 hover:text-gray-400 focus:outline-none">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                            viewBox="0 0 24 24" stroke="currentColor" id="eyeIcon">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="opacity-0 animate-fadeInUp delay-300">
                            <label for="loginType" class="block text-sm font-medium text-gray-300 mb-1">Login As</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                    </svg>
                                </div>
                                <select id="loginType" name="loginType" required
                                    class="block w-full pl-10 pr-10 py-3 bg-gray-800/50 border border-gray-700 rounded-lg text-white appearance-none input-focus">
                                    <option value="customer">Customer</option>
                                    <option value="admin">Administrator</option>
                                </select>
                                <div class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                    <svg class="h-5 w-5 text-gray-500" xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd"
                                            d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                            clip-rule="evenodd" />
                                    </svg>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between opacity-0 animate-fadeInUp delay-300">
                            <div class="flex items-center">
                                <input type="checkbox" id="remember" name="remember"
                                    class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-700 rounded bg-gray-800/50">
                                <label for="remember" class="ml-2 block text-sm text-gray-400">
                                    Remember me
                                </label>
                            </div>
                            <a href="#" class="text-sm text-primary-400 hover:text-primary-300">
                                Forgot password?
                            </a>
                        </div>

                        <div class="pt-2 opacity-0 animate-fadeInUp delay-300">
                            <button type="submit" id="loginBtn"
                                class="w-full px-6 py-3 bg-primary-600 text-white rounded-lg font-medium button-glow transition-all">
                                Sign In
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 inline-block ml-1"
                                    viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd"
                                        d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z"
                                        clip-rule="evenodd" />
                                </svg>
                            </button>
                        </div>
                    </form>

                    <div class="mt-8 text-center text-gray-400 opacity-0 animate-fadeInUp delay-300">
                        <p>Don't have an account? <a href="register"
                                class="text-primary-400 hover:text-primary-300">Create one now</a></p>
                    </div>
                </div>

                <!-- Features -->
                <div class="mt-8 grid grid-cols-3 gap-4 opacity-0 animate-fadeInUp delay-300">
                    <div class="flex flex-col items-center text-center">
                        <div class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mb-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                            </svg>
                        </div>
                        <span class="text-xs text-gray-400">Secure Login</span>
                    </div>
                    <div class="flex flex-col items-center text-center">
                        <div class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mb-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                            </svg>
                        </div>
                        <span class="text-xs text-gray-400">Data Protection</span>
                    </div>
                    <div class="flex flex-col items-center text-center">
                        <div class="h-10 w-10 rounded-full bg-primary-900/50 flex items-center justify-center mb-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M13 10V3L4 14h7v7l9-11h-7z" />
                            </svg>
                        </div>
                        <span class="text-xs text-gray-400">Fast Access</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Toast Notification -->
        <div id="toast" class="toast bg-red-900/90 border border-red-700 text-red-200 hidden"></div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Check for error message
                const error = '<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>';
                if (error && error !== "null") {
                    showToast(error);
                }

                // Toggle password visibility
                const togglePasswordButton = document.getElementById('togglePassword');
                const passwordInput = document.getElementById('password');
                const eyeIcon = document.getElementById('eyeIcon');

                togglePasswordButton.addEventListener('click', function () {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);

                    // Update the eye icon
                    if (type === 'text') {
                        eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />';
                    } else {
                        eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />';
                    }
                });

                // Handle form submission
                document.getElementById("loginForm").addEventListener("submit", function (e) {
                    const customerId = document.getElementById("customerId").value.trim();
                    const password = document.getElementById("password").value.trim();

                    if (!customerId || !password) {
                        e.preventDefault();
                        showToast("Please enter both customer ID and password");
                        return false;
                    }

                    // Add a subtle animation to the button
                    document.getElementById("loginBtn").classList.add('scale-95');
                    setTimeout(() => document.getElementById("loginBtn").classList.remove('scale-95'), 150);
                });

                // Animate elements on load
                setTimeout(() => {
                    document.querySelector('.animate-fadeInUp').style.opacity = '1';
                }, 100);
            });

            function showToast(message) {
                const toast = document.getElementById('toast');
                toast.textContent = message;
                toast.classList.remove('hidden');
                toast.classList.add('show');

                // Hide toast after 4 seconds
                setTimeout(() => {
                    toast.classList.remove('show');
                    setTimeout(() => toast.classList.add('hidden'), 300);
                }, 4000);
            }
        </script>
    </body>

    </html>