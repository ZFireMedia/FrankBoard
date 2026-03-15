# SSH Setup for FrankBoard VPS

Configure SSH key access so Cursor Agent can run deploy commands on the staging VPS (66.179.208.122).

---

## 1. Your public key

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOogwlrugjExbFsa/U0XfTb15SWK22FTXVNVO2dGzDcA bryant.harper.im@gmail.com
```

---

## 2. Add the key to the VPS

You need **one** of these methods (you need some way to get on the VPS first).

### Option A: Copy via password login

If the VPS allows password auth, from your machine:

```powershell
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh root@66.179.208.122 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
```

Enter your password when prompted. Replace `root` with your SSH username if different (e.g. `ubuntu`, `admin`).

### Option B: Manual (web console or existing SSH)

1. Log in to the VPS (web console, or SSH with password).
2. Run:
   ```bash
   mkdir -p ~/.ssh
   echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOogwlrugjExbFsa/U0XfTb15SWK22FTXVNVO2dGzDcA bryant.harper.im@gmail.com' >> ~/.ssh/authorized_keys
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/authorized_keys
   ```

### Option C: Provider dashboard

Many VPS providers (DigitalOcean, Linode, Vultr, etc.) have "Add SSH Key" in the server or account settings. Paste the public key there before or after creating the server.

---

## 3. Add SSH config

Append this to `C:\Users\bryan\.ssh\config` (create the file if it doesn't exist):

```
Host frankboard-vps
    HostName 66.179.208.122
    User root
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

Change `User root` to your SSH username if different.

---

## 4. Test

```powershell
ssh -o ConnectTimeout=10 frankboard-vps "echo OK"
```

If you see `OK`, SSH is set up. Cursor Agent can then run:

```bash
ssh frankboard-vps "cd /root/frankboard && git pull && ./scripts/deploy-wave1.sh"
```

**Repo path**: `/root/frankboard` (see `docs/deployment/vps-context.md`)

---

## Troubleshooting

| Issue | Fix |
|------|-----|
| Permission denied (publickey) | Key not on VPS yet — use Option A or B above |
| Connection refused | Check VPS is running; check SSH port (default 22) |
| Wrong username | Update `User` in SSH config (root, ubuntu, admin, etc.) |
| Host key verification | Run `ssh frankboard-vps` once manually, accept the host key |
| **SSH hangs from Cursor Agent** | Key may have a passphrase. Use an automation key (no passphrase) — see below |

### Automation key (for Cursor Agent / non-interactive SSH)

If SSH works from your terminal but hangs when the agent runs it, your key likely has a passphrase and SSH waits for input. Use a dedicated automation key:

1. **Generate key** (no passphrase):
   ```powershell
   ssh-keygen -t ed25519 -f $env:USERPROFILE\.ssh\id_ed25519_frankboard -N ""
   ```

2. **Add public key to VPS** (one-time, use your password):
   ```powershell
   Get-Content $env:USERPROFILE\.ssh\id_ed25519_frankboard.pub | ssh root@66.179.208.122 "cat >> ~/.ssh/authorized_keys"
   ```

3. **Update SSH config** — change `IdentityFile` for frankboard-vps to the new key:
   ```
   IdentityFile ~/.ssh/id_ed25519_frankboard
   ```

4. **Test** (should return instantly with no prompts):
   ```powershell
   ssh -o BatchMode=yes -o ConnectTimeout=5 frankboard-vps "echo OK"
   ```

`BatchMode=yes` prevents any prompts; use it to verify non-interactive SSH works.
