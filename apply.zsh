#!/bin/env zsh

# Stop execution if any command fails
set -eo pipefail

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print colored headers with dynamic width
print_header() {
    local title="$1"
    local width=80
    local title_len=${#title}
    local padding=$(((width - title_len - 4) / 2))
    local left_padding=$(printf "%*s" $padding "")
    local right_padding=$(printf "%*s" $((width - title_len - 4 - padding)) "")
    
    echo ""
    echo -e "${CYAN}${BOLD}┌$(printf '─%.0s' {1..$((width-2))})┐${NC}"
    echo -e "${CYAN}${BOLD}│${left_padding}${WHITE}${BOLD}${title}${NC}${CYAN}${BOLD}${right_padding}│${NC}"
    echo -e "${CYAN}${BOLD}└$(printf '─%.0s' {1..$((width-2))})┘${NC}"
    echo ""
}

# Function to print step info with enhanced styling
print_step() {
    local step_num="$1"
    local description="$2"
    echo -e "${PURPLE}${BOLD}╭─────────────────────────────────────────────────────────────────────────────╮${NC}"
    echo -e "${PURPLE}${BOLD}│${NC} ${YELLOW}${BOLD}🚀 Step ${step_num}:${NC} ${WHITE}${description}${PURPLE}${BOLD} │${NC}"
    echo -e "${PURPLE}${BOLD}╰─────────────────────────────────────────────────────────────────────────────╯${NC}"
    echo ""
}

# Function to print success message
print_success() {
    echo -e "${GREEN}${BOLD}✅ SUCCESS:${NC} ${GREEN}$1${NC}"
}

# Function to print info message
print_info() {
    echo -e "${BLUE}${BOLD}ℹ️  INFO:${NC} ${BLUE}$1${NC}"
}

# Function to print warning message
print_warning() {
    echo -e "${YELLOW}${BOLD}⚠️  WARNING:${NC} ${YELLOW}$1${NC}"
}

# Function to print progress bar
print_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    
    printf "\r${CYAN}${BOLD}Progress: [${NC}"
    printf "${GREEN}%*s${NC}" $filled "" | tr ' ' '█'
    printf "${WHITE}%*s${NC}" $empty "" | tr ' ' '░'
    printf "${CYAN}${BOLD}] ${percentage}%% (${current}/${total})${NC}"
    
    if [ $current -eq $total ]; then
        echo ""
    fi
}

# Function to print section divider
print_divider() {
    echo ""
    echo -e "${PURPLE}${BOLD}$(printf '═%.0s' {1..80})${NC}"
    echo ""
}

# Start of main script
print_header "🍺 Installing Homebrew and Git"
print_step "1/6" "Setting up package manager and version control"

print_info "Installing Homebrew package manager..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
print_success "Homebrew installed successfully!"

print_info "Installing Git version control system..."
brew install git
print_success "Git installed successfully!"
print_progress 1 6

print_divider
print_header "📦 Downloading Dotfiles Repository"
print_step "2/6" "Cloning configuration files from GitHub"

print_info "Navigating to home directory..."
cd ~
print_info "Cloning dotfiles repository..."
git clone https://github.com/bad-noodles/.dotfiles.git
cd .dotfiles
print_success "Dotfiles repository cloned successfully!"
print_progress 2 6

print_divider
print_header "🔧 Installing Development Tools"
print_step "3/6" "Installing applications and dependencies via Homebrew"

print_info "Reading Brewfile and installing packages..."
brew bundle
print_success "All Homebrew dependencies installed successfully!"
print_progress 3 6

print_divider
print_header "🔗 Creating Configuration Symlinks"
print_step "4/6" "Linking dotfiles to home directory"

print_warning "Backing up existing .zprofile and .zshrc files..."
if [ -f ~/.zprofile ]; then
    mv ~/.zprofile ~/.zprofile_bkp
    print_info "Backed up existing .zprofile to .zprofile_bkp"
fi
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc_bkp
    print_info "Backed up existing .zshrc to .zshrc_bkp"
fi

print_info "Creating symbolic links with GNU Stow..."
stow --target=$HOME .
print_success "Configuration symlinks created successfully!"
print_progress 4 6

print_divider
print_header "⚡ Setting Up Zsh Plugin Manager"
print_step "5/6" "Installing zgenom for Zsh plugin management"

print_info "Cloning zgenom plugin manager..."
git clone https://github.com/jandamm/zgenom.git ".config/zgenom"
print_success "Zgenom plugin manager installed successfully!"
print_progress 5 6

print_divider
print_header "🚀 Launching Terminal Application"
print_step "6/6" "Opening WezTerm for final setup"

print_info "Opening WezTerm application..."
print_info "Zsh plugins will be automatically installed on first launch"
open /Applications/WezTerm.app
print_success "WezTerm launched successfully!"
print_progress 6 6

print_divider
echo -e "${GREEN}${BOLD}"
echo "🎉 SETUP COMPLETE! 🎉"
echo ""
echo "Your development environment is now ready!"
echo "• All applications and tools have been installed"
echo "• Configuration files are properly linked"
echo "• Zsh plugins will load automatically in your new terminal"
echo ""
echo "Enjoy your new dotfiles setup! ✨"
echo -e "${NC}"

