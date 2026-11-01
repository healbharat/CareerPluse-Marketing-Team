# Assign GitHub accounts to CareerPluse marketing team

The GitHub repository is public, but GitHub **write collaborator access** is required for reliable issue assignment. As of the initial check, all four named users had read permission and test assignment attempts did not persist.

## Team GitHub usernames

| Name | Username | Existing issue label | Expected tasks |
|---|---|---|---:|
| Pragati | `PragatiC-code` | `owner:pragati` | 15 |
| Rupam | `Rupamrocks` | `owner:rupam` | 15 |
| Mannu Sharma | `mannusharma8397` | `owner:mannu` | 15 |
| Shrushti | `srushtip223` | `owner:shrushti` | 15 |

## Run one time on founder's Windows computer

1. Sign into **healbharat** with GitHub CLI: `gh auth login`. Your credentials remain on your computer; never post tokens in GitHub Issues.
2. Download or clone this repository, then open Windows PowerShell in the repo root.
3. Run: `powershell -ExecutionPolicy Bypass -File .\scripts\invite-and-assign.ps1`
4. The script requests four **write** collaborator invitations. Each student must accept via GitHub invitation (email/notifications/repository invitation).
5. Run the **same script a second time** after invitation acceptance. It checks access and assigns the matching 15 Issues to each student. The script can be rerun without duplicating assignments.
6. Verify each student has 15 Issues in the repository **Issues** tab; examine the **Assignees** field. Labels alone do not grant access or constitute actual assignments.

If the script cannot send an invitation, go to repository **Settings → Collaborators and teams → Add people**, invite the exact usernames with write access, and run the same script after acceptance.

**Access note:** This is a PUBLIC task tracker. Keep student/customer personal details, leads, payment receipts and business contact records only in a private company-approved tracker. Do not put private data in Issue comments.

**Campaign outcome:** 15 verified net paid/onboarded CareerPluse students and ≥1 business approached by Day 15 are *targets*, not recorded results.
