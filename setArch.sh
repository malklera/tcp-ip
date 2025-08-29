# Check if running as root
if [[ $EUID -ne 0 ]]; then
   log_error "This script must be run as root. Please use 'sudo ./setArch.sh'"
   exit 1
fi

# Get the original user who invoked sudo
ORIGINAL_USER="${SUDO_USER:-$(whoami)}"
# Get the home directory of the original user
HOME_DIR=$(eval echo "~$ORIGINAL_USER")

log_info "Starting Arch Linux setup script for user: $ORIGINAL_USER..."

# Update System Before Starting
log_info "Updating system packages..."
pacman -Syu --noconfirm || log_error "Failed to update system."

# Network Manager
log_info "Installing and enabling NetworkManager..."
pacman -S --needed --noconfirm networkmanager || log_error "Failed to install networkmanager."
pacman -S --needed --noconfirm network-manager-applet || log_error "Failed to install network-manager-applet."
systemctl enable NetworkManager.service || log_error "Failed to enable NetworkManager.service."

# Set up SSH
log_info "Setting up OpenSSH..."
pacman -S --needed --noconfirm openssh || log_error "Failed to install openssh."

# Git
log_info "Installing Git and configuring global settings..."
pacman -S --needed --noconfirm git || log_error "Failed to install git."

# Configure Git for the original user
sudo -u "$ORIGINAL_USER" git config --global user.name "$GIT_USERNAME"
sudo -u "$ORIGINAL_USER" git config --global init.defaultBranch main


# Get backup configs (tcp-ip repository)
log_info "Attempting to clone 'tcp-ip' repository..."
if sudo -u "$ORIGINAL_USER" git clone https://github.com/malklera/tcp-ip.git "$HOME_DIR/tcp-ip"; then
    log_success "Successfully cloned 'tcp-ip' repository using basic HTTPS."
else
    log_error "Failed to clone 'tcp-ip' repository using any method. Please clone it manually into $HOME_DIR/tcp-ip."
fi

# Change keyboard layout
log_info "Copying custom keyboard layout and setting it..."
if [ -f "$HOME_DIR/tcp-ip/assets/keyboardLayout/custom" ]; then
    cp "$HOME_DIR/tcp-ip/assets/keyboardLayout/custom" /usr/share/xkeyboard-config-2/symbols/ || log_error "Failed to copy custom keyboard layout."
    log_success "Custom keyboard layout copied."
else
    log_error "$HOME_DIR/tcp-ip/assets/keyboardLayout/custom not found. Keyboard layout not changed."
fi

# AUR helper (yay)
log_info "Setting up Yay (AUR helper)..."
pacman -S --needed --noconfirm base-devel || log_error "Failed to install base-devel (required for yay)."

if [ -d "$HOME_DIR/yay" ]; then
    log_warning "Yay directory already exists in $HOME_DIR. Removing it to perform a clean install."
    sudo rm -rf "$HOME_DIR/yay"
fi

sudo -u "$ORIGINAL_USER" git clone https://aur.archlinux.org/yay.git "$HOME_DIR/yay" || log_error "Failed to clone yay repository."
cd "$HOME_DIR/yay" || log_error "Failed to change directory to $HOME_DIR/yay."
sudo -u "$ORIGINAL_USER" makepkg -si --noconfirm || log_error "Failed to install yay."
cd - || log_error "Failed to change back from yay directory."

log_info "Running yay post-installation commands as $ORIGINAL_USER..."
sudo -u "$ORIGINAL_USER" yay -Y --gendb || log_error "Failed to run yay --gendb."
sudo -u "$ORIGINAL_USER" yay -Syu --devel --noconfirm || log_error "Failed to run yay -Syu --devel."
sudo -u "$ORIGINAL_USER" yay -Y --devel --save || log_error "Failed to run yay --devel --save."

log_info "Cleaning up yay build directory..."
sudo rm -r "$HOME_DIR/yay" || log_error "Failed to remove yay build directory."
log_success "Yay installed and configured."

# Text editors
log_info "Installing Vim and Neovim dependencies..."
pacman -S --needed --noconfirm vim || log_error "Failed to install vim."

# Basics
log_info "Installing basic utilities (man, curl, wget, unzip, tldr)..."
pacman -S --needed --noconfirm man || log_error "Failed to install man."
pacman -S --needed --noconfirm tldr || log_error "Failed to install tldr"

# Copy bash backup files
if [ -d "$HOME_DIR/forArch/.bashrc" ]; then
    sudo -u "$ORIGINAL_USER" cp "$HOME_DIR/forArch/.bashrc" "$HOME_DIR/" || log_error "Failed to copy .bashrrc."
    log_success "Bash configurations copied for $ORIGINAL_USER."
else
    log_error "$HOME_DIR/forArch/.bashrc not found. Bash configs not copied."
fi

# Allow copy-paste between vm and main machine
log_info "Installing spice-vdagent(copy-paste)..."
pacman -S --needed --noconfirm spice-vdagent || log_error "Failed to install spice-vdagent."
