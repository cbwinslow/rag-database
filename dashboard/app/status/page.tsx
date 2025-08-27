export default function StatusPage() {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">System Status</h1>
      
      <div className="bg-base-200 rounded-box p-6 mb-6">
        <div className="flex items-center">
          <div className="badge badge-success badge-lg mr-3"></div>
          <h2 className="text-2xl font-semibold">All Systems Operational</h2>
        </div>
        <p className="mt-2 text-base-content/70">All services are running normally</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div className="card bg-base-100 shadow-xl">
          <div className="card-body">
            <h3 className="card-title">
              <div className="badge badge-success badge-sm mr-2"></div>
              Databases
            </h3>
            <ul className="list-disc pl-5 mt-2 space-y-1">
              <li>PostgreSQL - Operational</li>
              <li>Supabase - Operational</li>
              <li>Weaviate - Operational</li>
              <li>Qdrant - Operational</li>
              <li>InfluxDB - Operational</li>
              <li>ClickHouse - Operational</li>
              <li>Redis - Operational</li>
              <li>MongoDB - Operational</li>
            </ul>
          </div>
        </div>
        
        <div className="card bg-base-100 shadow-xl">
          <div className="card-body">
            <h3 className="card-title">
              <div className="badge badge-success badge-sm mr-2"></div>
              Monitoring
            </h3>
            <ul className="list-disc pl-5 mt-2 space-y-1">
              <li>Prometheus - Operational</li>
              <li>Grafana - Operational</li>
              <li>OpenSearch - Operational</li>
              <li>Loki - Operational</li>
            </ul>
          </div>
        </div>
        
        <div className="card bg-base-100 shadow-xl">
          <div className="card-body">
            <h3 className="card-title">
              <div className="badge badge-success badge-sm mr-2"></div>
              System
            </h3>
            <ul className="list-disc pl-5 mt-2 space-y-1">
              <li>CPU Usage - 25%</li>
              <li>Memory Usage - 45%</li>
              <li>Disk Usage - 30%</li>
              <li>Network - Operational</li>
            </ul>
          </div>
        </div>
      </div>
      
      <div className="mt-8 bg-base-200 rounded-box p-6">
        <h2 className="text-2xl font-semibold mb-4">Recent Incidents</h2>
        <div className="timeline timeline-vertical">
          <div className="timeline-start mb-2">Now</div>
          <div className="timeline-middle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className="w-5 h-5 text-success"><path fillRule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clipRule="evenodd" /></svg>
          </div>
          <div className="timeline-end timeline-box">All systems operational</div>
          <hr className="bg-success"/>
          <div className="timeline-start mb-2">2 hours ago</div>
          <div className="timeline-middle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className="w-5 h-5 text-success"><path fillRule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clipRule="evenodd" /></svg>
          </div>
          <div className="timeline-end timeline-box">System restart completed</div>
          <hr/>
          <div className="timeline-start">1 day ago</div>
          <div className="timeline-middle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className="w-5 h-5"><path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clipRule="evenodd" /></svg>
          </div>
          <div className="timeline-end timeline-box">Scheduled maintenance</div>
        </div>
      </div>
    </div>
  )
}