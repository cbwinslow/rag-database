import '../styles/globals.css'
import type { Metadata } from 'next'
import Navigation from '../components/Navigation'

export const metadata: Metadata = {
  title: 'Database & Monitoring Dashboard',
  description: 'Real-time monitoring of database and monitoring services',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" data-theme="cupcake">
      <body className="font-sans">
        <div className="min-h-screen bg-base-100">
          <Navigation />
          <main>{children}</main>
        </div>
      </body>
    </html>
  )
}