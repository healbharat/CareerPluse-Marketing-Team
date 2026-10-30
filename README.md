# CareerPluse · 15-Day Marketing Execution Board

**Public GitHub task tracker** for [CareerPluse.in](https://careerpluse.in). This repository contains **60 individual GitHub Issue tasks: 4 named people × 15 days**, plus SOPs, reporting templates and import scripts. It intentionally contains **no student/customer data**.

> **Team note:** The current names provided are **4 people**, not 5. Pragati holds two responsibilities: team leadership **and** content/social marketing. We have not invented a fifth member. Founder is the approver.

## Team and ownership

| Person | Fixed role | Owner issue label |
|---|---|---|
| **Pragati** | Marketing Team Leader **and** Social Media & Content Marketing Executive | `owner:pragati` |
| **Rupam** | College Outreach & Partnership Executive | `owner:rupam` |
| **Mannu Sharma** | Student Outreach & Community Executive | `owner:mannu` |
| **Shrushti** | Product Demo, Registration & Onboarding Executive | `owner:shrushti` |
| **Founder** | Approvals, priorities, high-value meetings, final issue closure | N/A |

## Start here (students)

1. Open **Issues** at `https://github.com/OWNER/CareerPluse-Marketing-Team/issues` (replace OWNER with repository owner). Click a task with your name or filter `owner:yourname`.
2. Read **Day 01** first; complete dependencies before Day 03 promotions. **Day means working day**; no dates are presumed.
3. Move issue progress by posting an update comment. Tick each action when finished. Never mark not-yet-done as done.
4. **At end of each workday (suggested 7:00 PM IST)** comment using the report format in your Issue; raw leads and private screenshots go **only in private CRM**, not GitHub.
5. Mark issue `Ready for Review` in comment. Pragati verifies completeness; founder approves and closes it. **Only approved/closed tasks count as completed**.
6. If blocked, write `STATUS: Blocked`, name blocker and what help is needed. Do not hide zero results.

**Founder:** review the daily summaries by suggested **7:30 PM IST**, approve pricing/claims, remove blockers, audit day 5/10/15 funnel.

## Goals (planning targets, not guarantees)

- **Primary:** **10+ verified connected students in the first 15 working days.** Count only genuine interest + completed registration + account access + completed onboarding, all evidenced in private product records.
- Approximate funnel planning assumptions from prior playbook: **120–150** directly contacted relevant students (across sources), **15–20** demo/session attendees or walkthroughs, and **12–18** registration attempts. Review with actual results after day 5; these are not forecasts.
- Rupam: ~5 researched college prospects and up to 3 personalised contacts on active outreach days.
- Mannu: up to 10 personalised, permission-based contacts on active outreach days; quality beats volume.
- Pragati: ~3–5 approved quality posts/Reels weekly, daily leadership and reporting.
- Shrushti: ~2–3 demos **when scheduled**; 100% verification for claimed onboarding counts.

## Project files

| File | Use |
|---|---|
| [`docs/ROLES_AND_TARGETS.md`](docs/ROLES_AND_TARGETS.md) | Fixed role contract and KPIs |
| [`docs/15_DAY_TASK_MATRIX.md`](docs/15_DAY_TASK_MATRIX.md) | All daily work at a glance |
| [`docs/WORKFLOW_AND_REPORTING.md`](docs/WORKFLOW_AND_REPORTING.md) | GitHub issue process and deadlines |
| [`docs/DAILY_REPORT_TEMPLATE.md`](docs/DAILY_REPORT_TEMPLATE.md) | Reusable daily comment format |
| [`docs/FOUNDER_REVIEW_AND_KPIS.md`](docs/FOUNDER_REVIEW_AND_KPIS.md) | How to measure and audit conversions |
| [`docs/APPROVED_CLAIMS_AND_PRIVACY.md`](docs/APPROVED_CLAIMS_AND_PRIVACY.md) | Marketing compliance and privacy |
| [`issues.json`](issues.json) | Source of truth for 60 detailed tasks, used by import script |
| [`scripts/setup-github.ps1`](scripts/setup-github.ps1) | **One-time public repo setup** with GitHub CLI on Windows |
| [`scripts/import-issues.ps1`](scripts/import-issues.ps1) | Idempotent GitHub Issue import (if setup interrupted) |

## Important security boundary

A **public** repo is the right place for responsibilities, safe work links, aggregate KPI summaries and review comments. A **private** approved tracker is required for contact details, names of prospects, student account status and proof of registrations. Never upload lead lists here.

## GitHub usernames are not yet known

The task **owner name and label** are set in every Issue. Actual GitHub `assignee` accounts are **not assigned** because only personal names were supplied. After students share GitHub usernames, Founder can invite them as collaborators in **Settings → Collaborators and teams** and assign relevant issues. Never assume an identity based on someone’s name.

## Source and scope

Adapted from the supplied *Heal Bharat Services & CareerPluse — 15-Day Marketing Execution Plan* and *Heal Bharat Services — Marketing Team Responsibilities & Work Plan*. Both source PDFs combined CareerPluse and business-service marketing. **This repo covers CareerPluse only.** Concrete daily scheduling and owner split are newly designed operating recommendations, not claims already achieved.


## NEW: 15 paid students + 1 business approach (15 working days)

**Updated outcome target:** **15 unique net paid and successfully onboarded CareerPluse students** by Day 15, plus **at least one genuine business prospect approached** for a verified Heal Bharat Services offering. These are *targets, not recorded achievements*. This replaces the previous 10+ free/connected-student goal as the primary success metric. Do not count unpaid signups, pending/failed/refunded payments or a mere verbal business lead as a win. Pricing/trial terms must be founder-verified; never presume ₹999 or a free trial is live.

**Read the full detailed execution and reporting plan:** [Paid Acquisition & Business Outreach](docs/PAID_ACQUISITION_AND_BUSINESS_OUTREACH.md). The 60 existing GitHub Issues each contain a paid/business conversion add-on. At Day 5/10/15 Founder reviews actual numbers and blocker reports. **No student/transaction/prospect identities in this public repo.**
