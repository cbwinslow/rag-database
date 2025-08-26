'use client'

import './globals.css'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import Link from 'next/link'
import { usePathname } from 'next/navigation'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Database & Monitoring Dashboard',
  description: 'Real-time monitoring of database and monitoring services',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const pathname = usePathname()
  
  const navItems = [
    { name: 'Dashboard', path: '/' },
    { name: 'Status', path: '/status' }
  ]

  return (
    <html lang="en" data-theme="cupcake">
      <body className={inter.className}>
        <div className="min-h-screen bg-base-100">
          <nav className="bg-base-200 border-b border-base-300">
            <div className="container mx-auto px-4">
              <div className="flex items-center justify-between h-16">
                <div className="flex items-center">
                  <Link href="/" className="text-xl font-bold">
                    DB & Monitoring Dashboard
                  </Link>
                </div>
                <div className="flex space-x-4">
                  {navItems.map((item) => (
                    <Link
                      key={item.path}
                      href={item.path}
                      className={`px-3 py-2 rounded-md text-sm font-medium ${
                        pathname === item.path
                          ? 'bg-primary text-primary-content'
                          : 'text-base-content hover:bg-base-300'
                      }`}
                    >
                      {item.name}
                    </Link>
                  ))}
                </div>
              </div>
            </div>
          </nav>
          <main>{children}</main>
        </div>
      </body>
    </html>
  )
}