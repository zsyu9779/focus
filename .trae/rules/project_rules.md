# Project Rules for AI Code Agent

## General Guidelines
- Always follow best practices for code quality, security, and efficiency.
- Scan the entire project codebase before making changes to avoid duplicating existing functionality.

## Context Management Rules (Mandatory for Every Session)
To maintain continuity across sessions and devices, the agent MUST maintain a dynamic project memo file named `project_memo.json` in the project root. This file uses a JSON structure optimized for efficient parsing and updating by the agent. Prioritize machine efficiency over human readability—use compact, structured data without unnecessary text. Minimize all outputs to essential information only; avoid summaries or confirmations unless explicitly requested by the user.

### 1. Before Starting Any Work
- **Step 1: Check for Existence**. If `project_memo.json` does not exist, create it silently with the initial template (see below) as a valid JSON object. If it exists but is invalid JSON, repair it to the template structure and log the repair in "session_logs".
- **Step 2: Read and Parse**. Silently load and parse the JSON from `project_memo.json`. Use the parsed data to inform all decisions (e.g., reuse from "available_apis_tools", continue from "current_work_in_progress"). Do NOT output any summary or parsed data unless the user query explicitly asks for it (e.g., "summarize memo").
- **Step 3: Handle Specific Instructions**. If the user query matches patterns like "continue according to plan", "resume work", or "continue planned tasks" (case-insensitive), immediately proceed to action based on the JSON without any response text. For other queries, respond minimally.

### 2. During Work
- **Monitor Changes**. If any significant changes occur (e.g., completing a task, adding a new API, modifying plans, or encountering issues), silently update `project_memo.json` by loading the current JSON, modifying the relevant fields, and saving it back as valid JSON.
- **Avoid Redundancy**. Before implementing new features, query the "available_apis_tools" field in the JSON to check for existing functionality. If a match is found, reuse it and note the decision in the "session_logs" array (without outputting to user).

### 3. After Completing Work or at Session End
- **Generate/Update Memo**. Silently load the current JSON, then update it with:
  - Append to "session_logs" array: A new object with timestamp, summary, and changes.
  - Update other fields as needed (e.g., add to "completed_milestones" or "future_plans", move completed items from "current_work_in_progress").
  - Ensure the JSON remains valid and compact (no extra whitespace).
- **Commit Changes**. If using Git, silently commit the updated `project_memo.json` with a message like "Update project memo JSON after session". Do not output commit details unless requested.

### Initial Template for project_memo.json (Create if Missing)
{
  "project_overview": {
    "description": "A web app for task management",
    "tech_stack": ["React", "Node.js", "MongoDB"]
  },
  "completed_milestones": [],
  "available_apis_tools": {},
  "current_work_in_progress": [],
  "future_plans": [],
  "session_logs": []
}

