#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
"linux")

  DOTFILES="$HOME/.dotfiles/locale"
  SRC_NUMERIC="$DOTFILES/ruud_numeric.src"
  SRC_MONETARY="$DOTFILES/ruud_monetary.src"

  LOCALE_DIR="/usr/share/i18n/locales"
  BACKUP_DIR="/var/backups/locale-bootstrap-$(date +%Y%m%d%H%M%S)"
  INST_NUMERIC="$LOCALE_DIR/ruud_numeric"
  INST_MONETARY="$LOCALE_DIR/ruud_monetary"

  # Locale names (these become usable LANG/LC_* values)
  LOCALE_NUMERIC_NAME="en_US.RuudNumeric"
  LOCALE_MONETARY_NAME="en_US.RuudMonetary"

  # ---- Sanity checks ----
  for f in "$SRC_NUMERIC" "$SRC_MONETARY"; do
    if [[ ! -f "$f" ]]; then
      echo "ERROR: $DOTFILES/lc_numeric not found"
      exit 1
    fi
  done
  # ---- Ensure localedef exists ----
  if ! command -v localedef >/dev/null 2>&1; then
    echo "ERROR: localedef not found. Install glibc-locales or glibc-common for your distro."
    exit 1
  fi
  # ---- Backup existing installed files if present ----
  echo "Preparing backup directory (if needed): $BACKUP_DIR"
  sudo mkdir -p "$BACKUP_DIR"
  if [[ -f "$INST_NUMERIC" ]]; then
    echo "Backing up existing $INST_NUMERIC"
    sudo cp -a "$INST_NUMERIC" "$BACKUP_DIR/"
  fi
  if [[ -f "$INST_MONETARY" ]]; then
    echo "Backing up existing $INST_MONETARY"
    sudo cp -a "$INST_MONETARY" "$BACKUP_DIR/"
  fi

  # ---- Install .src files into /usr/share/i18n/locales ----
  echo "Installing locale source files to $LOCALE_DIR..."
  sudo install -m 644 "$SRC_NUMERIC" "$INST_NUMERIC"
  sudo install -m 644 "$SRC_MONETARY" "$INST_MONETARY"
  echo "Installed:"
  echo "  $INST_NUMERIC"
  echo "  $INST_MONETARY"

  echo "Compiling locales with localedef..."
  sudo localedef -i "$INST_NUMERIC" -f UTF-8 "$LOCALE_NUMERIC_NAME"
  sudo localedef -i "$INST_MONETARY" -f UTF-8 "$LOCALE_MONETARY_NAME"
  info "Compiled:"
  info "  $LOCALE_NUMERIC_NAME"
  info "  $LOCALE_MONETARY_NAME"

  # ---- Verify locales are available ----
  echo "Verifying compiled locales are present in locale -a..."
  if locale -a | grep -qx "$LOCALE_NUMERIC_NAME"; then
    echo "OK: $LOCALE_NUMERIC_NAME present"
  else
    echo "ERROR: $LOCALE_NUMERIC_NAME not found in locale -a"
    exit 1
  fi

  if locale -a | grep -qx "$LOCALE_MONETARY_NAME"; then
    echo "OK: $LOCALE_MONETARY_NAME present"
  else
    echo "ERROR: $LOCALE_MONETARY_NAME not found in locale -a"
    exit 1
  fi

  # ---- Symlink locale.conf if present in dotfiles ----
  if [[ -f "$LOCALE_CONF_SRC" ]]; then
    echo "Linking ~/.config/locale.conf → $LOCALE_CONF_SRC"
    mkdir -p "$HOME/.config"
    ln -sf "$LOCALE_CONF_SRC" "$HOME/.config/locale.conf"
    echo "Symlink created."
  else
    echo "No locale.conf found in $DOTFILES; skipping symlink."
  fi

  # ---- Quick smoke tests (non-invasive) ----
  echo
  echo "Smoke tests (per-process, does not change system-wide settings):"
  echo "1) Numeric formatting test (should use '.' decimal and space thousands):"
  # LC_NUMERIC="$LOCALE_NUMERIC_NAME"
  # printf "Number: %'0.2f\n" 1234567.89 || true

  echo "2) Monetary formatting test (should show '1 234 567.89 €' or similar):"
  # LC_MONETARY="$LOCALE_MONETARY_NAME"
  # perl -e 'use locale; use POSIX qw(locale_h); setlocale(LC_MONETARY, $ENV{LC_MONETARY}); printf("%s\n", sprintf("%'.2f", 1234567.89));' || true

  echo "If the smoke tests look correct, you can reference these locales in ~/.config/locale.conf:"
  echo "  LC_NUMERIC=$LOCALE_NUMERIC_NAME"
  echo "  LC_MONETARY=$LOCALE_MONETARY_NAME"
  echo
  echo "Done."
  ;;

"windows")
  fail "to-do"
  exit 1
  ;;

"macos")
  fail "to-do"
  ;;

*) ;;
esac
