# How the app works

This diagram shows how the different parts of the application connect together.
```mermaid
flowchart LR
    A[CSV Reader] --> B[Core Logic]
    B --> C[API Client]
    B --> D[CSV Writer]
    B --> E[Summary Generator]
```