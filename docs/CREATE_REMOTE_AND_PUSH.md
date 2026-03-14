# Create GitHub Remote and Push FrankBoard

The repository is prepared locally. To create the remote and push:

## 1. Create the repository on GitHub

1. Go to [https://github.com/new](https://github.com/new)
2. **Repository name**: `FrankBoard`
3. **Description** (optional): `Modernization fork of Kanboard — VPS-first Docker, PostgreSQL`
4. Choose **Public** or **Private**
5. **Do not** initialize with README, .gitignore, or license (we already have these)
6. Click **Create repository**

## 2. Add the remote and push

Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username:

```bash
# Remove the placeholder remote if it was added with wrong username
git remote remove origin 2>nul

# Add your FrankBoard repo
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/FrankBoard.git

# Push
git push -u origin main
```

Example (if your username is `frankbryant`):

```bash
git remote add origin https://github.com/frankbryant/FrankBoard.git
git push -u origin main
```

## 3. Update deployment docs with your repo URL

After pushing, update `docs/deployment/vps-docker-staging.md` — replace `<frankboard-repo-url>` with your actual URL, e.g.:

```
git clone https://github.com/YOUR_GITHUB_USERNAME/FrankBoard.git frankboard
```

## Current state

- **upstream**: `https://github.com/kanboard/kanboard.git` (original Kanboard source)
- **origin**: Set to `https://github.com/frankbryant/FrankBoard.git` — update if your username differs
- **main**: Committed with Phase 1 FrankBoard foundation (VPS-first, Docker, PostgreSQL, docs)

## If push fails with "repository not found"

1. Confirm the repo exists at `https://github.com/YOUR_USERNAME/FrankBoard`
2. Verify you're authenticated: `git config credential.helper`
3. Update the remote URL: `git remote set-url origin https://github.com/YOUR_USERNAME/FrankBoard.git`
4. Try again: `git push -u origin main`
