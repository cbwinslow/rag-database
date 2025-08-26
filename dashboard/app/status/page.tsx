---
title: System Status
---

<div class="container mx-auto px-4 py-8">
  <h1 class="text-3xl font-bold mb-6">System Status</h1>
  
  <div class="bg-base-200 rounded-box p-6 mb-6">
    <div class="flex items-center">
      <div class="badge badge-success badge-lg mr-3"></div>
      <h2 class="text-2xl font-semibold">All Systems Operational</h2>
    </div>
    <p class="mt-2 text-base-content/70">All services are running normally</p>
  </div>
  
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <div class="card bg-base-100 shadow-xl">
      <div class="card-body">
        <h3 class="card-title">
          <div class="badge badge-success badge-sm mr-2"></div>
          Databases
        </h3>
        <ul class="list-disc pl-5 mt-2 space-y-1">
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
    
    <div class="card bg-base-100 shadow-xl">
      <div class="card-body">
        <h3 class="card-title">
          <div class="badge badge-success badge-sm mr-2"></div>
          Monitoring
        </h3>
        <ul class="list-disc pl-5 mt-2 space-y-1">
          <li>Prometheus - Operational</li>
          <li>Grafana - Operational</li>
          <li>OpenSearch - Operational</li>
          <li>Loki - Operational</li>
        </ul>
      </div>
    </div>
    
    <div class="card bg-base-100 shadow-xl">
      <div class="card-body">
        <h3 class="card-title">
          <div class="badge badge-success badge-sm mr-2"></div>
          System
        </h3>
        <ul class="list-disc pl-5 mt-2 space-y-1">
          <li>CPU Usage - 25%</li>
          <li>Memory Usage - 45%</li>
          <li>Disk Usage - 30%</li>
          <li>Network - Operational</li>
        </ul>
      </div>
    </div>
  </div>
  
  <div class="mt-8 bg-base-200 rounded-box p-6">
    <h2 class="text-2xl font-semibold mb-4">Recent Incidents</h2>
    <div class="timeline timeline-vertical">
      <div class="timeline-start mb-2">Now</div>
      <div class="timeline-middle">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 text-success"><path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" /></svg>
      </div>
      <div class="timeline-end timeline-box">All systems operational</div>
      <hr class="bg-success"/>
      <div class="timeline-start mb-2">2 hours ago</div>
      <div class="timeline-middle">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 text-success"><path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" /></svg>
      </div>
      <div class="timeline-end timeline-box">System restart completed</div>
      <hr/>
      <div class="timeline-start">1 day ago</div>
      <div class="timeline-middle">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clip-rule="evenodd" /></svg>
      </div>
      <div class="timeline-end timeline-box">Scheduled maintenance</div>
    </div>
  </div>
</div>