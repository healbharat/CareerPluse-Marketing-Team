# Create and Populate GitHub Repo on Windows (fixed, safe to retry)

1. Extract the entire ZIP to any folder, e.g. `Downloads\CareerPluse-Marketing-Team`.
2. Install `Git for Windows` and **GitHub CLI** if they are not installed (`git --version` and `gh --version` should work).
3. Open **PowerShell in the extracted folder**, run `gh auth login` and sign into the **GitHub account that should own the public repo**. Only authenticate via the official GitHub workflow; never paste tokens into tasks.
4. Alternatively double-click `START_HERE.bat` to authenticate and run the setup. Read `scripts/setup-github.ps1` so you know exactly what it does (it creates a **PUBLIC** repo and 60 public Issues). When ready run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup-github.ps1
```

5. Script creates the public repo `github.com/<your-gh-username>/CareerPluse-Marketing-Team`, pushes documentation, creates labels and imports 60 tasks. If importing fails midway, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\import-issues.ps1
```

The import script is idempotent by task title and skips pre-existing tasks.

## After setup

- Verify repository **Settings** show **Public**.
- Verify **Issues** list has **60 tasks** (plus no incidental setup issues).
- Invite Pragati, Rupam, Mannu Sharma and Shrushti via their **exact GitHub usernames**, then optionally assign every issue. The names are in Issue titles and labels already, but account IDs cannot be guessed.
- Ask each person to read README and their first issue; daily comments and Founder review are documented under `docs/WORKFLOW_AND_REPORTING.md`.
- Never upload spreadsheets of student names/contact details or sensitive reports in this public repo.

**Note:** This setup must run on a computer signed into GitHub. Merely downloading a ZIP does not create a live online repository.

## Fix for the earlier PowerShell GraphQL 404

The earlier script stopped when `gh repo view` queried a repository that had not been created yet. This version detects an expected 404 without raising a terminating PowerShell error, then creates the PUBLIC repository and imports the 60 Issues. It also supports safe retry if creation worked but import was interrupted. Extract this **new ZIP into a new folder** instead of clicking the old ZIP copy. Double-click `START_HERE.bat`. Do not upload private student data to public GitHub Issues.
