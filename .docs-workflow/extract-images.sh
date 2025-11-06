#!/bin/bash

# extract-images.sh
# Helper script to batch extract images from video using ffmpeg
#
# Usage:
#   ./extract-images.sh <video-file> <output-directory> <timestamps-file>
#
# Example:
#   ./extract-images.sh demo.mp4 static/img/help/reports/custom-reports timestamps.txt
#
# timestamps.txt format (one per line):
#   00:15 step-1.png
#   00:28 step-2.png
#   01:05 step-3.png

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to show usage
show_usage() {
    cat << EOF
Usage: $0 <video-file> <output-directory> <timestamps-file>

Arguments:
  video-file        Path to the input video file (e.g., demo.mp4)
  output-directory  Directory where images will be saved (e.g., static/img/help/reports/custom-reports)
  timestamps-file   Text file containing timestamps and filenames

Timestamps file format (one per line):
  00:15 step-1.png
  00:28 step-2.png
  01:05 step-3.png
  HH:MM:SS step-4.png

Examples:
  $0 demo.mp4 static/img/help/reports/custom-reports timestamps.txt
  $0 ~/Videos/recording.mp4 static/img/help/account/create-team times.txt

Quality options (edit script to change):
  -q:v 2    High quality (default, larger file size)
  -q:v 5    Medium quality
  -q:v 8    Lower quality (smaller file size)

EOF
}

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    print_error "ffmpeg is not installed!"
    echo ""
    echo "Install ffmpeg:"
    echo "  Ubuntu/Debian: sudo apt-get install ffmpeg"
    echo "  macOS:         brew install ffmpeg"
    echo "  Windows:       Download from https://ffmpeg.org/download.html"
    exit 1
fi

# Check arguments
if [ $# -ne 3 ]; then
    print_error "Invalid number of arguments"
    echo ""
    show_usage
    exit 1
fi

VIDEO_FILE="$1"
OUTPUT_DIR="$2"
TIMESTAMPS_FILE="$3"

# Validate video file exists
if [ ! -f "$VIDEO_FILE" ]; then
    print_error "Video file not found: $VIDEO_FILE"
    exit 1
fi

# Validate timestamps file exists
if [ ! -f "$TIMESTAMPS_FILE" ]; then
    print_error "Timestamps file not found: $TIMESTAMPS_FILE"
    exit 1
fi

# Create output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    print_info "Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

# Get absolute path for video file
VIDEO_FILE_ABS=$(realpath "$VIDEO_FILE")

print_info "Video file: $VIDEO_FILE_ABS"
print_info "Output directory: $OUTPUT_DIR"
print_info "Timestamps file: $TIMESTAMPS_FILE"
echo ""

# Read timestamps file and extract images
line_number=0
success_count=0
error_count=0

while IFS= read -r line || [ -n "$line" ]; do
    line_number=$((line_number + 1))

    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

    # Parse timestamp and filename
    timestamp=$(echo "$line" | awk '{print $1}')
    filename=$(echo "$line" | awk '{print $2}')

    # Validate format
    if [ -z "$timestamp" ] || [ -z "$filename" ]; then
        print_warning "Line $line_number: Invalid format, skipping: $line"
        continue
    fi

    output_path="$OUTPUT_DIR/$filename"

    print_info "Extracting: $filename at timestamp $timestamp"

    # Run ffmpeg command
    # -ss: seek to timestamp
    # -i: input file
    # -frames:v 1: extract exactly one frame
    # -q:v 2: quality (2 is high quality for JPEG, 1-31 scale)
    # -y: overwrite output files without asking
    if ffmpeg -ss "$timestamp" -i "$VIDEO_FILE_ABS" -frames:v 1 -q:v 2 "$output_path" -y -loglevel error 2>&1; then
        print_success "Created: $output_path"
        success_count=$((success_count + 1))
    else
        print_error "Failed to extract: $filename at $timestamp"
        error_count=$((error_count + 1))
    fi

done < "$TIMESTAMPS_FILE"

echo ""
echo "============================================"
print_info "Extraction complete!"
print_success "Successfully extracted: $success_count images"
if [ $error_count -gt 0 ]; then
    print_error "Failed: $error_count images"
fi
echo "============================================"
echo ""

# List generated files
print_info "Generated files in $OUTPUT_DIR:"
ls -lh "$OUTPUT_DIR"/*.png "$OUTPUT_DIR"/*.jpg 2>/dev/null || true

echo ""
print_info "Next steps:"
echo "  1. Review images: open $OUTPUT_DIR"
echo "  2. Optimize images: cd $OUTPUT_DIR && optipng -o2 *.png"
echo "  3. Test documentation: npm start"
echo "  4. Commit changes: git add $OUTPUT_DIR && git commit -m 'docs: add screenshots'"

exit 0
