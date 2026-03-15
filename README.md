# 🔍 AI Deep Research Agent (n8n + Apify + OpenAI o3)

> An autonomous AI research agent that recursively searches the web, follows leads, synthesizes information, and produces comprehensive research reports — like having a research analyst available 24/7.

[![n8n](https://img.shields.io/badge/n8n-workflow-orange)](https://n8n.io)
[![OpenAI](https://img.shields.io/badge/OpenAI-o3-green)](https://openai.com)
[![Apify](https://img.shields.io/badge/Apify-Web%20Scraping-blue)](https://apify.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 📌 What It Does

This workflow implements an **autonomous research loop**. You give it a topic, set the depth and breadth parameters, and it:

1. Searches the web for relevant information
2. Reads and extracts key learnings from each page
3. Generates follow-up questions based on what it learns
4. Recursively searches for answers to those questions
5. Synthesizes everything into a structured research report

Think of it as GPT-powered deep research — like Perplexity Pro but running on your own infrastructure.

---

## 🏗️ Architecture

```
User Input (Topic + Depth + Breadth)
              │
              ▼
       Set Research Variables
              │
              ▼
    ┌─────────────────────┐
    │    RESEARCH LOOP     │
    │                      │
    │  1. Generate Queries  │
    │  2. Web Search (Apify)│
    │  3. Scrape Content    │
    │  4. Extract Learnings │
    │  5. Generate Follow-up│
    │     Questions         │
    └─────────┬────────────┘
              │
         Depth > 0?
          YES │              NO
              │               │
              ▼               ▼
          Recurse         Synthesize
                          Final Report
                              │
                              ▼
                     Save to Notion / Email
```

---

## ✨ Features

- **Recursive Research** — Automatically follows up on discovered leads (configurable depth)
- **Breadth Control** — Configure how many parallel search paths to explore
- **OpenAI o3 Powered** — Uses the most advanced reasoning model for analysis
- **Structured Output** — Returns JSON with learnings and follow-up questions
- **Web Scraping** — Uses Apify for reliable, anti-bot-resistant scraping
- **Report Generation** — Synthesizes findings into a coherent report
- **Configurable** — Adjust depth (1-5) and breadth (2-10) per research task

---

## 🛠️ Tech Stack

| Component | Technology |
|-----------|-----------|
| Automation Engine | n8n |
| AI Reasoning | OpenAI o3 |
| Web Scraping | Apify Web Scraper |
| Output Parser | n8n Structured Output Parser |
| Report Storage | Notion / Google Docs |

---

## ⚙️ Parameters

| Parameter | Description | Recommended Range |
|-----------|-------------|-------------------|
| `depth` | How many recursive research levels | 1–5 (default: 2) |
| `breadth` | How many search queries per level | 2–10 (default: 4) |

> **⚠️ Cost Warning:** Higher depth/breadth = more OpenAI o3 API calls. Start with depth=1, breadth=2 for testing.

---

## 📋 Prerequisites

- n8n instance
- [OpenAI API Key](https://platform.openai.com) (with o3 access)
- [Apify Account](https://apify.com) (free tier available)
- Optional: Notion API key for saving reports

---

## 🚀 Setup Guide

### Step 1 — Import Workflow
Import `workflow.json` into n8n.

### Step 2 — Configure Apify
1. Sign up at [apify.com](https://apify.com)
2. Go to Settings → Integrations → API → Copy your API token
3. Add Apify credentials in n8n

### Step 3 — Configure OpenAI
1. Get your API key from [platform.openai.com](https://platform.openai.com)
2. Ensure you have access to the `o3` model (requires Tier 3+ or manual request)
3. Add OpenAI credentials in n8n

**Alternative models if you don't have o3 access:**
- `gpt-4o` — Very good, cheaper
- `gpt-4o-mini` — Cheaper, slightly less thorough

### Step 4 — Test Research
1. Activate the workflow
2. Open the n8n form
3. Enter a research topic (e.g., "Latest developments in RAG systems for production")
4. Set depth=1, breadth=3
5. Run and wait ~2-3 minutes for results

---

## 📊 Example Output

**Input:** "What are the best practices for deploying LLMs in production in 2025?"

**Output:**
```json
{
  "topic": "LLM production deployment best practices 2025",
  "depth_reached": 2,
  "total_sources": 12,
  "learnings": [
    "Quantization (GGUF, AWQ) reduces model size by 4-8x with <5% quality loss",
    "vLLM with PagedAttention achieves 24x higher throughput than naive serving",
    "Model caching strategies can reduce costs by 60-80% for repetitive queries",
    "RAG systems outperform fine-tuning for knowledge that changes frequently"
  ],
  "report": "## LLM Production Deployment Best Practices\n\n..."
}
```

---

## 🎯 Use Cases

| Use Case | Example Query |
|----------|--------------|
| Competitor Research | "What features does [Competitor] offer that we don't?" |
| Market Analysis | "State of the AI automation market in 2025" |
| Technical Research | "Best vector databases for production RAG systems" |
| Content Research | "Key trends in [industry] for content creation" |
| Due Diligence | "Background on [company name] recent developments" |

---

## 📁 Project Structure

```
ai-deep-research-agent/
├── workflow.json              # Main research agent workflow
├── examples/
│   ├── sample_output.json     # Example research output
│   └── test_queries.md        # Good test queries to try
└── README.md
```

---

## 💡 Tips for Best Results

1. **Be specific** — "Best practices for RAG in production 2025" > "AI stuff"
2. **Start shallow** — Use depth=1 first to estimate costs before going deeper
3. **Use breadth for wide topics** — Breadth=6-8 for broad market research
4. **Use depth for deep topics** — Depth=3-4 for technical deep dives
5. **Save outputs** — Connect Notion or Google Docs to never lose research

---

## 📄 License

MIT License

---

## 🔗 Related Projects

- [WhatsApp AI RAG Chatbot](../1-ai-whatsapp-rag-chatbot)
- [AI Email Autoresponder](../4-ai-email-autoresponder)
