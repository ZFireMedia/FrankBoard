# FrankBoard VPS Context

**Canonical reference** for VPS deployment. Use these values in scripts, docs, and agent commands.

| Item | Value |
|------|-------|
| **Host** | frankboard-vps (SSH config) |
| **IP** | 66.179.208.122 |
| **User** | root |
| **Repo path** | `/root/frankboard` |
| **App URL** | http://66.179.208.122:8080 |

## Standard remote commands

```bash
# Deploy (from project root)
ssh frankboard-vps "cd /root/frankboard && git pull && ./scripts/deploy-wave1.sh"

# Quick status
ssh frankboard-vps "cd /root/frankboard && docker compose ps"

# Logs
ssh frankboard-vps "cd /root/frankboard && docker compose logs app --tail 50 --nostream"
```

## SSH config (local)

Ensure `~/.ssh/config` contains:

```
Host frankboard-vps
    HostName 66.179.208.122
    User root
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

For **Cursor Agent** (non-interactive): if the main key has a passphrase, use `~/.ssh/id_ed25519_frankboard` (no passphrase). See `docs/deployment/ssh-vps-setup.md` — Automation key.

## Agent helper script

```powershell
# From FrankBoard repo root
.\scripts\run-vps.ps1 -Command "cd /root/frankboard && docker compose ps"
.\scripts\run-vps.ps1 -DeployWave1
```

Requires BatchMode-compatible SSH (automation key or key in agent).
