# NixOS Configuration

Meine NixOS-Systemkonfiguration mit Flakes.

## Voraussetzungen

- SSH-Key muss bereits auf dem User eingerichtet und in GitHub hinterlegt sein
- Der SSH-Key sollte in `~/.ssh/` liegen (z.B. `id_ed25519` oder `id_rsa`)

## Installation (Live-System)

### 1. Repository in temporäres Verzeichnis klonen

Auf dem Live-System (vor der Installation):

```bash
# In ein temporäres Verzeichnis klonen
cd /tmp
git clone git@github.com:Memurame/nixos.git
cd nixos
```

### 2. Nach /mnt kopieren

```bash
sudo cp -r . /mnt/etc/nixos/
```

### 3. Hardware-Konfiguration generieren

```bash
# Hardware-Konfiguration generieren
sudo nixos-generate-config --root /mnt
```

### 4. System installieren

```bash
# NixOS installieren
sudo nixos-install --root /mnt--flake
```

Danach System rebooten:
```bash
sudo reboot
```

### 5. SSH-Key für root einrichten (im installierten System)

**Nach dem ersten Booten ins installierte System:**

```bash
# SSH-Verzeichnis für root erstellen
sudo mkdir -p /root/.ssh

# Symlinks erstellen (Pfad anpassen, falls dein Key anders heisst!)
sudo ln -s /home/manfred/.ssh/id_ed25519 /root/.ssh/id_ed25519
sudo ln -s /home/manfred/.ssh/id_ed25519.pub /root/.ssh/id_ed25519.pub

# Berechtigungen setzen
sudo chmod 700 /root/.ssh
sudo chmod 600 /root/.ssh/id_ed25519
sudo chmod 644 /root/.ssh/id_ed25519.pub

# known_hosts verlinken
sudo ln -s /home/manfred/.ssh/known_hosts /root/.ssh/known_hosts
```

**Wichtig:** Passe den Pfad `/home/manfred/.ssh/id_ed25519` an deinen tatsächlichen Key-Namen an!

**Prüfen:**

```bash
sudo ssh -T git@github.com
```

Sollte antworten:
```
Hi Memurame! You've successfully authenticated, but GitHub does not provide shell access.
```

## System rebuilden (nach Installation)

```bash
cd /etc/nixos
sudo nixos-rebuild switch --flake .
```

##Tägliche Arbeit

### Änderungen committen und pushen

```bash
cd /etc/nixos

# Änderungen committen
sudo git add .
sudo git commit -m "Beschreibung der Änderung"

# Pushen
sudo git push
```

### Updates von anderen Maschinen holen

```bash
cd /etc/nixos
sudo git pull
sudo nixos-rebuild switch --flake .
```

---

## Wichtige Befehle

| Befehl | Beschreibung |
|--------|--------------|
| `sudo nixos-rebuild switch --flake .` | System rebuilden |
| `nix flake update` | Flake-Inputs aktualisieren |
| `sudo git status` | Git-Status anzeigen |
| `sudo git add .` | Alle Änderungen stagen |
| `sudo git commit -m "..."` | Committen |
| `sudo git push` | Pushen |
| `sudo git pull` | Updates holen |

---

## Struktur

```
/etc/nixos/
├── configuration.nix      # Hauptkonfiguration
├── hardware-configuration.nix  # Hardware-spezifisch (wird NICHT ins Git commitet)
├── flake.nix              # Flake-Definition
├── flake.lock             # Lock-File (wird commitet für Reproduzierbarkeit)
├── .gitignore             # Ignoriert hardware-configuration.nix
├── .git/                  # Git-Repository
└── README.md              # Diese Datei
```

---

## Hinweise

- **`flake.lock` immer commiten** – sorgt für reproduzierbare Builds
- **`hardware-configuration.nix` NICHT commiten** – ist maschinenspezifisch (in `.gitignore`)
- **SSH-Key für root einrichten** – sonst funktioniert `sudo git push` nicht

---

