# AI Agent Examples
# This file contains examples of AI agents using Pydantic AI

## Service Health Checker Agent

```python
from pydantic_ai import Agent, RunContext
from pydantic import BaseModel
from typing import List
import requests
import asyncio

class ServiceHealth(BaseModel):
    name: str
    status: str
    response_time: float
    error: str = None

class HealthReport(BaseModel):
    services: List[ServiceHealth]
    overall_status: str
    recommendations: List[str]

# Agent to check service health
health_checker = Agent(
    model='openai:gpt-4',
    result_type=HealthReport,
    system_prompt='''
    You are a system health monitoring agent. 
    Analyze the health status of services and provide recommendations.
    '''
)

async def check_service_health(service_name: str, url: str) -> ServiceHealth:
    try:
        start_time = asyncio.get_event_loop().time()
        response = await asyncio.get_event_loop().run_in_executor(
            None, requests.get, url, {"timeout": 5}
        )
        response_time = asyncio.get_event_loop().time() - start_time
        
        return ServiceHealth(
            name=service_name,
            status="healthy" if response.status_code == 200 else "unhealthy",
            response_time=response_time
        )
    except Exception as e:
        return ServiceHealth(
            name=service_name,
            status="unhealthy",
            response_time=0.0,
            error=str(e)
        )

async def generate_health_report():
    services = {
        "Prometheus": "http://localhost:9090/-/healthy",
        "Loki": "http://localhost:3100/ready",
        "OpenSearch": "http://localhost:9200/_cluster/health",
        "Neo4j": "http://localhost:7474",
        "LocalAI": "http://localhost:8080/models"
    }
    
    health_checks = []
    for name, url in services.items():
        health = await check_service_health(name, url)
        health_checks.append(health)
    
    # Generate report using AI agent
    result = await health_checker.run(str(health_checks))
    return result.data

# Usage
# report = asyncio.run(generate_health_report())
# print(report.json(indent=2))
```

## Repair Action Agent

```python
from pydantic_ai import Agent
from pydantic import BaseModel
from typing import List

class RepairAction(BaseModel):
    service: str
    action: str
    priority: int
    reason: str

class RepairPlan(BaseModel):
    actions: List[RepairAction]
    estimated_time: int  # in minutes
    risk_level: str  # low, medium, high

# Agent to generate repair actions
repair_agent = Agent(
    model='openai:gpt-4',
    result_type=RepairPlan,
    system_prompt='''
    You are a system repair agent. 
    Based on service health reports, generate appropriate repair actions.
    Prioritize actions based on impact and urgency.
    '''
)

async def generate_repair_plan(health_report: HealthReport):
    result = await repair_agent.run(health_report.json())
    return result.data

# Usage
# plan = asyncio.run(generate_repair_plan(health_report))
# print(plan.json(indent=2))
```

## Knowledge Management Agent

```python
from pydantic_ai import Agent
from pydantic import BaseModel
from typing import List

class KnowledgeItem(BaseModel):
    topic: str
    content: str
    source: str
    confidence: float

class KnowledgeBase(BaseModel):
    items: List[KnowledgeItem]
    last_updated: str

# Agent to manage knowledge
knowledge_agent = Agent(
    model='openai:gpt-4',
    result_type=KnowledgeBase,
    system_prompt='''
    You are a knowledge management agent.
    Organize information from various sources into a structured knowledge base.
    Ensure high quality and accuracy of information.
    '''
)

async def update_knowledge_base(sources: List[str]):
    # In a real implementation, this would fetch information from sources
    result = await knowledge_agent.run(str(sources))
    return result.data

# Usage
# sources = ["system_logs", "user_feedback", "incident_reports"]
# knowledge = asyncio.run(update_knowledge_base(sources))
# print(knowledge.json(indent=2))
```

## Deployment Agent

```python
from pydantic_ai import Agent
from pydantic import BaseModel
from typing import List

class DeploymentTask(BaseModel):
    service: str
    action: str  # deploy, update, rollback
    version: str
    configuration: dict

class DeploymentPlan(BaseModel):
    tasks: List[DeploymentTask]
    execution_order: List[int]
    rollback_plan: List[DeploymentTask]

# Agent to plan deployments
deployment_agent = Agent(
    model='openai:gpt-4',
    result_type=DeploymentPlan,
    system_prompt='''
    You are a deployment planning agent.
    Create deployment plans that minimize downtime and risk.
    Ensure proper rollback procedures are in place.
    '''
)

async def create_deployment_plan(request: dict):
    result = await deployment_agent.run(str(request))
    return result.data

# Usage
# request = {"service": "my-app", "action": "update", "version": "2.0"}
# plan = asyncio.run(create_deployment_plan(request))
# print(plan.json(indent=2))
```